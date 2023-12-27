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
                    sh "docker rmi ${registry}:${BUILD_NUMBER}"
                }
            }
        }
    }
}
