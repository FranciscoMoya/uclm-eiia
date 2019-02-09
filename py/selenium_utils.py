import requests

def download_post_file(url, cookies, postdata, files = None):
    s = requests.Session()
    for cookie in cookies:
        s.cookies.set(cookie['name'], cookie['value'])
    r = s.post(url, data = postdata, files = files)
    return r.content

def upload_post_file(url, cookies, postdata, files):
    download_post_file(url, cookies, postdata, files)
