pipeline {
    agent { label 'agency' }
   
    environment {
        DOCKERHUB_CREDS = credentials('docker-hub-credentials')
    }
    stages {
        stage('Backend tests') {
            steps {
                echo 'Backend tests are run here'
            }
        }
        stage('Create & Push Docker Backend Image') {
            steps {
                sh 'docker build -t class_schedule_backend:neo -f ${WORKSPACE}/Dockerfile .'
                sh 'docker tag class_schedule_backend:neo bookuha/class_schedule_backend:neo'
                sh 'docker login --username=$DOCKERHUB_CREDS_USR --password=$DOCKERHUB_CREDS_PSW docker.io'
                sh 'docker push bookuha/class_schedule_backend:neo'
            }
        }
        stage('Frontend tests') {
            steps {
                echo 'Frontend tests are run here'
            }
        }
        stage('Create & Push Frontend Docker Image') {
            steps {
                sh 'docker build -t class_schedule_frontend:neo -f $WORKSPACE/frontend/Dockerfile $WORKSPACE/frontend'
                sh 'docker tag class_schedule_frontend:neo bookuha/class_schedule_frontend:neo'
                sh 'docker login --username=$DOCKERHUB_CREDS_USR --password=$DOCKERHUB_CREDS_PSW docker.io'
                sh 'docker push bookuha/class_schedule_frontend:neo'
            }
        }
        stage('Create infrastructure') {
            steps {
                dir('terraform/aws') {
                    sh 'terraform init'
                    sh 'terraform apply --auto-approve'

                }
            }
        }
    }
}