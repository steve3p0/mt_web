from locust import HttpLocust, TaskSet
import urllib3
import json

http = urllib3.PoolManager()

def translate(l):
    #l.client.post("/login", {"username":"ellen_key", "password":"education"})
    #https://localhost/translate?source=en&target=fr&text=Hello&key=4ac85ecd-dc6d-49ee-a768-602ae2192ec9
    key = "4ac85ecd-dc6d-49ee-a768-602ae2192ec9"
    #l.client.post("/translate", {"source": "en", "target": "fr", "text": "Hello", "key": key}, verify=False)

    # r = http.request(
    # 'GET',
    # 'https://localhost/translate?',
    # fields = {'source': 'en', 'target': 'fr', 'text': 'Hello', 'key': key})
    #
    # json.loads(r.data.decode({'source': 'en', 'target': 'fr', 'text': 'Hello', 'key': key}))


    #json.loads(r.data.decode('utf-8'))['args']{'source': 'en', 'target': 'fr', 'text': 'Hello', 'key': key}

    # from urllib.parse import urlencode
    # encoded_args = urlencode({'source': 'en', 'target': 'fr', 'text': 'Hello', 'key': key})
    # url = 'https://localhost/translate?' + encoded_args
    # r = http.request('POST', url)
    # json.loads(r.data.decode('utf-8'))['args'],{'source': 'en', 'target': 'fr', 'text': 'Hello', 'key': key}

    url = "https://localhost/translate?"
    fields = {'source': 'en', 'target': 'fr', 'text': 'Hello', 'key': key}

    r = http.request('GET', url, fields)
    json.loads(r.data.decode('utf-8')) #['args'], fields

def index(l):
    l.client.get("/")

class UserBehavior(TaskSet):
    tasks = {translate: 1}

    def on_start(self):
        translate(self)

class WebsiteUser(HttpLocust):
    task_set = UserBehavior
    min_wait = 5000
    max_wait = 9000