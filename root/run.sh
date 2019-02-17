#!/bin/sh -ex

# Set default environment
export PASSENGER_ENVIRONMENT="${PASSENGER_ENVIRONMENT:-production}"

# Start Passenger
if [ -z "$PASSENGER_APP_ROOT" ]; then
	echo "Missing PASSENGER_APP_ROOT environment variable"
	exit 1
elif [ ! -e "$PASSENGER_APP_ROOT" ]; then
	echo "Invalid PASSENGER_APP_ROOT directory: $PASSENGER_APP_ROOT does not exist"
	exit 2
else
	cd "$PASSENGER_APP_ROOT"
	exec passenger start --envvar "RAILS_RELATIVE_URL_ROOT=$RAILS_RELATIVE_URL_ROOT"
fi
