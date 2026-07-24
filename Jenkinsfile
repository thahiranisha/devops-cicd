pipeline {
    agent any

    environment {
        DOCKER_EXE = 'C:\\Users\\nisha_m\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe'
        DOCKER_IMAGE = 'thahiranisha/gscomp347test2:latest'
    }

    stages {
        stage('Build') {
            steps {
                bat '"%DOCKER_EXE%" version'
                bat '"%DOCKER_EXE%" build -t my-first-image .'
                bat '"%DOCKER_EXE%" tag my-first-image %DOCKER_IMAGE%'
            }
        }

        stage('Test') {
            steps {
                bat '"%DOCKER_EXE%" run --rm my-first-image'
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
                    bat '@echo off && echo %DOCKER_PASSWORD% | "%DOCKER_EXE%" login -u %DOCKER_USERNAME% --password-stdin docker.io'
                    bat '"%DOCKER_EXE%" push %DOCKER_IMAGE%'
                }
            }
        }
    }

    post {
        always {
            script {
                bat(
                    returnStatus: true,
                    script: '"%DOCKER_EXE%" logout'
                )
            }
        }
    }
}