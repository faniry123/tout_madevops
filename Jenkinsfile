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
                    docker.build("${DOCKER_IMAGE_TAG}", '.')
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'DOCKERHUB_LOGIN', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {
                            def loginCommand = "docker login -u ${DOCKERHUB_LOGIN} -p ${DOCKERHUB_PASSWORD} --password-stdin"
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
                        docker.push("${DOCKER_IMAGE_TAG}")
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
