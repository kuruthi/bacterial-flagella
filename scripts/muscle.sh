#!/bin/bash
# A script that calls the MUSCLE multiple seq alignment software
#takes the file name with extension as the input
set -e

muscle -align $1 -output $1.afa
