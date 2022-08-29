#!/bin/bash

kubectl apply \
    -f secrets.yml \
    -f storage.yml \
    -f database.yml \
    -f wordpress.yml
