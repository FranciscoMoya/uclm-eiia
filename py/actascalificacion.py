import os
import time
from pathlib import Path
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium_utils import *
from cv_cfg import USERNAME, PASSWORD

class ActasCalificacion(object):

    def __init__(self, driver):
        self.driver = driver
        self.wait = WebDriverWait(self.driver, 10)
        self.nfiles = 0
        self.base = 'https://actascalificacion.uxxi.uclm.es/actas'

    def authenticate(self):
        driver = self.driver
        driver.get(self.base)
        driver.implicitly_wait(5)
        driver.find_element(by=By.ID, value='saml2_module-Office365').click()
        driver.implicitly_wait(10)
        driver.find_element(by=By.XPATH, value='//a[@class="vpopup" and normalize-space(text())="Entrar en Calificación de Actas Web"]').click()
        driver.find_element(by=By.XPATH, value='//a[@class="vMenuPrincipal" and normalize-space(text())="Calificación de actas"]').click()

    def download_acta(self, course, i=0):
        driver = self.driver
        driver.get(self.base + '/actas.do')
        actas = driver.find_elements(by=By.XPATH, value='//a[@class="vActas" and normalize-space(text())="{}"]'.format(course))
        actas[i].click()
        driver.find_element(by=By.ID, value='lbOn0').click()
        driver.find_elements(by=By.NAME, value='descargar')[1].click()
        self._wait_for_download_and_rename(course)

    def _wait_for_download_and_rename(self, course):
        download_dir = Path.cwd() / 'out'
        target_filename = f'{course}.xlsx'
        temp_filename = None

        # Wait for the download to complete
        while True:
            time.sleep(1)
            files = list(download_dir.glob('*.crdownload'))  # Edge may use .crdownload extension for in-progress downloads
            if not files:
                files = list(download_dir.glob('*.xlsx'))
                if files:
                    temp_filename = files[0]
                    break

        # Rename the file
        if temp_filename:
            target_path = download_dir / target_filename
            temp_filename.rename(target_path)

    def upload_acta(self, fname, course, i=0):
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
        actas = driver.find_elements(by=By.XPATH, value='//a[@class="vActas" and normalize-space(text())="{}"]'.format(course))
        actas[i].click()
        driver.find_element(by=By.ID, value='lbOn0').click()
        formulario = driver.find_element(by=By.NAME, value='calificacionExcelAtionForm')
        formPadre = driver.find_element(by=By.NAME, value='generico')
        postdata = { str(i.get_attribute('name')): str(i.get_attribute('value')) for i in formulario.find_elements(By.TAG_NAME, 'input') }
        for a, b in zip(('anioAct', 'asignaturaAct', 'idAsignaturaAct', 'grupoAct', 'ordenAct', 'convAct'),
                        ('anyAnyaca','assCodnum','idAss','gasCodnum','actNumord','tcoCodalf')):
            postdata[b] = str(formPadre.find_element(By.NAME, a).get_attribute('value'))
        return postdata


if __name__ == '__main__':
    download_dir = str(Path().absolute() / 'out')

    options = webdriver.EdgeOptions()
    prefs = {
        "download.default_directory": download_dir,
        "download.prompt_for_download": False,
        "download.directory_upgrade": True,
        "safebrowsing.enabled": True
    }
    options.add_experimental_option("prefs", prefs)
    options.use_chromium = True

    service = webdriver.EdgeService(executable_path=r'D:\git\uclm-eiia\py\msedgedriver.exe')
    driver = webdriver.Edge(service=service, options=options)

    try:
        actas = ActasCalificacion(driver)
        actas.authenticate()
        actas.download_acta('EVALUACIÓN EN CAA')
    finally:
        driver.quit()
