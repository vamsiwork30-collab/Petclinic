pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven'
    }

    environment {
        SCANNER_HOME = tool 'sonarscanner'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    changelog: false,
                    poll: false,
                    url: 'https://github.com/vamsiwork30-collab/Petclinic.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Nexus') {
            steps {
                withMaven(
                    globalMavenSettingsConfig: 'nexus',
                    jdk: 'jdk17',
                    maven: 'maven',
                    traceability: true
                ) {
                    sh 'mvn clean deploy'
                }
            }
        }

        stage('Sonar Qube Analysis') {
            steps {
                withSonarQubeEnv('sonarserver') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                withDockerRegistry(
                    credentialsId: 'dockertoken',
                    url: 'https://index.docker.io/v1/'
                ) {
                    sh 'docker build -t petclinic .'
                    sh 'docker tag petclinic vamsipothabathuni1/petclinic:latest'
                    sh 'docker push vamsipothabathuni1/petclinic:latest'
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                sh 'trivy image vamsipothabathuni1/petclinic:latest'
            }
        }

        stage('Dependency Check') {
            steps {
                dependencyCheck(
                    additionalArguments: '--scan ./ --format HTML',
                    odcInstallation: 'dc'
                )
                dependencyCheckPublisher(
                    pattern: '**/dependency-check-report.xml'
                )
            }
        }
    }
}
