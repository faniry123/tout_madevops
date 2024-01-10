pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('id_hub')
        DOCKER_IMAGE_NAME = 'faniry123/ma_front_html'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        SLACK_CREDENTIALS_ID = 'slack_token'
        SLACK_CHANNEL = '#slacknotification'
    }

    stages {
        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Ajoutez vos commandes de test HTML ici
            }
            post {
                success {
                    script {
                        withCredentials([string(credentialsId: SLACK_CREDENTIALS_ID, variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#36a64f',
                                message: "TEST réussi!",
                                channel: SLACK_CHANNEL,
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: SLACK_CREDENTIALS_ID,
                                iconEmoji: ':thumbsup:'
                            )
                        }
                    }
                }
                failure {
                    script {
                        withCredentials([string(credentialsId: SLACK_CREDENTIALS_ID, variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#ff0000',
                                message: "Échec du TEST!",
                                channel: SLACK_CHANNEL,
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: SLACK_CREDENTIALS_ID,
                                iconEmoji: ':thumbsdown:'
                            )
                        }
                    }
                }
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
                    // Se connecter à Docker Hub en utilisant les informations d'identification
                    withCredentials([usernamePassword(credentialsId: 'id_hub', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
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
