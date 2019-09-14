#!/usr/bin/python3
import requests, json, os

def api_is_available():
    url = 'https://intranet.eii-to.uclm.es/UniTime/api/curricula'
    params = { 'token':  '-1borxv3rp8jdymfsfriup3if4wzi7x1wfh5lr0ec8kshcpqn82' }
    try:
        r = requests.get(url, params)
        if r:
            json.loads(r.text)
            return True
    except:
        pass
    return False

if not api_is_available():
    print('Restarting tomcat')
    os.system('sudo systemctl stop tomcat')
    os.system('sudo systemctl start tomcat')
