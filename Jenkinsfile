pipeline {
    agent any
    tools {
        maven 'maven'
    }
    stages {
        stage('pull') {
            steps {
                git branch: 'main', credentialsId: 'ach', url: 'https://github.com/AchuthMPalankar/CA-business-project.git'
            }
        }
        stage('build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('docker image') {
            steps {
                script {
                    sh 'docker build -t achuth .'
                    sh 'docker tag achuth achuthmpalankar/final_mock'
                }
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                        sh "echo ${DOCKERHUB_PASSWORD} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin"
                    }
                }
            }
        }
    }
}
