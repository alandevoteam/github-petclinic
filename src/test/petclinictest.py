
# import selenium libraries etc
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys
import time

# keep window open
options = Options()
options.add_experimental_option("detach", True)

# setup driver & open webapp
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),
                          options=options)

# get link webapp
driver.get("http://localhost:8080/petclinic/")
time.sleep(5)

# open link, browse to find owners
links = driver.find_elements("xpath", "//a[@title]")
for link in links:
     if "owners" in link.get_attribute("innerHTML"):
         link.click()


