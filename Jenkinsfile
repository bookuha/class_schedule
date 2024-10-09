pipeline {
    agent any
    
    environment {
        DOCKERHUB_CREDS = credentials('docker-hub-credentials')
        AWS_CODEARTIFACT_DOMAIN = credentials('aws-codeartifact-domain')
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        AWS_REGION = credentials('aws-region')
        AWS_CODEARTIFACT_REPO = credentials('aws-codeartifact-repo')
    }

    stages {
        stage('Backend tests') {
            steps {
                echo 'Running backend tests'
                // Testing is done here.
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
                // Testing is done here.
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

        stage('Publish Backend to AWS CodeArtifact') {
            steps {
                sh 'chmod +x publish_to_codeartifact.sh'
                sh "./publish_to_codeartifact.sh"
            }
        }

        stage('Publish Frontend to AWS CodeArtifact') {
            steps {
                dir('frontend') {
                    sh 'chmod +x publish_to_codeartifact.sh'
                    sh "./publish_to_codeartifact.sh"
                }
            }
        }

        stage('Create AWS infrastructure') {
            environment {
                TF_VAR_aws_access_key_id = credentials('aws-tf-access-key-id')
                TF_VAR_aws_secret_access_key = credentials('aws-tf-secret-access-key')
                TF_VAR_postgres_username = credentials('aws-rds-postgres-username')
                TF_VAR_postgres_password = credentials('aws-rds-postgres-password')
            }
            steps {
                dir('terraform/aws') {
                    sh 'terraform init'
                    sh 'terraform apply --auto-approve'
                    script {
                        env.FRONTEND_IP = sh(script: 'terraform output -raw frontend_instance_public_ip', returnStdout: true).trim()
                        env.BACKEND_IP = sh(script: 'terraform output -raw backend_instance_public_ip', returnStdout: true).trim()
                        env.MONGO_IP = sh(script: 'terraform output -raw mongo_instance_public_ip', returnStdout: true).trim()
                        env.POSTGRES_IP = sh(script: 'terraform output -raw postgres_instance_public_ip', returnStdout: true).trim()
                        env.REDIS_IP = sh(script: 'terraform output -raw redis_instance_public_ip', returnStdout: true).trim()
                    }
                }
            }
        }

        stage('Run Ansible Playbooks') {
            environment {
                ANSIBLE_HOST_KEY_CHECKING='False'
                DB_PASS = credentials('aws-rds-postgres-password')
            }
            steps {
                script {
                    dir('ansible') {
                        // Run Backend Playbook
                        sh """
                            ansible-playbook -i ${BACKEND_IP}, backend_playbook.yml \
                            --extra-vars "db_host=${POSTGRES_IP} db_password=${DB_PASS} redis_host=${REDIS_IP} mongo_current_db=${MONGO_IP}" \
                            -u ec2-user \
                            --private-key ~/.ssh/id_rsa
                        """

                        // Run Frontend Playbook
                        sh """
                            ansible-playbook -i ${FRONTEND_IP}, frontend_playbook.yml \
                            --extra-vars "api_ip=${BACKEND_IP}" \
                            -u ec2-user \
                            --private-key ~/.ssh/id_rsa
                        """
                    }
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
