# import selenium libraries etc
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
import time


# keep window open
options = Options()
options.add_experimental_option("detach", True)

# setup driver & open webapp
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),
                          options=options)

# # get link webapp
driver.get("http://localhost:8080/petclinic/")

# Locate the link element and click it to open the page for finding owners
link_element = driver.find_element(By.XPATH, '//*[@id="main-navbar"]/ul/li[2]/a/span[2]')
link_element.click()


# links = driver.find_elements("xpath", "//a[@title]")
# for link in links:
#      if "owners" in link.get_attribute("innerHTML"):
#          link.click()


