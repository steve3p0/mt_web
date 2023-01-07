import time

# for x in range(0, num_calls - 1):






p.map(translate, testdata)
stopscript = time.time()
elapsed = stopscript - startscript
print elapsed
ave = round((elapsed) / num_calls, 4)
print("Average response time: " + str(ave) + " seconds")
print