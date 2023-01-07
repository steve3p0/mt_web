#!/usr/bin/env python
import os,multiprocessing,time
import xmlrpc
from tqdm import tqdm
import urllib
import threading
import sys
import timeit

src = "en"
tgt = "fr"
txt = "This is a test."
text = "this is a test ."
trn = "c'est un test."

num_users = 10
num_calls = 1

domain = "https://localhost"
#domain = "https://mt-test.lovoco.co"
port = "3004"
url = ""
key = "4ac85ecd-dc6d-49ee-a768-602ae2192ec9"
api = "/translate?"

##########
total_process_time = 0

def build_url(adr, src, tgt, txt):
    querystring = urllib.urlencode({'source': src, 'target': tgt, 'text': txt, 'key': key})
    url = adr + api + querystring
    return (url)

def build_test_data(url, num_users):
    testarr = []
    for x in range(0, num_users):
        testarr.append(url)
    return testarr

def httpcall(url):
    global total_process_time
    if url.count("?") > 0:
        param_joiner = "&"
    else:
        param_joiner = "?"

    request = urllib2.Request(url)

    request.add_header('User-Agent', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20090913 Firefox/3.5.3')
    request.add_header('Cache-Control', 'no-cache')
    request.add_header('Accept-Charset', 'ISO-8859-1,utf-8;q=0.7,*;q=0.7')
    request.add_header('Referer', domain)
    request.add_header('Keep-Alive', 100)
    request.add_header('Connection', 'keep-alive')
    request.add_header('Host', domain)
    start = time.time()
    translation = urllib2.urlopen(request).read().strip()

    if not translation:
        print("0:\tTranslation blank")
    if translation != trn:
        print("-1:\tTranslation does not match expected output:\n" \
              + "\tActual: (" + translation + ")" \
              + "\n\tExpected: (" + trn + ")")

    stop = time.time()
    elapsed = round(stop - start, 4)
    total_process_time = total_process_time + elapsed
    #print(str(elapsed) + "\tseconds:\t (" + src + ")\t " + txt + "\t (" + tgt + ")\t " + translation)

def run_test():
    for i in tqdm(range(num_calls)):
        from multiprocessing.pool import ThreadPool as Pool
        pool = Pool(num_users)

        call_start = time.clock()
        pool.map(httpcall, testdata)
        call_stop = time.clock()
        call_elapsed = round(call_stop - call_start, 4)
        #call_ave = round(call_elapsed / num_users * num_calls, 4)
        call_ave = round(call_elapsed / num_users, 4)

        #print "\nCall Total  Elapsed Time: " + str(call_elapsed)
        #print   "Call Average Response Time: " + str(call_ave)


script_start = time.time()

print("\nNumber of Users: " + str(num_users))
print("Number of Calls per user: " + str(num_calls))

url = build_url(domain, src, tgt, txt)
testdata = build_test_data(url, num_users)
print("Running Threaded Test")
run_test()

script_stop = time.time()
script_elapsed = round(script_stop - script_start, 4)
script_ave = round(script_elapsed / (num_users * num_calls), 4)

ave_process_time = round(total_process_time / (num_users * num_calls), 4)

print("\nScript   Total  Elapsed Time: " + str(script_elapsed))
print("Script Average Response Time: " + str(script_ave))
print("Total Processing Time: " + str(total_process_time))
print("Average Processing Time: " + str(ave_process_time))
print
