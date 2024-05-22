pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'mihrinurilunt/app'  // Docker Hub repository
        DOCKER_CREDENTIALS = 'Jenkins'  // Jenkins credentials id for Docker Hub
        GITHUB_TOKEN = credentials('GithubToken')  // Jenkins credentials id for GitHub token
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mihrinurilunt/project3--devops'
            }
        }

        stage('Build JAR') {
            steps {
                script {
                    bat './gradlew clean bootJar'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    DOCKER_IMAGE = docker.build("mihrinurilunt/devops:latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', DOCKER_CREDENTIALS) {
                        DOCKER_IMAGE.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline finished successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        always {
            echo 'Pipeline finished.'
        }
    }
}
