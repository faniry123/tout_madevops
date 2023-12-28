pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        DOCKER_IMAGE_NAME = 'mon_html'
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Add your HTML testing commands here
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                            def loginCommand = "docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                            sh "echo \${DOCKERHUB_PASSWORD} | ${loginCommand}"
                        }
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        docker.image("${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                script {
                    // Logout from Docker Hub
                    docker.withRegistry('', 'dockerhub_id') {
                        // Logout
                    }

                    // Remove the local Docker image
                    docker.image("${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}").remove()
                }
            }
        }
    }
}
