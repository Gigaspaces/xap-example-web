#!/bin/bash

DIR_NAME=$(dirname ${BASH_SOURCE[0]})
. $DIR_NAME/../../../bin/setenv.sh

if [ "${M2_HOME}" = "" ] ; then
    M2_HOME="${XAP_HOME}/tools/maven/apache-maven-3.2.5"; export M2_HOME
fi

if [ $1 = "clean" ]; then
  (cd $DIR_NAME;
  ${M2_HOME}/bin/mvn clean; )

elif [ $1 = "compile" ]; then
  (cd $DIR_NAME;
  ${M2_HOME}/bin/mvn compile; )

elif [ $1 = "package" ]; then
  (cd $DIR_NAME;
  ${M2_HOME}/bin/mvn package; )

elif [ $1 = "deploy" ]; then
  ${XAP_HOME}/bin/gs.sh deploy $DIR_NAME/target/PlainWebAppExample.war

elif [ $1 = "undeploy" ]; then
  ${XAP_HOME}/bin/gs.sh undeploy PlainWebAppExample

else
  echo ""
  echo "Error: Invalid input command: $1 "
  echo ""
  echo "The available commands are:"
  echo ""
  echo "clean                    --> Cleans all output dirs"
  echo "compile                  --> Builds all; don't create WAR file"
  echo "package                  --> Builds the distribution"
  echo "deploy                   --> Deploys the web app on the service grid"
  echo "undeploy                 --> Undeploys the web app from the service grid"
  echo ""
fi