pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        IMAGE_NAME = 'mon_html'
    }

    stages {
        stage('SCM Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                echo 'Running HTML tests...'
                // Add your HTML testing commands here
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build IMAGE_NAME:$BUILD_NUMBER
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                            // Login to Docker Hub
                        }
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                    // Push the Docker image to Docker Hub
                    docker.image(IMAGE_NAME).push("${env.BUILD_NUMBER}")
                    }        
                }
            }



        stage('Clean up') {
            steps {
                echo 'Cleaning up...'
                script {
                    // Logout from Docker Hub
                    docker.withRegistry('', 'dockerhub_id') {
                        // Logout
                    }

                    // Remove the local Docker image
                    docker.image(IMAGE_NAME).remove("${env.BUILD_NUMBER}")
                }
            }
        }
    }
}
