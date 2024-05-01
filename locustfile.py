import json
import time
import random
from locust import HttpUser, task, between

class MyUser(HttpUser):
    wait_time = between(3, 5)

    host = "https://udacity-azure-cicd-appservice.azurewebsites.net:443"

    @task(1)
    def hello_world(self):
        self.client.get("https://udacity-azure-cicd-appservice.azurewebsites.net")
  
    @task(5)
    def predict(self):

        """Input data explanation (from https://www.kaggle.com/c/boston-housing) 
        chas:       Charles River dummy variable (= 1 if tract bounds river; 0 otherwise).
        rm:         average number of rooms per dwelling.
        tax:        full-value property-tax rate per $10,000.
        ptratio:    pupil-teacher ratio by town.
        b:          1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town.
        lstat:      lower status of the population (percent).
        """
        payload={ 
            "CHAS": {"0": random.randint(0,1)}, 
            "RM": {"0": random.uniform(1.5, 10.0)},
            "TAX": {"0": random.uniform(99.0, 999.0)}, 
            "PTRATIO": {"0": random.uniform(5.0, 45.0)}, 
            "B": {"0": random.uniform(10.0, 999.0)}, 
            "LSTAT": {"0": random.uniform(1.5, 9.9)} 
        }
        response = self.client.post("/predict", json=payload, headers={'Content-Type': 'application/json'})
        time.sleep(1)
