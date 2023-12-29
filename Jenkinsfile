pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        DOCKER_IMAGE_NAME = 'faniry123/mon_test'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        OLD_DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER - 1}"
    }

    stages {
        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Add your HTML test commands here
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE_TAG}", '.')
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub using credentials
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                        sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker push ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Remove Old Docker Image') {
            steps {
                script {
                    // Remove the old Docker image if it exists
                    def oldImage = docker.image("${OLD_DOCKER_IMAGE_TAG}")
                    if (oldImage) {
                        oldImage.remove()
                    } else {
                        echo "Old Docker image not found. Skipping removal."
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
    }
}
