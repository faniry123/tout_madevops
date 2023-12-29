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
                // Ajoutez vos commandes de test HTML ici
            }
        }

        stage('Build') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_TAG} ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'faniry123', passwordVariable: 'XBL+s-R9sTefw&t')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                            def loginCommand = "docker login -u ${faniry123} --password-stdin"
                            sh "echo -n \${DOCKERHUB_PASSWORD} | ${loginCommand}"
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
