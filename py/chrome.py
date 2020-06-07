import winreg as reg
import subprocess, pathlib, time, os

def find_chrome_exe():
    reg_path = r'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'

    for install_type in reg.HKEY_CURRENT_USER, reg.HKEY_LOCAL_MACHINE:
        try:
            reg_key = reg.OpenKey(install_type, reg_path, 0, reg.KEY_READ)
            chrome_path = reg.QueryValue(reg_key, None)
            reg_key.Close()
        except WindowsError:
            chrome_path = None
        else:
            break

    return chrome_path

def find_chrome_version():
    reg_path = r'SOFTWARE\Google\Chrome\BLBeacon'
    for install_type in reg.HKEY_CURRENT_USER, reg.HKEY_LOCAL_MACHINE:
        try:
            reg_key = reg.OpenKey(install_type, reg_path, 0, reg.KEY_READ)
            chrome_ver = reg.QueryValueEx(reg_key, 'version')[0]
            reg_key.Close()
        except WindowsError:
            chrome_ver = None
        else:
            break

    return chrome_ver

def find_chrome_driver():
    ver = find_chrome_version().split('.')[0]
    return str(pathlib.Path(__file__).parent.joinpath(f'chromedriver{ver}.exe'))

def find_chrome_profile():
    return str(pathlib.Path(__file__).parent.joinpath('profile'))

from selenium import webdriver

class Chrome(object):

    def __init__(self, executable_path=None):
        self.download = pathlib.Path('download')
        self.download.mkdir(exist_ok=True)
        self.prev_files = len(os.listdir(str(self.download.absolute())))
        if not executable_path:
            executable_path = find_chrome_driver()
        options = webdriver.ChromeOptions()
        options.add_argument("start-maximized")
        options.add_argument("disable-gpu")
        options.add_argument("disable-plugins")
        options.add_argument("disable-features=InfiniteSessionRestore")
        options.add_argument("safebrowsing-disable-download-protection")
        profile = {
            "download.default_directory": str(self.download.absolute()),
            "plugins.always_open_pdf_externally": True,
            "safebrowsing.enabled": True,
        }
        options.add_experimental_option("prefs", profile)
        self.driver = webdriver.Chrome(executable_path=executable_path, options=options)
        self.driver.implicitly_wait(30)
        self.nfiles = 0

    def __enter__(self):
        self.driver.__enter__()
        return self
    
    def __exit__(self, exc_type, exc_value, traceback):
        self.download_wait()
        self.driver.quit()
        self.driver.__exit__(exc_type, exc_value, traceback)

    # https://stackoverflow.com/questions/34338897/python-selenium-find-out-when-a-download-has-completed
    def download_wait(self, timeout=30):
        seconds = 0
        dl_wait = True
        while dl_wait and seconds < timeout:
            time.sleep(1)
            dl_wait = False
            files = os.listdir(str(self.download.absolute()))
            if self.nfiles and len(files) != self.nfiles + self.prev_files:
                dl_wait = True

            for fname in files:
                if fname.endswith('.crdownload'):
                    dl_wait = True

            seconds += 1
        return seconds
        
    def download_file(self):
        self.nfiles += 1
