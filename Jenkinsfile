pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        DOCKER_IMAGE_NAME = 'faniry123/mon_test'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
    }

    stages {
        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Add your HTML testing commands here
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE_TAG} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                            sh "echo \${DOCKERHUB_PASSWORD} | docker login -u \${DOCKERHUB_USERNAME} --password-stdin"
                        }
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                        sh "docker push ${DOCKER_IMAGE_TAG}"
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
