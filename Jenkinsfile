pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image from Dockerfile in the root directory
                    sh 'docker build -t my-app:latest .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    sh 'docker run -d --name my-app-container -p 8080:8080 my-app:latest'
                }
            }
        }
    }

    post {
        always {
            // Stop and remove the container after the pipeline run
            script {
                sh 'docker stop my-app-container || true'
                sh 'docker rm my-app-container || true'
            }
        }
    }
}
