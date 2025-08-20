#!/usr/bin/env bash

cd "$WORKSPACE" || cd "$(pwd)"
echo "Current directory: $(pwd)"

echo 'Installing and packaging the application...'
set -x
mvn clean package
mvn install
set +x

echo 'Extracting project name and version...'
set -x
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)
set +x


JAR_PATH=$(find "$(pwd)/target" -type f -name "${NAME}-${VERSION}.jar" | head -n 1)
echo "Resolved JAR path: $JAR_PATH"

if [ -f "$JAR_PATH" ]; then
  echo "Running application..."
  java -jar "$JAR_PATH"
else
  echo "ERROR: JAR file not found at $JAR_PATH"
  exit 1
fi

