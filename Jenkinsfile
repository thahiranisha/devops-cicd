pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'thahiranisha/gscomp347test2:latest'
    }

    stages {
        stage('Build') {
            steps {
                bat 'docker build -t my-first-image .'
                bat 'docker tag my-first-image %DOCKER_IMAGE%'
            }
        }

        stage('Test') {
            steps {
                bat 'docker run --rm my-first-image'
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        passwordVariable: 'DOCKER_PASSWORD',
                        usernameVariable: 'DOCKER_USERNAME'
                    )
                ]) {
                    bat '@echo off && echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin docker.io'
                    bat 'docker push %DOCKER_IMAGE%'
                }
            }
        }
    }

    post {
        always {
            bat 'docker logout'
        }
    }
}