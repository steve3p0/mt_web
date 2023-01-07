import unittest
import logging
import translate
import sqlite3
from mock import patch, MagicMock
import cherrypy


logging.basicConfig(level=logging.DEBUG,
                    format='%(asctime)s %(levelname)-8s %(message)s',
                    datefmt='%a, %d %b %Y %H:%M:%S',
                    filename='test_translate.log',
                    filemode='w')

KEY = "4ac85ecd-dc6d-49ee-a768-602ae2192ec9"
DB_STRING = "mt.sqlite"


class TestTranslate_Outbound(unittest.TestCase):

    def test_translate_ensr(self):
        logging.debug("TestTranslate.test_translate_ensr: start")
        text = "Јоhn loves books"
        expect = "Јован воли граматику"
        src = "en"
        tgt = "sr"
        trn = translate.TranslateWebService()
        output = str(trn.translate(src, tgt, text, KEY))
        logging.debug("TestTranslate.test_translate_" + src + tgt + " : (" + output + ")")
        #assert output == expect

    # def test_translate_sren(self):
        # logging.debug("TestTranslate.test_translate_sren: start")
        # text = "Јован воли граматику"
        # expect = "Јоhn loves grammar"
        # src = "sr"
        # tgt = "en"
        # trn = translate.TranslateWebService()
        # output = str(trn.translate(src, tgt, text, KEY))
        # logging.debug("TestTranslate.test_translate_" + src + tgt + " : (" + output + ")")
        # #assert output == expect





