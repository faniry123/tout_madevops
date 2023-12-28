pipeline {
    environment {
        registry = "faniry123/ma_repohub"
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }
    agent any
    
        stage('Build image') {
            steps {
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
        stage('Cleaning up') {
            steps {
                sh "docker rmi ${registry}:${BUILD_NUMBER}"
            }
        }
    }
}
