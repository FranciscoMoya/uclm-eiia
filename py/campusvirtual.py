from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys
import os, re, requests, time, pathlib
from urllib.parse import quote
try:    from .chrome import Chrome
except: from  chrome import Chrome
try:    from .cv_cfg import USERNAME, PASSWORD
except: from cv_cfg import USERNAME, PASSWORD
import urllib.parse as urlparse
from urllib.parse import parse_qs

from selenium_utils import *

class CampusVirtual(object):

    def __init__(self, chrome):
        self.driver = chrome.driver
        self.chrome = chrome
        self.driver.implicitly_wait(10)
        self.nfiles = 0
        self.base = 'https://campusvirtual.uclm.es/'


    def authenticate(self):
        driver = self.driver
        driver.get(self.base)
        user = driver.find_element_by_name('adAS_username')
        driver.execute_script(f"arguments[0].value = '{USERNAME}'", user)
        pwd = driver.find_element_by_name('adAS_password')
        driver.execute_script(f"arguments[0].value = '{PASSWORD}'", pwd)
        driver.find_element_by_id('submit_ok').click()
        driver.implicitly_wait(30)
        driver.find_element_by_id('page-wrapper')
        driver.implicitly_wait(10)

    def tareas(self, course):
        driver = self.driver
        driver.get(self.base + '/my/')
        todas = tuple()
        for a in driver.find_elements_by_xpath('//a[contains(@title,"{}")]'.format(course)):
            driver.get(a.get_attribute('href'))
            tareasXpath = "//span[contains(@class,'accesshide') and text()=' Tarea']/parent::span/parent::a[not(contains(@class,'conditionalhidden') or contains(@class,'dimmed'))]"
            tareas = driver.find_elements_by_xpath(tareasXpath)
            todas += tuple((t.find_element_by_class_name("instancename").text, t.get_attribute('href')) for t in tareas)
        return todas

    def pendientes_calificar(self, tarea):
        driver, wait = self.driver, self.wait
        title, url = tarea
        print('Calificando tarea: "{}"'.format(title))
        driver.get(url)
        driver.find_element_by_link_text('Calificación').click()
        driver.implicitly_wait(0)
        WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.XPATH, "//div[@class='submissionstatustable']")))
        driver.implicitly_wait(10)
        driver.find_element_by_xpath('//a[@data-region="user-filters"]').click()
        driver.find_element_by_name('filter_requiregrading').click()
        _, _, count = driver.find_element_by_xpath('//span[@data-region="user-count-summary"]').text.split(' ')
        return int(count)

    def calificaciones(self, course):
        driver = self.driver
        driver.get(self.base + '/my/')
        a = driver.find_element_by_xpath('//a[normalize-space(text())="{}"]'.format(course))
        courseid = a.get_attribute('href').split('=')[1]
        driver.get(self.base + '/grade/export/xls/index.php?id=' + courseid)
        driver.find_element_by_id('id_submitbutton').click()
        self.chrome.download_file()


def get_element_value(e):
    if e.get_attribute('type') == 'checkbox':
        return str(int(e.is_selected()))
    return e.get_attribute('value')

if __name__ == '__main__':
    try: os.chdir(os.path.dirname(__file__))
    except: pass
    with Chrome() as b:
        cv = CampusVirtual(b)
        cv.authenticate()
        cv.calificaciones('REDES DE COMPUTADORES I')
