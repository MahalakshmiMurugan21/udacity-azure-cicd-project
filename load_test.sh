#!/usr/bin/env bash
# LOAD TESTING
# Using Locust: https://docs.locust.io/en/stable/quickstart.html
#
# See all configuration options: https://docs.locust.io/en/stable/configuration.html
# I use the following:
# --headless        Disable the web interface, and instead start the load test immediately.
#                   Requires -u and -t to be specified.
# -u                specifies the number of Users to spawn
# -r                specifies the spawn rate (number of users to start per second)
# -run-time or -t   specifies the run time for a test
#
# in Ubuntu:
# locust -f locustfile.py --headless -u 1000 -r 100 -t 30s
#
# Locust wont install on mac so in my case running in docker was necessary
# To set it up simply follow: https://docs.locust.io/en/stable/running-locust-docker.html
docker run -p 8089:8089 -v $PWD:/mnt/locust locustio/locust -f /mnt/locust/locustfile.py --headless -u 100 -r 10 -t 30s