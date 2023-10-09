#!/bin/bash
# Activate virtual environment
source /appenv/bin/activate
# Install application test requirements
pip download -d /build -r requirements_test.txt --no-input

pip install --no-index -f /build -r requirements_test.txt

# Run test.sh arguments
exec $@