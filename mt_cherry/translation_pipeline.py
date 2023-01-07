import argparse, codecs, copy, itertools, logging, math, operator, os, os.path, re, string, sys, time
try:
  from StringIO import StringIO # Python 2 import
  from itertools import imap as map
  from itertools import ifilter as filter
except ImportError:
  pass

import pgf
import gf_utils

def pipeline_lexer(sentence):
  tokens = sentence.strip().split()
  #tokens = filter(None, re.split('(\W+)', sentence.strip()))
  n = len(tokens)
  idx = len(tokens)-1
  while idx >= 0:
    if tokens[idx] in ".?!)":
      idx -= 1
    else:
      break
  tokens = tokens[:idx+1]
  idx = 0
  while idx < len(tokens):
    if tokens[idx] in "'\"(":
      idx += 1
    else:
      break
  tokens = tokens[idx:]
  return ' '.join(tokens)

def clean_gfstrings(sentence):
  absFuncName = re.compile('\[[^]]+?\]')
  untranslatedEntries = {}
  for entry in re.findall(absFuncName, sentence):
    untranslatedEntries[entry] = untranslatedEntries.setdefault(entry, 0)+1
  for entry in untranslatedEntries:
    while untranslatedEntries[entry] > 1:
      sentence = sentence.replace(entry, '', 1)
      untranslatedEntries[entry] -= 1
    sentence = sentence.replace(entry, \
        ' '.join(entry[1:-1].split('_')[:-1]) if entry.find('_') != -1 \
        else '')
  return ' '.join( sentence.split() )

def parseNames(grammar, language, sentence):
  def callback(lin_idx, start):
    moving_start, end, eot = start, len(sentence), True
    if moving_start < end and (not sentence[moving_start].isupper()):
      return None
    while moving_start < end:
      if sentence[moving_start] in string.whitespace:
        eot = True
      elif eot and sentence[moving_start].isupper():
        eot = False
      elif eot and (not sentence[moving_start].isupper()):
        end = moving_start-1
        break
      moving_start += 1
    possible_name = sentence[start:end].strip()
    if possible_name:
      if language.endswith('Eng') and \
          (possible_name == "I" or possible_name == "I'm"):
        return None
      elif language.endswith('Eng') and possible_name.endswith("'s"):
        end_idx = possible_name.rfind("'s")
        if end_idx != -1:
          possible_name = possible_name[:end_idx].strip()
          end -= 2
          if not possible_name:
            return None
      expr, prob = None, None
      for analysis in grammar.languages[language].lookupMorpho(possible_name):
        category = grammar.functionType(analysis[0]).cat
        if prob < analysis[-1]:
          if category == "PN":
            expr, prob = pgf.Expr(analysis[0], []), analysis[-1]
          elif category == "Weekday":
            expr, prob = pgf.Expr("weekdayPN", \
                [pgf.Expr(analysis[0], [])]), analysis[-1]
          elif category == "Month":
            expr, prob = pgf.Expr("monthPN", \
                [pgf.Expr(analysis[0], [])]), analysis[-1]
          elif category == "Language":
            return None
      # generic named entity
      if expr == None:
        expr = pgf.Expr(possible_name)
        expr = pgf.Expr("MkSymb", [expr])
        expr = pgf.Expr("SymbPN", [expr])
      return (expr, 0, end)
    return None
  return callback

def parseUnknown(grammar, language, sentence):
  def callback(lin_idx, start):
    moving_start, end, eot = start, len(sentence), True
    # -- added to deal with segmentation errors like may => ma_N + Symb y
    isNewToken = (moving_start == 0) or \
        (moving_start > 1 and sentence[moving_start-1].isspace()) 
    if moving_start < end and (not sentence[moving_start].isupper()):
      while moving_start < end:
        if sentence[moving_start] in string.whitespace:
          end = moving_start
          break
        moving_start += 1
      unknown_word = sentence[start:end].strip()
      if unknown_word and isNewToken:
        count = 0
        for analysis in grammar.languages[language].lookupMorpho(unknown_word):
          count += 1
        if not count:
          expr = pgf.Expr("MkSymb", [pgf.Expr(unknown_word)])
          return (expr, 0, end)
    return None
  return callback

def pipelineParsing(grammar, language, sentences, K=20):
  #buf = [sent for sent in sentences]
  buf, sentences = itertools.tee(sentences, 2)
  parser = gf_utils.getKBestParses(grammar, language, K)
  for sent, (time, parsesBlock) in zip(buf, map(parser, sentences)):
    # print("before parser = ")
    yield (sent, parsesBlock)
    # print("after parser = ")

def translate(pgffile, srclang, tgtlang, input, bestK):
  #def translation_pipeline(props):
  # UGLY HACK FOR K-best translation: if K-best translation output format is only txt
  # if props.bestK != 1:
  #   props.format = 'txt'
  
  tgtlangs = [ tgtlang ]

  if not srclang:
    logging.critical("Mandatory option source-lang missing. Can not determine source language.")
    sys.exit(1)
    
  grammar = pgf.readPGF(pgffile)
  
  sourceLanguage = filter(None, [lang if lang[-3:] == srclang else '' for lang in grammar.languages.keys()])
  sourceLanguage = list(sourceLanguage)[0]
  logging.info("Translating from %s" %(sourceLanguage))
  
  if len(tgtlangs):
    target_langs = tgtlangs
  else:
    target_langs = filter(None, [lang[-3:] if lang != sourceLanguage \
        else '' for lang in grammar.languages.keys()])
  targetLanguages = filter(None, [lang if lang[-3:] in target_langs \
      else '' for lang in grammar.languages.keys()])
  targetLanguages = list(targetLanguages)
  logging.info("Translating into the following languages: %s" %(','.join(targetLanguages)))
  
  K = bestK if bestK != 1 else 20 # by default we look for 20 best parses
  #bestK = props.bestK
  
  # Sbraich use -i text as input stream
  logging.info("Input format is txt. Assuming one-sentence-per-line format.")
  file_line_io = StringIO(input)
  inputStream = file_line_io.readlines()
  #file_line_io = input
  inputDoc    = inputStream
  # end of: user -i text as input stream
  
  reader      = lambda X: X
  skeletonDoc = lambda X, lang: list()
  addItem     = lambda X, y: list.append(X, y) 
  writer      = lambda X: ('\n'.join(X) if bestK == 1 else \
      '\n'.join(map(gf_utils.printMosesNbestFormat, X)))
    
  translationBlocks = {}
  for tgtlang in targetLanguages+['abstract']:
    translationBlocks[tgtlang] = skeletonDoc(inputDoc, tgtlang)
    
  preprocessor  = pipeline_lexer
  postprocessor = clean_gfstrings
 
  logging.info( "Parsing text in %s" %(sourceLanguage) )
  # 1. Get Abstract Trees for sentences in source language.
  tokenized_sentences = map(preprocessor, reader(inputDoc))
  web_lexer = gf_utils.Lexer('Web', grammar, sourceLanguage).tokenize
  #print("before parse")
  absParses  = [parsesBlock for parsesBlock in \
      pipelineParsing(grammar, sourceLanguage, \
      map(web_lexer, tokenized_sentences), K)]
  #print("after parse")

  logging.info( "Linearizing into %s" %(','.join(targetLanguages)) )
  # 2. Linearize in all target Languages
  for idx, parsesBlock in enumerate( map(operator.itemgetter(1), absParses) ):
    translationBuffer = {}
    bestTranslationIdx = 0
    for tgtlang in targetLanguages:
      translationBuffer[tgtlang] = next(gf_utils.getKLinearizations(grammar, \
          tgtlang, [parsesBlock], K=bestK))
      if bestK == 1:
        for tidx, translation in enumerate(translationBuffer[tgtlang]):
          if postprocessor(translation[1]).strip():
            if tidx > bestTranslationIdx:
              bestTranslationIdx = tidx
              break
    for tgtlang in targetLanguages:
      if bestK == 1:
        translation = postprocessor(translationBuffer[tgtlang][bestTranslationIdx][1]) \
            if len(translationBuffer[tgtlang]) > bestTranslationIdx \
            else ((None,), '')
        abstract = str(parsesBlock[bestTranslationIdx][1])
      else:
        translation = translationBuffer[tgtlang] \
            if len(translationBuffer[tgtlang]) \
            else []
        abstract = parsesBlock
      addItem(translationBlocks[tgtlang], translation)
    addItem(translationBlocks['abstract'], abstract)

  # for tgtlang in targetLanguages+['abstract']:
  #   logging.info( "Writing translations for %s" %(tgtlang) )
  #   print(writer(translationBlocks[tgtlang]))
  # return
    
  tgt_translation = ""
  for tgtlang in targetLanguages+['abstract']:
    logging.info( "Writing translations for %s" %(tgtlang) )
    # print(writer(translationBlocks[tgtlang]))

    tgt_translation = tgt_translation + "\n" + writer(translationBlocks[tgtlang])
  #return
  return tgt_translation.strip()

def cmdLineParser():
  argparser = argparse.ArgumentParser(prog='translation_pipeline.py', description='Run the GF translation pipeline on standard test-sets')
  argparser.add_argument('-g', '--pgf', dest='pgffile', required=True, help='PGF grammar file to run the pipeline')
  argparser.add_argument('-s', '--source', dest='srclang', default='', help='Source language of input sentences')
  argparser.add_argument('-t', '--target', dest='tgtlangs', nargs='*', default=[], help='Target languages to linearize (default is all other languages)')
  argparser.add_argument('-i', '--input', dest='input', default='', help='input file (default will accept STDIN)')
  argparser.add_argument('-K', dest='bestK', type=int, default=1, help='K value for K-best translation')
  return argparser

# def translate(pgffile, srclang, tgtlangs, input, bestK):
#   logging.info( "Starting translation using GF...")

if __name__ == '__main__':
  logging.basicConfig(level='ERROR')
  logging.info( "Starting translation using GF...")
  
  #pipelineEnv = cmdLineParser().parse_args(sys.argv[1:])
  #translation_pipeline(pipelineEnv)
  #translate(pgffile, srclang, tgtlangs, input, bestK)
  #translate('MiniLang.pgf', 'Eng', 'Srp', "John loves books", 1)
  
#output = translate('MiniLang.pgf', 'Eng', 'Srp', "John loves books", 1)
  #print(output)
