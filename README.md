## pipeline
---
```bash
pipeline {
    agent any

    tools {
        maven 'maven'
    }

    environment {
        IMAGE_NAME = 'achuthmpalankar/final_mock:latest'
        CONTAINER_NAME = 'final_mock_container'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080' 
        WAR_FILE_PATH = 'target/pal.war'
    }

    stages {
        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Ensure the WAR file is built and available
                    sh 'mvn clean package' // Adjust if using a different build tool

                    // Build the Docker image
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed."
        }
    }
}
```
---
