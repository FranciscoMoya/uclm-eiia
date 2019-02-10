import requests

def download_post_file(url, cookies, postdata, files = None):
    s = requests.Session()
    s.headers.update({
        'Accept': 'text/html, application/xhtml+xml, application/xml; q=0.9, */*; q=0.8',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'es-ES, es; q=0.8, en-US; q=0.5, en; q=0.3',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134'
    })
    for cookie in cookies:
        s.cookies.set(cookie['name'], cookie['value'])
    r = s.post(url, data = postdata, files = files)
    if r.status_code != 200:
        print(r.content) 
    return r.content

def upload_post_file(url, cookies, postdata, files):
    download_post_file(url, cookies, postdata, files)
