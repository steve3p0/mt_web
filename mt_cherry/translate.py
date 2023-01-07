import cherrypy
import sqlite3
import logging
import json
import subprocess
import os
import xmlrpc
import requests

# mt engines
import google_translate
#import translation_pipeline

from unidecode import unidecode
#from operator import itemgetter
#from google.cloud import translate

# This is required for Python 2.7
# reload(sys)
# sys.setdefaultencoding('utf8')

########   Deployment Notes   #############################################
# sudo pip install uuid
######## Google Cloud Globals #############################################
HOME_PATH = "/home/ubuntu/mosesdecoder/"
DB_STRING = "db/mt.sqlite"
HOSTNAME_LOCAL = { "localhost", "autom8tr8n.com" }												
SERVER_SOCKET_HOST = "0.0.0.0"
SERVER_SOCKET_PORT = 80

logging.basicConfig(#level=logging.DEBUG,  (NOTSET, DEBUG, INFO, WARNING, ERROR, CRITICAL)
                    level=logging.CRITICAL, # Basically turn Logging off
                    format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filename='translate.log',
                    filemode='w')


class ITranslate:
    def show(self):
        raise NotImplementedError


class GoogleTranslate(ITranslate):
    def show(self):
        logging.debug("GoogleTranslate(ITranslate)")
        print("Hello World!")


class Moses(object):
    def __init__(self, path):
        logging.debug("Moses.__init__(self, path)")
        self.tokenizer_path = path

    def _call(self, lang, text, script_path):
        logging.debug("Moses._call(self, lang, text, script_path)")
        pipe = subprocess.Popen(["perl", script_path, "-l", lang], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
        s = pipe.communicate(text)[0].strip()
        logging.debug("Moses._call(self, lang, text, script_path): s = ")
        return s


class Security(object):
    def __init__(self):
        logging.debug("Security.__init__(self, path)")
        self.data = Data()

    def _get_hostname(self):
        logging.debug("Security._get_hostname(self)")

        return "localhost"

    def _generate_key(self):
        import uuid
        return uuid.uuid4()

    def authenticate(self, key=None):
        logging.debug("Security.authenticate(self, key=None): key = (" + str(key) + ")")
        if key is None:
            hostname = self._get_hostname()
            logging.debug("authenticate(self, key=None): hostname: " + hostname)

            if hostname in HOSTNAME_LOCAL:
                msg = "Authorization Key Not Required."
                logging.debug("authenticate(self, key=None): msg = (" + msg + "), hostname: " + hostname)
                return True, msg
            msg = "Access Denied. Authorization Key Required."
            logging.debug("authenticate(self, key=None): msg = (" + msg + "), hostname: " + hostname)
            return False, msg

        secure, msg = self.data.authenticate(key)
        if not secure:
            logging.debug("Security.authenticate(self, key=None): msg = " + msg)
            return secure, msg
        return secure, msg

    def registered(self, username):
        return self.data.registered(username)

    def register_user(self, username, expiration):
        logging.debug("Security.register_user(...)")

        # Check if user is already registered
        if (self.registered(username)):
            return "Error: User '" + username + "' already exists."

        key = self._generate_key()
        return self.data.create_user(self, username, expiration)

    # def disable_user(self, username):
    #     logging.debug("Security.disable_user(...)")
    #
    #     # Check if user is registered
    #     if not self.registered(username):
    #         return "Error: No such user '" + username + "' exists."
    #
    #     key = self._generate_key()
    #     return self.data.create_user(self, username)
    #
    # def extend_registration(self, username, expiration):
    #     return False


class Data(object):
    def _insert_user_key(self, cursor, key, username, expiration):
        logging.debug("Data._insert_user_key(...)")
        description = 'Authorization Key for User'

        try:
            insert = 'INSERT INTO Key (Username, Key, Description, ExpireDate) '
            values = 'VALUES (?, ?, ?, ?);'

            c = cursor.execute(insert + values, (username, key, description, expiration))

            print("c.lastrowid: " + str(c.lastrowid))

            if c.lastrowid > 0:
                # msg = "Authentication key '" + key + "' for user '" + username + "' inserted. "
                msg = "success"
                logging.debug("Data._insert_user_key: true")
                return True, msg

            logging.debug("Data._insert_user_key: false")
            msg = "failure"
            print("_insert_user_key - msg = " + msg)
            return key

        except sqlite3.Error as e:
            msg = e.message
            print("_insert_user_key - Exception (e.message) = " + e.message)
            logging.debug("Data.insert_user_key: error - " + msg)
            return msg

    # def _extend_registration(self, cursor, username, expiration):
    #     logging.debug("Data._extend_registration(self, key)")
    #
    #     try:
    #         # prev_rowid = cursor.lastrowid
    #         update = 'UPDATE Key SET Enabled = 1, ExpireDate = ? '
    #         where  = 'Username = ?;'
    #
    #         c = cursor.execute(update + where, (username,  expiration))
    #         print("c.lastrowid: " + str(c.lastrowid))
    #
    #         if c.lastrowid > 0:
    #             msg = "success"
    #             logging.debug("Data._extend_registration: true")
    #             return True, msg
    #
    #         logging.debug("Data._extend_registration: false")
    #         msg = "failure"
    #         print("_extend_registration - msg = " + msg)
    #         return key
    #
    #     except sqlite3.Error as e:
    #         msg = e.message
    #         print("_create_user_key - Exception (e.message) = " + e.message)
    #         logging.debug("Data.insert_user_key: error - " + msg)
    #         return msg

    def authenticate(self, key):
        logging.debug("Data.authenticate(self, key)")
        with sqlite3.connect(DB_STRING) as c:
            #cherrypy.session['ts'] = time.time()
            r = c.execute("SELECT COUNT(*) FROM Key WHERE Enabled = 1 AND ExpireDate > DATE('now') AND Key = '" + key + "'")
            result = r.fetchone()
            rows = result[0]

            if rows > 0:
                msg = "Authorization Key Valid."
                logging.debug("Data.authenticate(self, key): msg = " + msg)
                return True, msg

            msg = "Access Denied.  Authorization Key Invalid."
            logging.debug("Data.authenticate(self, key): msg = " + msg)
            return False, msg

    def port(self, source, target):
        logging.debug("Data.port(self, source, target)")
        with sqlite3.connect(DB_STRING) as c:
            #cherrypy.session['ts'] = time.time()
            sql = """ SELECT lp.Port FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
                        INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID """
            criteria = " WHERE Enabled = 1 AND sl.CODE = '" + source.upper() + "' AND tl.CODE = '" + target.upper() + "'"
            r = c.execute(sql + criteria)
            result = r.fetchone()

            if result is None:
                logging.debug("Data.port(self, source, target): Did not find port for language pair")
                #raise exception
                return None

            logging.debug("Data.port(self, source, target): port = " + str(result[0]))
            return result[0]

    def all_language_pairs(self):
        logging.debug("Data.all_language_pairs(self)")
        with sqlite3.connect(DB_STRING) as c:
            #cherrypy.session['ts'] = time.time()
            sql = """ SELECT sl.CODE || '>' || tl.CODE,
                             sl.Name || '>' || tl.Name
                      FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
                        INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID """
            criteria = " WHERE Enabled = 1"
            c.text_factory = str
            r = c.execute(sql + criteria)
            result = r.fetchall()

            if result is None:
                logging.debug("Data.all_language_pairs(self): Error - No enabled language pairs found.")
                # raise exception???
                return None

            logging.debug("Data.all_language_pairs(self): language pairs = " + str(result))
            return result

    def language_pairs(self, lang):
        logging.debug("Data.language_pairs(self, lang)")
        with sqlite3.connect(DB_STRING) as c:
            #cherrypy.session['ts'] = time.time()
            sql = """ SELECT sl.CODE || '>' || tl.CODE,
                             sl.Name || '>' || tl.Name
                      FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
                        INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID """
            criteria = " WHERE Enabled = 1 AND (sl.CODE = '" + lang.upper() + "' OR tl.CODE = '" + lang.upper() + "')"
            c.text_factory = str
            r = c.execute(sql + criteria)
            result = r.fetchall()

            if result is None:
                logging.debug("Data.language_pairs(self, lang): Error - No language pairs found with '" + lang + "'.")
                # raise exception ???
                return None

            logging.debug("Data.language_pairs(self, lang): language pairs = " + str(result))
            return result

    def source_languages(self, target):
        logging.debug("Data.source_languages(self, target)")
        with sqlite3.connect(DB_STRING) as c:
            sql = """ SELECT sl.Code, sl.Name, sl.TextDirection FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
                        INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID """
            criteria = "WHERE Enabled = 1 AND tl.Code = '" + target.upper() + "' "
            sort_order = "ORDER BY sl.Name;"
            c.text_factory = str
            r = c.execute(sql + criteria + sort_order)
            result = r.fetchall()

            if result is None:
                logging.debug("Data.source_languages(self, target): Error - No source languages found for target '" + target + "'.")
                # raise exception??
                return None

            logging.debug("Data.source_languages(self, target): languages = " + str(result))
            return result

    def source_languages_all(self):
        logging.debug("Data.source_languages_all(self)")
        with sqlite3.connect(DB_STRING) as c:
            sql = """ SELECT DISTINCT sl.Code, sl.Name, sl.TextDirection FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID """
            criteria = " WHERE Enabled = 1 ORDER BY sl.Name;"

            c.text_factory = str
            r = c.execute(sql + criteria)
            result = r.fetchall()

            if result is None:
                logging.debug("Data.source_languages_all(self): Error - No source languages found.")
                # raise exception
                return None

            logging.debug("Data.source_languages_all(self): raw data from sql: " + str(result))
            return result

    def target_languages(self, source):
        logging.debug("Data.target_languages(self, source)")
        with sqlite3.connect(DB_STRING) as c:
            #cherrypy.session['ts'] = time.time()
            sql = """ SELECT DISTINCT tl.Code, tl.Name, tl.TextDirection FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID
                        INNER JOIN Language tl ON lp.TargetLanguageID = tl.LanguageID """
            criteria = "WHERE Enabled = 1 AND sl.CODE = '" + source.upper() + "' "
            sort_order = "ORDER BY tl.Name;"
            c.text_factory = str
            r = c.execute(sql + criteria + sort_order)
            result = r.fetchall()

            if result is None:
                logging.debug("Data.target_languages(self, source): Error - No source languages found.")
                # raise exception
                return None

            logging.debug("Data.target_languages(self, source): languages = " + str(result))
            return result

    def check_source_language(self, source):
        logging.debug("Data.check_source_language(self, source)")
        with sqlite3.connect(DB_STRING) as c:
            #cherrypy.session['ts'] = time.time()
            sql = """ SELECT COUNT(*) FROM LanguagePair lp
                        INNER JOIN Language sl ON lp.SourceLanguageID = sl.LanguageID """
            criteria = " WHERE Enabled = 1 AND sl.CODE = '" + source.upper() + "'"
            c.text_factory = str
            r = c.execute(sql + criteria)
            logging.debug("Data.check_source_language(self, source): sql = " + sql + criteria)
            result = r.fetchone()
            rows = result[0]

            if rows > 0:
                msg = "Source language exists."
                logging.debug("Data.check_source_language(self, source): msg = " + msg)
                return True, msg

            msg = "Source language does not exist in any enabled language pair."
            logging.debug("Data.check_source_language(self, source): msg = " + msg)
            return False, msg

    def language_variant_map(self, variant_code):
        logging.debug("Data.language_variant_map(self, variant_code): " + variant_code)
        with sqlite3.connect(DB_STRING) as c:
            # cherrypy.session['ts'] = time.time()
            sql = "SELECT PrimaryLanguageCode FROM LanguageVariant "
            criteria = "WHERE VariantCode = '" + variant_code.upper() + "' ;"
            c.text_factory = str
            logging.debug("Data.language_variant_map(self, variant_code): sql = " + sql + criteria)
            r = c.execute(sql + criteria)
            result = r.fetchone()

            if result is not None:
                primary = str(result[0])
                logging.debug("Data.language_variant_map(self, variant_code): primary = " + primary)
                return primary
            return None

    def registered(self, username):
        logging.debug("Data.registered(self, username): " + username)
        with sqlite3.connect(DB_STRING) as c:
            sql = "SELECT Enabled FROM Key "
            join = "INNER JOIN KeyType ON KeyType.KeyTypeID = Key.KeyType "
            criteria = "WHERE Username = '" + username.lower() + "'" + \
                         "AND KeyType.KeyType.Name = 'User' COLLATE NOCASE;"
            c.text_factory = str
            logging.debug("Data.language_variant_map(self, variant_code): sql = " + sql + criteria)
            r = c.execute(sql + criteria)

            result = r.fetchone()

            return (str(result["Enabled"] == int("1")))
            #return (result is not None)

    def create_user(self, key, username, expiration):
        logging.debug("Data.create_user_key(...): ")
        with sqlite3.connect(DB_STRING) as c:
            cur = c.cursor()
            success, msg = self._insert_user_key(cur, key, username, expiration)
            cur.close()

            logging.debug("TestData.test_create_user_key")
            return success, msg

    # def extend_registration(self, username, expiration):
    #     logging.debug("Data.extend_registration(...): ")
    #     with sqlite3.connect(DB_STRING) as c:
    #         cur = c.cursor()
    #         success, msg = self._insert_user_key(cur, key, username, expiration)
    #         cur.close()
    #
    #         logging.debug("TestData.test_create_user_key")
    #         return success, msg

class Translation(object):
    def __init__(self, path):
        logging.debug("Translation.__init__(self, path)")
        self.moses = Moses(path)
        self.security = Security()
        self.data = Data()

    def _tokenize(self, lang, text):
        logging.debug("Translate._tokenize(self, lang, text): lang = " + lang)
        logging.debug("Translate._tokenize(self, lang, text): text = " + text)
        if lang == "zh":
            # Chinese has to do word alignment
            # options are slim: write the text to a file
            # use NLTK Stanford NLP (python>java) to segment chinese phrase
            # then read the file and get the segmented phrase and continue
            # TODO
            # solution found (kinda) mini-segmenter
            # https://github.com/alvations/mini-segmenter
            import miniseg.minisegmenter as mini
            s = str(mini.segmenter(text)).strip()
            logging.debug("Translate._tokenize(self, lang, text): ZH - mini.segmenter s = (" + s + ")")
            return s
        else:
            s = self.moses._call(lang, text, HOME_PATH + "scripts/tokenizer/tokenizer.perl").strip()
            logging.debug("Translate._tokenize(self, lang, text): (" + s + ")")
            return s

    def _translate(self, source, target, text):
        logging.debug("Translate._translate(self, source, target, text): source = " + source + ", target = " + target)
        logging.debug("Translate._translate(self, source, target, text): input = " + text)
        port = self.data.port(source, target)
        url = "http://localhost:" + str(port) + "/RPC2"
        logging.debug("Translate._translate(self, source, target, text): url = " + url)
        #proxy = xmlrpclib.ServerProxy(url)
        proxy = xmlrpc.ServerProxy(url)
        params = {"text": text, "align": "false", "report-all-factors": "false"}
        result = proxy.translate(params)
        s = str(result['text'].encode('utf-8')).strip()
        logging.debug("Translate._translate: s = (" + s + ")")
        return s

    def _post_process(self, lang, text):
        logging.debug("Translate._post_process(self, lang, text)")
        if lang == "zh":
            # Chinese - Get rid of the spaces (word segmentation)
            text = text.replace(" ", "")

        # Post-Processes the translation output (regardless of language)
        text = text.replace("__UNK__", " ")
        #text = text.replace(" _ _ NEWLINE _ _ ", "\n")
        text = text.replace("  ", " ")
        logging.debug("Translate._post_process(self, lang, text): text = " +text)
        return text

    def _detokenize(self, lang, text):
        logging.debug("Translate._detokenize(self, lang, text)")
        if lang == "zh":
            logging.debug("Translate._detokenize(self, lang, text): ZH - No need to detokenize")
            return text
        else:
            s = self.moses._call(lang, text, HOME_PATH + "scripts/tokenizer/detokenizer.perl").strip()
            s = self._normalize_punctuation(lang, s)
            logging.debug("Translate._detokenize(self, lang, text): s = " + s)
            return s

    def _normalize_punctuation(self, lang, text):
        logging.debug("Translate._normalize_punctuation(self, lang, text)")
        s = self.moses._call(lang, text, HOME_PATH + "scripts/tokenizer/normalize-punctuation.perl").strip()
        logging.debug("Translate._normalize_punctuation(self, lang, text): s = " + s)
        return s

    def _check_source_language(self, source):
        logging.debug("Translation._check_source_language(self, source)")
        src_exists, msg = self.data.check_source_language(source)
        logging.debug("Translation._check_source_language(self, source): src_exists = (" + str(src_exists) + "), msg = (" + msg + ")")
        return src_exists, msg

    def translate(self, source, target, text, profile):
        text = text.decode("utf-8")

        source = source.upper()
        target = target.upper()

        if target == "ES":
            logging.debug("Translation.translate() EN > ES (OpenNMT)")
            text = self._tokenize(source, text)

            url = "http://127.0.0.1:5000/translator/translate" 
            data = [{'src': text, 'id': 100}]
            headers = {'Content-type': 'application/json'}
            r = requests.post(url, data=json.dumps(data), headers=headers)
            j = r.json()
            output = j[0][0]['tgt']

            output = self._detokenize(target, output)

        #output = google_translate.quick_translate(text, target, source)
        # Hack for Hindi
        elif "HI" in (source, target):
           output = google_translate.quick_translate(text, target, source)
        elif "SR" == source:
            source = "Srp"
            target = "Eng"
            
            logging.debug("Translation.translate() Srp = Eng")
            # translate('MiniLang.pgf', 'Eng', 'Srp', "John loves books", 1)
            output = translation_pipeline.translate('MiniLang.pgf', source, target, text, 1)
        #elif "SR" in (source, target):
        elif "SR" == target:
            bestK = 1
            pgf_path = "MiniLang.pgf"
            source = "Eng"
            target = "Srp"
            #text = str(text)
            #text = text.encode('ascii', 'ignore')
            text = unidecode(text)

            # pgf_path = "MiniLang.pgf"
            # source = "Eng"
            # target = "Srp"
            text_hardcode = "John loves books"
            #text = "John loves books"
            # bestK = 1

            text_actual = ':'.join(x.encode('hex') for x in text)
            text_hc = ':'.join(x.encode('hex') for x in text_hardcode)

            print("\n\n------------------------------")
            print("text_actual (hex): " + text_actual)
            print("text_hc (hex)    : " + text_hc)

            print("PGF: "    + pgf_path)
            print("source: " + source)
            print("target: " + target)
            print("text: ("  + text + ")")
            print("bestK: "  + str(bestK))

            print("type - text_hardcode: " + str(type(text_hardcode)))
            print("type - text: " + str(type(text)))
            print("------------------------------\n\n")

            output = translation_pipeline.translate(pgf_path, source, target, text, bestK)
            #output = translation_pipeline.translate('MiniLang.pgf', source, target, text, 1)
            print("output: " + output)

        else:
            text = self._tokenize(source, text)
            output = self._translate(source, target, text)
            output = self._post_process(target, output)
            output = self._detokenize(target, output)

        output = str(output).strip()

        return output

class TranslateWebService(object):
    def __init__(self):
        logging.debug("TranslateWebService.__init__(self, path)")
        self.security = Security()
        self.data = Data()
        self.translation = Translation(HOME_PATH)

    @cherrypy.expose
    def index(self):
        logging.debug("TranslateWebService.index(self)")
        return open('index.html')

    @cherrypy.expose
    def translate(self, source, target, input=None, profile=None, key=None, sourceText=None):
        # Note: sourceText=None is provided for backward compatibility
        logging.debug("TranslateWebService.translate(self, source, target, input=None, srcText=None, key=None)")
        secure, msg = self.security.authenticate(key)
        if not secure:
            logging.debug("TranslateWebService.translate(self, source, target, text, key=None): Not Secure")
            return msg

        if input is not None:
            text = input.decode("utf-8")
        elif sourceText is not None:
            text = sourceText.decode("utf-8")
        else:
            cherrypy.log("TranslateWebService.translate: Error: Missing parameter for Translate function.")
            msg = "Error: Missing parameter for Translate function. No text to translate.  Please set the paramenter 'input' or 'sourceText'."
            return msg

        output = self.translation.translate(source, target, text, profile)
        cherrypy.log("TranslateWebService.translate(self, source, target, input, key=None): output = (" + output + ")")

        return output

    @cherrypy.expose
    def detect(self, input=None, key=None, sourceText=None):
        logging.debug("Translate.detect(self, input=None, key=None, sourceText=None)")
        secure, msg = self.security.authenticate(key)
        if not secure:
            logging.debug("detect(self, text, key=None): msg = " + msg)
            return msg

        if input is not None:
            text = input.decode("utf-8")
        elif sourceText is not None:
            text = sourceText.decode("utf-8")
        else:
            cherrypy.log("Translate.translate: Error: Missing parameter for Transate function.")
            msg = "Error: Missing parameter for Transate function. No text to translate.  Please set the paramenter 'input' or 'sourceText'."
            return msg

        # from langdetect import detect_langs
        # res = detect_langs(text.decode('utf-8'))
        from langdetect import detect
        # res = detect(text.decode('utf-8'))
        # res = detect(text.encode('utf-8'))
        res = detect(text)
        res = str(res).upper()
        # logging.debug("Translate.detect(self, text, key=None): all results: " + str(res))
        logging.debug("Translate.detect(self, text, key=None): res: " + res)

        # Check to see if there is a language map
        primary = self.data.language_variant_map(res)
        if primary is None:
            primary = res
        src_exists, msg = self.translation._check_source_language(primary)
        if src_exists:
            logging.debug("Translate.detect(self, text, key=None): msg = " + primary)
            return primary.lower()

        return None

    @cherrypy.expose
    def languages(self, lang=None, source=None, target=None, key=None):
        logging.debug("Translate.languages(...)")
        secure, msg = self.security.authenticate(key)
        if not secure:
            logging.debug("languages(self, lang=None, source=None, target=None, key=None): msg = " + msg)
            return msg
        if all(param is None for param in (lang, source, target)):
            logging.debug("Translate.data.all_language_pairs()")
            langs = self.data.all_language_pairs()
            langs = [{"Code": a, "Name": b} for a, b in langs]
            logging.debug("Translate.languages(source='All'): dictionary of tuples: " + str(langs))
            langs = json.dumps(langs)
            logging.debug("Translate.data.all_language_pairs() - json: " + langs)
        elif lang is not None:
            logging.debug("Translate.data.language_pairs(lang)")
            langs = self.data.language_pairs(lang)
            langs = [{"Code": a, "Name": b} for a, b in langs]
            logging.debug("Translate.language_pairs(lang)'): dictionary of tuples: " + str(langs))
            langs = json.dumps(langs)
            logging.debug("Translate.data.language_pairs(lang) - json: " + langs)
        elif source == "all":
            logging.debug("Translate.languages(source='All')")
            langs = self.data.source_languages_all()
            langs = [{"Code": a, "Name": b, "TextDirection": c} for a, b, c in langs]
            logging.debug("Translate.languages(source='All'): dictionary of tuples: " + str(langs))
            langs = json.dumps(langs)
            logging.debug("Translate.languages(source='All'): json: " + langs)
        elif source is not None:
            logging.debug("Translate.languages(source is not None) - Get targets")
            langs = self.data.target_languages(source)
            langs = [{"Code": a, "Name": b, "TextDirection": c} for a, b, c in langs]
            logging.debug("Translate.languages(source is not None) - Get Targets: dictionary of tuples: " + str(langs))
            langs = json.dumps(langs)
            logging.debug("Translate.languages(source is not None) - Get Targets: json: " + langs)
        elif target is not None:
            logging.debug("Translate.languages(target is not None) - Get source languages")
            langs = self.data.source_languages(target)
            langs = [{"Code": a, "Name": b, "TextDirection": c} for a, b, c in langs]
            logging.debug(
                "Translate.languages(target is not None) - Get Source Langs: dictionary of tuples: " + str(langs))
            langs = json.dumps(langs)
            logging.debug("Translate.languages(target is not None) - Get Source Langs: json: " + langs)

        else:
            return "Error: languages - all parameters are None."

        logging.debug("languages(self, lang=None, source=None, target=None, key=None): langs = " + str(langs))
        return langs

    @cherrypy.expose
    def register(self, username, expiration, key, disable=None, extend=None):
        logging.debug("TranslateWebService.register(...)")

        secure, msg = self.security.authenticate(key)
        if not secure:
            logging.debug("Security.register(...): msg = " + msg)
            return msg

        # Check if this is a disable or extend request
        if (disable.lower() == "true"):
            return self.security.disable_user(username)
        elif (extend.lower() == "true"):
            return self.security.extend_registration(username, expiration)

        return self.security.register_user(username, expiration)

if __name__ == '__main__':
    conf = {
        '/': {
            'tools.sessions.on': True,
            'tools.staticdir.root': os.path.abspath(os.getcwd())
        },
        '/generator': {
            'request.dispatch': cherrypy.dispatch.MethodDispatcher(),
            'tools.response_headers.on': True,
            'tools.response_headers.headers': [('Content-Type', 'text/plain')],
        },
        '/static': {
            'tools.staticdir.on': True,
            'tools.staticdir.dir': './public'
        }
    }

    cherrypy.config.update({'server.socket_host': SERVER_SOCKET_HOST })
    cherrypy.config.update({'server.socket_port': SERVER_SOCKET_PORT })
    cherrypy.quickstart(TranslateWebService(), '/', conf)

