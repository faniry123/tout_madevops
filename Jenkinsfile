pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
        DOCKER_IMAGE_NAME = 'faniry123/mon_test'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
    }

    

        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Ajoutez vos commandes de test HTML ici
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
                        sh "echo \${DOCKERHUB_PASSWORD} | docker login -u \${DOCKERHUB_USERNAME} --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${DOCKER_IMAGE_TAG}"
            }
        }
    }

        post {
            always {
                sh 'docker logout'
            }
        }
    
}
