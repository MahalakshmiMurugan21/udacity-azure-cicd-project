[![Python application test with Github Actions](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/actions/workflows/main.yml/badge.svg)](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/actions/workflows/main.yml)

# Udacity Azure CI/CD Project
This is a Project submission for Udacity Azure DevOps Course demonstrating CI/CD techiques and skills acquired in the course.
- Changes to this GitHub repository's main branch will trigger:
  * Continuous Integration pipeline on GitHub using GitHub Actions. 
  * Continuous Delivery pipeline on Azure Pipelines using YAML.

>This project contains a Python Flask WebApp which serves out housing prices predictions through API calls and the algorithm used here is a pre-trained sklearn ML model for Boston area.
>
## Table of Contents

- [Demo](#demo)
- [Architectural Diagram](#architectural-diagram)
- [Project Plan](#project-plan)
- [Instructions](#instructions)
  * [Dependencies](#dependencies)
  * [Getting Started](#getting-started)
  * [Running the Python project](#running-the-python-project)
- [Alternative deployment via script using Terraform](#alternative-deployment-via-script-using-terraform)
- [Screenshots](#screenshots)
- [Future Enhancements](#future-enhancements)

## Demo

Link to Recording:
[Demo Video] (https://www.youtube.com/watch?v=kjCOa8fVZXY)

## Architectural Diagram

![Screenshot project cloned into Azure Cloud Shell](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Udacity-azure-cicd-architecture.png)

## Project Plan

* A link to a Trello board for the project: [Udacity Azure CICD Project](https://trello.com/b/mcmGyUTI/udacity-azure-cicd-project![image](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/assets/155423147/a58a61cf-db37-46d1-95fb-fe0cd575d50a)
)
* [Trello downloaded file](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Udacity%20Azure%20CICD%20Project%20_%20Trello.html)
* A link to a spreadsheet that includes the original and final project plan: [Spreadsheet on Google Drive]([https://docs.google.com/spreadsheets/d/1VvhKAVZM7I1qVYufkkjYf5vR3nBcCQtji21aupZyXik/edit?usp=sharing](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Azure%20CICD%20Project%20Management.xlsx))
  * (Contains 5 sheets: Yearly Plan, Q1 Plan, Q2 Plan, Q3 Plan, Q4 Plan)

## Instructions

### Dependencies

1. Create an [Azure Account](https://portal.azure.com)
2. Create a [GitHub Account](https://github.com)

### Getting Started

1. Open Azure cloud shell
2. Create gpg keys for ssh access to GitHub repo. This creates files with private and public keys in directory ~/.ssh/

```bash
user@Azure:~/ ssh-keygen -t rsa
```

3. Copy contents of the new public key file: id_rsa.pub

```bash
user@Azure:~/ cat ~/.ssh/id_rsa.pub
```

4. Add new key to your GitHub profile (Settings, GPG keys, add new), paste the key and add some name - could be anything.

5. Fork this repository and clone it into your azure cloud shell. Adapt the URL to match your forked repo:

```bash
user@Azure:~/ git clone git@github.com:MahalakshmiMurugan21/udacity-azure-cicd-project.git
```

6. Make sure the following environment variables are set and correspond to your azure account details:

* ARM_CLIENT_ID
* ARM_CLIENT_SECRET
* ARM_SUBSCRIPTION_ID
* ARM_TENANT_ID

See the account details:

```bash
user@Azure:~/ az account list
```

Use export command to assign the values from corresponding subscription to the following env vars:
Actually, ARM_SUBSCRIPTION_ID was enough :)

```bash
user@Azure:~/ export ARM_CLIENT_ID=<value from property 'homeTenantId'>
user@Azure:~/ export ARM_CLIENT_SECRET=<value from>
user@Azure:~/ export ARM_SUBSCRIPTION_ID=<value from property 'id'>
user@Azure:~/ export ARM_TENANT_ID=<value from property 'tenantId'>
```

## Running the Python project

1. While still in Azure cloud shell cd into the project dir:

```bash
user@Azure:~/ cd udacity-azure-cicd-project
```

2. Install & activate virtual environment, install dependencies:

```bash
user@Azure:~/udacity-azure-cicd-project/ make setup && make install
```

```bash
user@Azure:~/udacity-azure-cicd-project/ make all
```

3. Create a webapp and deploy code from a local workspace to the app.

The command is required to run from the folder where the code is present. If necessary adapt parameter values for webapp name (-n; needs to be unique), location (-l) and sku.

Example:

```bash
user@Azure:~/udacity-azure-cicd-project/ az webapp up \
                -n udacity-azure-cicd-appservice \
                -l westeurope \
                --sku B1
```

This should result in the app running in the cloud and being accessible from the internet.
Expected output for successfull deployment:

```bash
The webapp 'udacity-azure-cicd-appservice' doesn't exist
Creating webapp 'udacity-azure-cicd-appservice' ...
Configuring default logging for the app, if not already enabled
Creating zip with contents of dir /home/user/udacity-azure-cicd-appservice ...
Getting scm site credentials for zip deployment
Starting zip deployment. This operation can take a while to complete ...
Deployment endpoint responded with status code 202

You can launch the app at http://udacity-azure-cicd-appservice.azurewebsites.net
{
  "URL": "http://udacity-azure-cicd.azurewebsites.net",
  "appserviceplan": "udacity-azure-cicd-appservice-asp",
  "location": "westeurope",
  "name": "udacity-azure-cicd-appservice",
  "os": "Linux",
  "resourcegroup": "Azuredevops",
  "runtime_version": "python|3.7",
  "runtime_version_detected": "-",
  "sku": "FREE",
  "src_path": "//home//user//udacity-azure-cicd-project"
}
```

4. Run the Webapp using the existing resource-group if not create a resource-group manually

If --resource-group was not supplied it gets created automatically. It's handy to export its name to an env variable:

```bash
user@Azure:~/udacity-azure-cicd-project/ az webapp up -n udacity-azure-cicd-appservice --resource-group Azuredevops
```

5. Double check app is running by going to http://udacity-azure-cicd-appservice.azurewebsites.net in your browser.

You should see the default webapp title: Sklearn Prediction Home

6. Run a script to predict price for set of housing location related parameters supplied in the following script:

If necessary adapt the URL in the script to match the app's URL. Successful response looks like the one below.

```bash
user@Azure:~/udacity-azure-cicd-project/ ./make_predict_azure_app.sh
Port: 443
{"prediction":[20.35373177134412]}
```

7. (Optionally) Run load test from azure cloud shell to see how the app behaves under simulated load:

For more details about load tests with locust see the file load_test.sh for some insights .

```bash
user@Azure:~/udacity-azure-cicd-project/  locust -f locustfile.py --headless -u 100 -r 10 -t 30s
```

## Screenshots

* Project running on Azure App Service
![Screenshot project running Azure Portal](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/App%20running.png)

![Screenshot project running Homepage](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/App%20running%20home.png)

* Project cloned into Azure Cloud Shell
![Screenshot project cloned into Azure Cloud Shell](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/github%20cloned.png)

* Passing tests that are displayed after running the `make all` command from the `Makefile`
![Screenshot output of a test run](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Make%20Test.png)

* Output of a test run
![Screenshot output of a test run](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Make%20All.png)

* Successful run of CD in Azure Pipelines.
![Screenshot stages in Azure Pipelines](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Azure%20pipeline%20run.png)

* Successful prediction from deployed flask app in Azure Cloud Shell.
![Screenshot run prediction](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Output%20of%20prediction.png)

* Successful load test run with Locust run in Azure Cloud Shell.
![Screenshot load test](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Output%20of%20locust%20file.png)

The screenshot above illustrates execution of the locust command which (as per load test definition in locustfile.py) simulates 10 users accessing the webapp's URL and generating get and post requests repeatedly for the duration of 5 seconds. To run it, just execute: 

```bash
udacity@Azure:~$ locust -f locustfile.py --headless -u 10 -r 5 -t 5s
```

* Output of streamed log files from deployed application
![Screenshot application logs](https://github.com/MahalakshmiMurugan21/udacity-azure-cicd-project/blob/main/docs/Streamed%20log%20output.png)

Logs can be streamed by:

```bash
udacity@Azure:~$ az webapp log tail \
    --name udacity-azure-cicd-appservice \
    --resource-group $RG_WEBAPP
```

Adapt the name or resource-group parameters to match the actual webapp name and resource group should they be different to your setup.

## Future Enhancements

- This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

- One pipeline combining CI and CD would be tidier but it was a lesson of this project to learn both: GitHub Actions and Azure Pipelines.
