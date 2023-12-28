pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_id')
    }

    stages {
        stage('gitclone') {
            steps {
                git 'https://github.com/faniry123/mon_html.git'
            }
        }

        stage('Test HTML') {
            steps {
                echo 'Running HTML tests...'
                // Ajoutez vos commandes de test HTML ici
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t faniry123/mon_test:${BUILD_NUMBER} ."
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
                sh "docker push faniry123/mon_test:${BUILD_NUMBER}"
            }
        }

        post {
            always {
                sh 'docker logout'
            }
        }
    }
}
