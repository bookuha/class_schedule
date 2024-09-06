pipeline {
    agent { label 'agency' }
   
    environment {
        DOCKERHUB_CREDS = credentials('docker-hub-credentials')
    }
    stages {
        stage('Create & Push Docker Image') {
            steps {
                sh 'docker build -t class_schedule_backend:neo -f ${WORKSPACE}/Dockerfile .'
                sh 'docker tag class_schedule_backend:neo bookuha/class_schedule_backend:neo'
                sh 'docker login --username=$DOCKERHUB_CREDS_USR --password=$DOCKERHUB_CREDS_PSW docker.io'
                sh 'docker push bookuha/class_schedule_backend:neo'
            }
        }
        stage('Clean') {
            steps {
                try {
                    sh 'docker rmi -f $(docker images -q -f dangling=true)'
                }
                catch(Exception e) {
                    echo 'No dangling images found. '
                }
            }
        }
    }
}