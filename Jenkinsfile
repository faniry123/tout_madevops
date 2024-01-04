pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('ma_dockerhub')
        DOCKER_IMAGE_NAME = 'faniry123/ma_front_html'
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
                    withCredentials([usernamePassword(credentialsId: 'ma_dockerhub', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
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

    }

    post {
        success {
            echo 'La pipeline a été exécutée avec succès!'
            emailext subject: 'Build réussi',
                      body: 'La pipeline a été exécutée avec succès.',
                      to: 'pascalindenis70@gmail.com',
                      attachLog: true
        }
        
        failure {
            echo 'La pipeline a échoué. Des actions correctives sont nécessaires.'
        }
        
        always {
            sh 'docker logout'
        }
    }
}
