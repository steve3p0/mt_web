#!/usr/bin/env python

import urllib
import urllib2
import time

key = "4ac85ecd-dc6d-49ee-a768-602ae2192ec9"
api = "/cgi-bin/translate.py?"

adr = "https://localhost"
src = "en"
tgt = "ar"
txt = "This is a test."

def build_url(adr, src, tgt, txt):
	#querystring = "source=" + src + "&target=" + tgt + "&sourceText=" + txt + "&key=" + key
	querystring = urllib.urlencode({ 'source': src, 'target':tgt, 'sourceText': txt, 'key': key })
	
	# url = protocal + sub + "." + domain + api + querystring
	url = adr + api + querystring
	#print url
	return (url)

start = time.time()
url = build_url(adr, src, tgt, txt)
content = urllib2.urlopen(url).read()
stop = time.time()
elapsed = round(stop - start, 4)

print(str(elapsed) + " seconds: " + content)
