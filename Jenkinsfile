pipeline {
    agent any

    environment {
        registry = "faniry123/ma_repohub"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }

    stages {
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test commands here
            }
        }

        stage('Build') {
            steps {
                echo 'Building the Docker image...'
                script {
                    dockerImage = docker.build("${registry}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([string(credentialsId: registryCredential, variable: 'DOCKERHUB_CREDENTIALS')]) {
                        sh "echo $DOCKERHUB_CREDENTIALS | docker login -u your_dockerhub_account --password-stdin"
                    }

                    // Push the Docker image
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                echo 'Cleaning up...'
                script {
                    // Logout from Docker Hub
                    sh 'docker logout'
                    
                    // Remove the local Docker image
                    sh "docker rmi ${registry}:${BUILD_NUMBER}"
                }
            }
        }
    }
}
