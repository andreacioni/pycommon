#!/bin/bash

echo "Cleaning temp directories..."

rm -rf build/ dist/ pycommon_andreacioni.egg-info/

echo "Creating new version"

FILE=setup.py
CURRENT_VERSION=$(cat $FILE | grep version | awk '{print $1}' | cut -d '"' -f 2)

echo "Current version is: $CURRENT_VERSION. Enter new version:"

read NEW_VERSION

echo "New version is: $NEW_VERSION"

sed -i "s/$CURRENT_VERSION/$NEW_VERSION/g" $FILE
git add $FILE

git commit -m "Releasing v$NEW_VERSION"

git push

git tag -a v$NEW_VERSION -m "Release v$NEW_VERSION"

git push origin v$NEW_VERSION

echo "Creating version for PyPi"

python3 setup.py sdist bdist_wheel

echo "Uploading to PyPi"

python3 -m twine upload --repository-url https://upload.pypi.org/legacy/ dist/*