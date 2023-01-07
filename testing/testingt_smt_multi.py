#!/usr/bin/env python

from multiprocessing import Pool

def f(x):
    return x*x

def translate(text): #(url, users, calls):
	domain= "http://localhost:"
	port = "3004"
	url = domain + port + "/RPC2"
	proxy = xmlrpclib.ServerProxy(url)
	params = {"text": src_tok, "align": "false", "report-all-factors": "false"}

	startXmlRpc = time.time()
	result = proxy.translate(params)
	endXmlRpc = time.time()

	targetText = result['text'].encode('utf-8')

	print targetText

#if __name__ == '__main__':
p = Pool(5)     # print(p.map(f, [1, 2, 3]))
print(p.map(translate, ["this is a test .", "this is a test .", "this is a test .", "this is a test .", "this is a test ."])
