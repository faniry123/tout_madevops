pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('id_hub')
        DOCKER_IMAGE_NAME = 'faniry123/ma_front_html'
        DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
        OLD_DOCKER_IMAGE_TAG = "${DOCKER_IMAGE_NAME}:${BUILD_NUMBER - 1}"
        //Slack_tokens
        slack_tokens = 'slack_token'
        //Slack_channel
        slackSend_channel = ''
        //front or Back or API
        first_imagename = ''
        //Client Name
        client = ''
        // Language
        second_image_name = ''
        // Image name
        image_name = '${first_imagename}_${client}_${second_image_name}'
    }

    stages {
        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Add your HTML test commands here
            post {
                success {
                    slackSend(
                        channel: "${slackSend_channel}",
                        message: "-------------------*************** Test bebebebe stage succeeded ***************-----------------",
                        teamDomain: 'fanirysiege',
                        tokenCredentialId: "${slack_tokens}",
                        color: 'good',
                        iconEmoji: ':thumbsup:'
                    )
                }
                failure {
                    slackSend(
                        channel: "${slackSend_channel}",
                        message: "Test stage failed",
                        teamDomain: 'fanirysiege',
                        tokenCredentialId: "${slack_tokens}",
                        color: 'danger',
                        iconEmoji: ':thumbsdown:'
                    )
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
                    // Log in to Docker Hub using credentials
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
