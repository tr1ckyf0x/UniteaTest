#!/bin/sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_ROOT="${SCRIPT_DIR}/../"

for file in $(find $PROJECT_ROOT -name 'preGen.sh'); do
	sh $file
done

for file in $(find $PROJECT_ROOT -name 'swiftgen.yml'); do
	swiftgen config run --config $file
done
