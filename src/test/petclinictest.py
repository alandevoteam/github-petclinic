
# import selenium libraries etc
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager

# keep window open
options = Options()
options.add_experimental_option("detach", True)

# setup driver & open webapp
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),
                          options=options)

driver.get("http://localhost:8080/petclinic/")


links = driver.find_elements("xpath", "//a[@href]")
for link in links:
    if "owners" in link.get_attribute("innerHTML"):
        link.click()
