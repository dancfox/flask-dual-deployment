# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

#!/bin/sh
gunicorn --bind 0.0.0.0:8000 --daemon application:app 
/usr/local/bin/python -m awslambdaric lambda.handler
