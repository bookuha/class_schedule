pipeline {
    agent any
    
    environment {
        AWS_CODEARTIFACT_DOMAIN = credentials('aws-codeartifact-domain')
        AWS_ACCOUNT_ID = credentials('aws-account-id')
        AWS_REGION = credentials('aws-region')
        AWS_CODEARTIFACT_REPO = credentials('aws-codeartifact-repo')
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

        stage('Build Frontend Locally') {
            environment {
                REACT_APP_API_BASE_URL="http://${env.BACKEND_IP}:8080"
            }
            steps {
                dir('frontend') {
                    // Default registry for NPM packages. Required, since .npmrc has our CodeArtifact registry specified as the only one.
                    sh 'npm install --registry=https://registry.npmjs.org'
                    sh 'npm run build'
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
                            --extra-vars "db_host=${POSTGRES_IP} db_password=${DB_PASS} redis_host=${REDIS_IP} mongo_default_server_cluster=${MONGO_IP} workspace_path=${WORKSPACE}" \
                            -u ec2-user \
                            --private-key ~/.ssh/id_rsa
                        """

                        // Run Frontend Playbook
                        sh """
                            ansible-playbook -i ${FRONTEND_IP}, frontend_playbook.yml \
                            --extra-vars "api_ip=${BACKEND_IP} workspace_path=${WORKSPACE}" \
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
