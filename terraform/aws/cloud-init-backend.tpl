#cloud-config
package_update: true
package_upgrade: true

packages:
  - java-11-amazon-corretto-headless
  - git
  - postgresql15

runcmd:
  # Install Tomcat 9
  - wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz -P /tmp
  - tar -xzf /tmp/apache-tomcat-9.0.93.tar.gz -C /opt
  - ln -s /opt/apache-tomcat-9.0.93 /opt/tomcat
  - chmod +x /opt/tomcat/bin/catalina.sh
  - mkdir -p /opt/tomcat/webapps

  # Set environment variables for DB, Redis, and MongoDB
  - echo 'export DB_HOST=${db_host}' >> /etc/environment
  - echo 'export DB_PORT=${db_port}' >> /etc/environment
  - echo 'export DB_USER=${db_user}' >> /etc/environment
  - echo 'export DB_PASSWORD=${db_password}' >> /etc/environment
  - echo 'export DB_NAME=${db_name}' >> /etc/environment
  - echo 'export REDIS_HOST=${redis_host}' >> /etc/environment
  - echo 'export REDIS_PORT=${redis_port}' >> /etc/environment
  - echo 'export MONGO_CURRENT_DB=${mongo_current_db}' >> /etc/environment
  - echo 'export MONGO_DEFAULT_SERVER_CLUSTER=${mongo_default_server_cluster}' >> /etc/environment
  - source /etc/environment

  - rm -rf opt/tomcat/webapps/ROOT # Removes Tomcat's starting web app
  - aws codeartifact get-package-version-asset --domain ${codeartifact_domain} --repository ${codeartifact_repository} --region ${codeartifact_region} --package 1 --package-version 1 --asset 1-1.war --format maven --namespace com.class_schedule opt/tomcat/webapps/ROOT.war

  ## - sudo dnf install postgresql15
  # Install restore_backup.sh script.
  - wget -O /usr/local/bin/restore_backup.sh https://raw.githubusercontent.com/bookuha/class_schedule/main/scripts/restore_backup.sh
  - chmod +x /usr/local/bin/restore_backup.sh
  - wget -O /backup/backup.dump https://raw.githubusercontent.com/bookuha/class_schedule/refs/heads/main/backup/backup.dump
  - /usr/local/bin/restore_backup.sh

  # Start Tomcat
  - /opt/tomcat/bin/catalina.sh run
