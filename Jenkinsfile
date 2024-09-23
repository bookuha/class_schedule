pipeline {
    agent { label 'agency' }

    environment {
        DOCKERHUB_CREDS = credentials('docker-hub-credentials')
    }

    stages {
        stage('Backend tests') {
            steps {
                echo 'Running backend tests'
                // Add your backend test commands
            }
        }
        stage('Create & Push Docker Backend Image') {
            environment {
                BACKEND_IMAGE = 'class_schedule_backend:neo'
                DOCKER_REPO = 'bookuha'
            }
            steps {
                sh 'docker build -t $BACKEND_IMAGE -f ${WORKSPACE}/Dockerfile .'
                sh 'docker tag $BACKEND_IMAGE $DOCKER_REPO/$BACKEND_IMAGE'
                sh 'docker login --username=$DOCKERHUB_CREDS_USR --password=$DOCKERHUB_CREDS_PSW docker.io'
                sh 'docker push $DOCKER_REPO/$BACKEND_IMAGE'
            }
        }
        stage('Frontend tests') {
            steps {
                echo 'Running frontend tests'
                // Add your frontend test commands
            }
        }
        stage('Create & Push Frontend Docker Image') {
            environment {
                FRONTEND_IMAGE = 'class_schedule_frontend:neo'
                DOCKER_REPO = 'bookuha'
            }
            steps {
                sh 'docker build -t $FRONTEND_IMAGE -f $WORKSPACE/frontend/Dockerfile $WORKSPACE/frontend'
                sh 'docker tag $FRONTEND_IMAGE $DOCKER_REPO/$FRONTEND_IMAGE'
                sh 'docker login --username=$DOCKERHUB_CREDS_USR --password=$DOCKERHUB_CREDS_PSW docker.io'
                sh 'docker push $DOCKER_REPO/$FRONTEND_IMAGE'
            }
        }
        stage('Create infrastructure') {
            environment {
                TERRAFORM_WORKSPACE = 'terraform/aws'
                TF_VAR_aws_access_key_id = credentials('aws-tf-access-key-id')
                TF_VAR_aws_secret_access_key = credentials('aws-tf-secret-access-key')
            }
            steps {
                dir(TERRAFORM_WORKSPACE) {
                    sh 'terraform init'
                    sh 'terraform apply --auto-approve'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo 'Pipeline succeeded'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}