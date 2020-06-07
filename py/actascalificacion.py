from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import os, time, pathlib
from selenium_utils import *
from cv_cfg import USERNAME, PASSWORD

class ActasCalificacion(object):

    def __init__(self, chrome):
        self.chrome = chrome
        self.driver = chrome.driver
        self.wait = WebDriverWait(self.driver, 10)
        self.nfiles = 0
        self.base = 'https://actascalificacion.uxxi.uclm.es/actas'

    def authenticate(self):
        driver = self.driver
        driver.get(self.base)
        driver.find_element_by_name('username').send_keys(USERNAME)
        driver.find_element_by_name('password').send_keys(PASSWORD)
        driver.find_element_by_name('submit').click()
        driver.find_element_by_xpath('//a[@class="vpopup"]').click()

    def download_acta(self, course, i = 0):
        driver = self.driver
        driver.get(self.base + '/actas.do')
        actas = driver.find_elements_by_xpath('//a[@class="vActas" and normalize-space(text())="{}"]'.format(course))
        actas[i].click()
        driver.find_element_by_id('lbOn0').click()
        driver.find_elements_by_name('descargar')[1].click()
        self.chrome.download_file()

    def upload_acta(self, fname, course, i = 0):
        postdata = self._get_postdata_excel(course, i)
        postdata['accion'] = 'U'
        postdata['descargar'] = None
        postdata['enviar'] = 'Calificar'
        with open(fname, 'rb') as fd:
            upload_post_file(
                self.base + '/calificacionExcel.do',
                self.driver.get_cookies(),
                postdata,
                {'fichero': ('data.xlsx', fd, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')})

    def _get_postdata_excel(self, course, i):        
        driver = self.driver
        driver.get(self.base + '/actas.do')
        actas = driver.find_elements_by_xpath('//a[@class="vActas" and normalize-space(text())="{}"]'.format(course))
        actas[i].click()
        driver.find_element_by_id('lbOn0').click()
        formulario = driver.find_element_by_name('calificacionExcelAtionForm')
        formPadre = driver.find_element_by_name('generico')
        postdata = { str(i.get_attribute('name')): str(i.get_attribute('value')) for i in formulario.find_elements_by_tag_name('input') }
        for a,b in zip(('anioAct', 'asignaturaAct', 'idAsignaturaAct', 'grupoAct', 'ordenAct', 'convAct'),
                        ('anyAnyaca','assCodnum','idAss','gasCodnum','actNumord','tcoCodalf')):
            postdata[b] = str(formPadre.find_element_by_name(a).get_attribute('value'))
        return postdata


if __name__ == '__main__':
    from chrome import Chrome
    with Chrome() as b:
        actas = ActasCalificacion(b)
        actas.authenticate()
        with open('redes1.xlsx', 'wb+') as f:
            actas.download_acta('REDES DE COMPUTADORES I')
