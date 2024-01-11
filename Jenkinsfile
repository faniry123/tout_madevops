pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('id_hub')
        DOCKER_IMAGE_NAME = 'faniry123/ma_front_html'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        OLD_DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER - 1}"

        // Slack tokens
        SLACK_CHANNEL = '#slacknotification'
        SLACK_CREDENTIALS_ID = 'token_slack'
    }

    stages {
        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Add your HTML test commands here
            }
            post {
                success {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#36a64f',
                                message: "TEST réussi!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsup:'
                            )
                        }
                    }
                }
                failure {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#ff0000',
                                message: "Échec du TEST!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
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
            post {
                success {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#36a64f',
                                message: "BUILD réussi!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsup:'
                            )
                        }
                    }
                }
                failure {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#ff0000',
                                message: "Échec du BUILD!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsdown:'
                            )
                        }
                    }
                }
            }
            
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub using credentials
                    withCredentials([usernamePassword(credentialsId: 'id_hub', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                        sh "echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    }
                }
            }

             post {
                success {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#36a64f',
                                message: "LOGIN TO DOCKER réussi!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsup:'
                            )
                        }
                    }
                }
                failure {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#ff0000',
                                message: "Échec du LOGIN TO DOCKER!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsdown:'
                            )
                        }
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

            post {
                success {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#36a64f',
                                message: "Push to Docker Hub réussi!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsup:'
                            )
                        }
                    }
                }
                failure {
                    script {
                        withCredentials([string(credentialsId: "${SLACK_CREDENTIALS_ID}", variable: 'SLACK_TOKEN')]) {
                            slackSend(
                                color: '#ff0000',
                                message: "Échec du Push to Docker Hub!",
                                channel: "${SLACK_CHANNEL}",
                                teamDomain: 'fanirysiege',
                                tokenCredentialId: "${SLACK_CREDENTIALS_ID}",
                                iconEmoji: ':thumbsdown:'
                            )
                        }
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
