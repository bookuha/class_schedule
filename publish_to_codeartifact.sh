export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain class-schedule --domain-owner <placeholder> --region eu-north-1 --query authorizationToken --output text`
export JAVA_HOME='/c/Program Files/Java/jdk-11.0.2'
export PATH=$JAVA_HOME/bin:$PATH
gradle publish