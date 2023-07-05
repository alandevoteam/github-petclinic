# import selenium libraries etc
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time


# keep window open
options = Options()
options.add_experimental_option("detach", True)

# setup driver & open webapp
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()),
                          options=options)

# # get link webapp
driver.get("http://xptpetclinic.westeurope.cloudapp.azure.com:8080/petclinic-/")

# Introduce a delay to ensure the page has finished loading
time.sleep(7)

# Locate the link element and click it to open the page for finding owners
link_element = driver.find_element(By.XPATH, '//*[@id="main-navbar"]/ul/li[2]/a/span[2]')
link_element.click()

# Locate the link element and click it to Add Owner
add_owner_link = driver.find_element(By.LINK_TEXT, "Add Owner")
add_owner_link.click()

# Fill in the fields for adding an owner
first_name_field = driver.find_element(By.ID, "firstName")
first_name_field.send_keys("Ash")  # Enter the desired first name

last_name_field = driver.find_element(By.ID, "lastName")
last_name_field.send_keys("Ketchum")  # Enter the desired last name

address_field = driver.find_element(By.ID, "address")
address_field.send_keys("Delia 29")  # Enter the desired address

city_field = driver.find_element(By.ID, "city")
city_field.send_keys("Pallet Town")  # Enter the desired city

telephone_field = driver.find_element(By.ID, "telephone")
telephone_field.send_keys("0616263646")  # Enter the desired telephone number

# Introduce a delay to ensure the page has finished loading
time.sleep(7)

# Click the "Add Owner" button
add_owner_button = driver.find_element(By.XPATH, "//button[contains(text(), 'Add Owner')]")
add_owner_button.click()

# Introduce a delay to ensure the page has finished loading
time.sleep(7)

# Click the "Add New Pet" button
add_pet_link = driver.find_element(By.LINK_TEXT, "Add New Pet")
add_pet_link.click()

# Introduce a delay to ensure the page has finished loading
time.sleep(7)

# Fill in the fields for adding a new pet
name_field = driver.find_element(By.ID, "name")
name_field.send_keys("Pickachu")  # Enter the desired pet name

birth_date_field = driver.find_element(By.ID, "birthDate")
birth_date_field.send_keys("2023/05/02")  # Enter the desired birth date

type_dropdown = driver.find_element(By.ID, "type")
type_dropdown.click()

# Select the desired pet type from the dropdown (e.g., "Dog")
type_option = driver.find_element(By.XPATH, "//option[text()='hamster']")
type_option.click()

# Click the "Add Pet" button
add_pet_button = driver.find_element(By.XPATH, "//button[contains(text(), 'Add Pet')]")
add_pet_button.click()

# Introduce a delay to ensure the page has finished loading
time.sleep(7)

# Close the browser window
driver.quit()

