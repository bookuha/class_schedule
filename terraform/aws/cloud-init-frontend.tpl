#cloud-config
package_update: true
package_upgrade: true

packages:
  - git

# Install Node.js 18.x
runcmd:
  - curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  - sudo yum install -y nodejs

  - aws codeartifact get-package-version-asset --domain ${codeartifact_domain} --repository ${codeartifact_repository} --region ${codeartifact_region} --package class_schedule_frontend --package-version 0.1.0 --asset package.tgz --format npm /home/ec2-user/frontend-app.tgz

  # Create a directory for the application
  - mkdir -p /opt/app
  - cd /opt/app

  # Extract the downloaded package
  - tar -xzf /home/ec2-user/frontend-app.tgz

  # Navigate into the package directory and install dependencies
  - cd package
  - npm install
  - npm run build

  # Set environment variable for the app
  - echo 'export REACT_APP_API_BASE_URL=http://${api_ip}:8080' >> /etc/environment
  - source /etc/environment

  # Run the app
  - npm start
