#!/bin/bash

DIR_NAME=$(dirname ${BASH_SOURCE[0]})
. $DIR_NAME/../../../bin/setenv.sh

if [ "${M2_HOME}" = "" ] ; then
    M2_HOME="${XAP_HOME}/tools/maven/apache-maven-3.2.5"; export M2_HOME
fi

if [ -z "$1" ] || ([ $1 != "clean" ] && [ $1 != "compile" ] && [ $1 != "package" ] && [ $1 != "deploy" ] && [ $1 != "undeploy" ]); then
  echo ""
  echo "Error: Invalid input command $1 "
  echo ""
  echo "The available commands are:"
  echo ""
  echo "clean                    --> Cleans all output dirs"
  echo "compile                  --> Builds all; don't create WAR file"
  echo "package                  --> Builds the distribution"
  echo "deploy                   --> Deploys the web app on the service grid"
  echo "undeploy                 --> Undeploys the web app from the service grid"
  echo ""

elif [ $1 = "clean" ]; then
  (cd $DIR_NAME;
  ${M2_HOME}/bin/mvn clean; )

elif [ $1 = "compile" ]; then
  (cd $DIR_NAME;
  ${M2_HOME}/bin/mvn compile; )

elif [ $1 = "package" ]; then
  (cd $DIR_NAME;
  ${M2_HOME}/bin/mvn package; )

elif [ $1 = "deploy" ]; then
  ${XAP_HOME}/bin/gs.sh deploy-space -cluster schema=partitioned-sync2backup total_members=2,1 mySpace
  ${XAP_HOME}/bin/gs.sh deploy $DIR_NAME/target/HttpSession.war

elif [ $1 = "undeploy" ]; then
  ${XAP_HOME}/bin/gs.sh undeploy HttpSession
  ${XAP_HOME}/bin/gs.sh undeploy mySpace

fi