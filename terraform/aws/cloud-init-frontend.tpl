#cloud-config
package_update: true
package_upgrade: true

packages:
  - curl
  - git

# Install Node.js 18.x
runcmd:
  - curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  - sudo yum install -y nodejs

  - wget --user={artifactory_username} --password={artifactory_password} "https://artifactory.bookuha.com/artifactory/libs-release-local/node-app.tar.gz" -O /home/ec2-user/node-app.tar.gz
  - cd /home/ec2-user
  - tar -xzf node-app.tar.gz
  - cd node-app
  - npm install
  - npm run build

  # Set environment variable for the app
  - echo 'export REACT_APP_API_BASE_URL=http://${api_ip}:8080' >> /etc/environment
  - source /etc/environment

  # Run the app
  - cd /opt/app && npm start
