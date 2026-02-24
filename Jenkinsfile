pipeline {
    agent any

    tools {
        jdk "jdk17"
        maven "Maven"
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main',
                    changelog: false,
                    poll: false,
                    url: 'https://github.com/vamsiwork30-collab/Petclinic.git'
            }
        }

        stage('Maven Build') {
            steps {
                sh "mvn clean package -DskipTests"
            }
        }

        stage('Docker Build & Push') {
            steps {
                withDockerRegistry(
                    credentialsId: 'dockertoken',
                    url: 'https://index.docker.io/v1/'
                ) {
                    sh "docker build -t petclinic ."
                    sh "docker tag petclinic vamsipothabathuni1/petclinic:latest"
                    sh "docker push vamsipothabathuni1/petclinic:latest"
                }
            }
        }
    }
}
