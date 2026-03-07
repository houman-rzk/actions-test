#!/bin/bash

export TAG="$(cat .deploy/previous)"

./deploy.sh
