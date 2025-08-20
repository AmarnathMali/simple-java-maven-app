#!/usr/bin/env bash

echo 'Installing your Maven-built Java application into the local repository...'
set -x
mvn clean package
mvn install
set +x

echo 'Extracting project name and version from pom.xml...'
set -x
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)
set +x

echo "Running your application: ${NAME}-${VERSION}.jar"
JAR_PATH="target/${NAME}-${VERSION}.jar"

if [ -f "$JAR_PATH" ]; then
  java -jar "$JAR_PATH"
else
  echo "ERROR: JAR file not found at $JAR_PATH"
  exit 1
fi
