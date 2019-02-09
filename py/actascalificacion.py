from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os
from selenium_utils import *
from cv_cfg import USERNAME, PASSWORD

class ActasCalificacion(object):

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
        driver.get('https://actascalificacion.uclm.es/')
        driver.find_element_by_name('username').send_keys(USERNAME)
        driver.find_element_by_name('password').send_keys(PASSWORD)
        driver.find_element_by_name('submit').click()
        driver.find_element_by_xpath('//a[@class="vpopup"]').click()

    def download_acta(self, course, i):
        postdata = self._get_postdata_excel(course, i)
        postdata['accion'] = 'DX'
        return download_post_file(
            'https://actascalificacion.uclm.es/actas/calificacionExcel.do',
            self.driver.get_cookies(),
            postdata)

    def upload_acta(self, course, i, fname):
        postdata = self._get_postdata_excel(course, i)
        postdata['accion'] = 'U'
        with open(fname, 'rb') as fd:
            upload_post_file(
                'https://actascalificacion.uclm.es/actas/calificacionExcel.do',
                self.driver.get_cookies(),
                postdata,
                {'fichero': fd})        

    def _get_postdata_excel(self, course, i):        
        driver = self.driver
        driver.get('https://actascalificacion.uclm.es/actas/actas.do')
        actas = driver.find_elements_by_xpath('//a[@class="vActas" and normalize-space(text())="{}"]'.format(course))
        actas[i].click()
        inputs = driver.find_elements_by_xpath('//form[@name="calificacionExcelAtionForm"]//input')
        postdata = { i.get_attribute('name'): i.get_attribute('value') for i in inputs }
        form = driver.find_element_by_name('generico')
        for a,b in zip(('anioAct', 'asignaturaAct', 'idAsignaturaAct', 'grupoAct', 'ordenAct', 'convAct'),
                        ('anyAnyaca','assCodnum','idAss','gasCodnum','actNumord','tcoCodalf')):
            postdata[b] = form.find_element_by_name(a).get_attribute('value')
        return postdata

