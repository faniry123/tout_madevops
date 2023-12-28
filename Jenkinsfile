pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
    }

    stages {
        stage('SCM Checkout') {
            steps {
                git 'https://github.com/faniry123/mon_html.git'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test commands here
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t faniry123/mon_html:$BUILD_NUMBER .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh "echo \${DOCKERHUB_CREDENTIALS_PSW} | docker login -u \${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push faniry123/mon_html:$BUILD_NUMBER"
            }
        }

        stage('Clean up') {
            steps {
                echo 'Cleaning up...'
                script {
                    // Logout from Docker Hub
                    sh 'docker logout'

                    // Remove the local Docker image
                    sh "docker rmi faniry123/mon_html:$BUILD_NUMBER"
                }
            }
        }
    }
}
