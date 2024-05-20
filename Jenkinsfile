pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('DOCKER_HUB_CREDENTIALS')
    }
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-creds', url: 'https://github.com/merveaa/project3--devops', branch: 'main'
            }
        }
        stage('Build JAR') {
            steps {
                bat 'gradlew clean bootJar'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t merveagacayak/app .'
            }
        }
        stage('Login to DockerHub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_CREDENTIALS', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat 'echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin'
                    }
                }
            }
        }
        stage('Push Image to DockerHub') {
            steps {
                bat 'docker push merveagacayak/app'
            }
        }
        stage('Deploy to Minikube') {
            steps {
                script {
                    bat 'kubectl apply -f deployment.yml'
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
