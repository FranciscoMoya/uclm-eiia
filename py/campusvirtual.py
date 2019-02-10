from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os
from selenium_utils import *
from cv_cfg import USERNAME, PASSWORD

class CampusVirtual(object):

    def __init__(self, user, passwd, driver=None):
        self.user, self.passwd = user, passwd
        if not driver:
            driver = webdriver.Chrome('g:/GitHub/challenges-private/eval/chromedriver.exe')
        self.driver = driver
        self.wait = WebDriverWait(driver, 10)
        driver.implicitly_wait(10)

    def __enter__(self):
        self.driver.__enter__()
        return self
    
    def __exit__(self, exc_type, exc_value, traceback):
        self.driver.__exit__(exc_type, exc_value, traceback)

    def authenticate(self):
        driver = self.driver
        driver.get('https://campusvirtual.uclm.es/')
        driver.find_element_by_name('adAS_username').send_keys(USERNAME)
        driver.find_element_by_name('adAS_password').send_keys(PASSWORD)
        driver.find_element_by_id('submit_ok_uclm').click()

    def tareas(self, course):
        driver = self.driver
        driver.get('https://campusvirtual.uclm.es/my/')
        a = driver.find_element_by_xpath('//a[normalize-space(text())="{}"]'.format(course))
        driver.get(a.get_attribute('href'))
        tareasXpath = "//span[contains(@class,'accesshide') and text()=' Tarea']/parent::span/parent::a[contains(@class,'conditionalhidden') or not(contains(@class,'dimmed'))]"
        tareas = driver.find_elements_by_xpath(tareasXpath)
        return tuple((t.text, t.get_attribute('href')) for t in tareas)

    def pendientes_calificar(self, tarea):
        driver, wait = self.driver, self.wait
        title, url = tarea
        print('Calificando tarea: "{}"'.format(title))
        driver.get(url)
        driver.find_element_by_link_text('Calificación').click()
        wait.until(EC.visibility_of_element_located((By.XPATH, "//div[@class='submissionstatustable']")))
        driver.find_element_by_xpath('//a[@data-region="user-filters"]').click()
        driver.find_element_by_name('filter_requiregrading').click()
        _, _, count = driver.find_element_by_xpath('//span[@data-region="user-count-summary"]').text.split(' ')
        return int(count)

    def calificaciones(self, course):
        driver = self.driver
        driver.get('https://campusvirtual.uclm.es/my/')
        a = driver.find_element_by_xpath('//a[normalize-space(text())="{}"]'.format(course))
        courseid = a.get_attribute('href').split('=')[1]
        driver.get('https://campusvirtual.uclm.es/grade/export/xls/index.php?id=' + courseid)
        # recoger en diccionario todos los input, como name:value
        allinputs = driver.find_elements_by_xpath('//form//input')
        postdata = { str(i.get_attribute('name')):str(get_element_value(i)) for i in allinputs if not i.get_attribute('name').startswith('nosubmit') }
        return download_post_file(
            'https://campusvirtual.uclm.es/grade/export/xls/export.php',
            driver.get_cookies(),
            postdata)

def get_element_value(e):
    if e.get_attribute('type') == 'checkbox':
        return str(int(e.is_selected()))
    return e.get_attribute('value')

if __name__ == '__main__':
    os.chdir(os.path.dirname(__file__))
    with CampusVirtual(USERNAME, PASSWORD) as cv:
        cv.authenticate()
        for t in cv.tareas('29185'):
            print('Pendientes en {}: {}'.format(t[0], cv.pendientes_calificar(t)))

