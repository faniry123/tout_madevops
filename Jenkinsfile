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
                    withCredentials([usernamePassword(credentialsId: registryCredential, usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "echo \$DOCKERHUB_PASSWORD | docker login -u \$DOCKERHUB_USERNAME --password-stdin"
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
