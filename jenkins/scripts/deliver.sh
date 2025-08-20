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

JAR_PATH="target/${NAME}-${VERSION}.jar"
echo "Looking for JAR at: $JAR_PATH"
ls -l target/

if [ -f "$JAR_PATH" ]; then
  echo "Running application..."
  java -jar "$JAR_PATH"
else
  echo "ERROR: JAR file not found at $JAR_PATH"
  exit 1
fi
