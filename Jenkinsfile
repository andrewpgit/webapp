pipeline {
    agent { 
        docker { image 'alpine'}
    }
    environment {
        VER = '19.03.4'
        TAG =  "${env.BRANCH_NAME}"

    }

    options {
        buildDiscarder(logRotator(numToKeepStr:'7'))
        timestamps() 
    }   
   
    stages {

        stage('Install dependencies') {
            steps {
                sh "env"
                echo "Install package"
                sh '''
                      apk add  gcc libc-dev make git
                      wget -O /tmp/docker-${VER}.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${VER}.tgz
                      tar -xz -C /tmp -f  /tmp/docker-${VER}.tgz
                      mv  /tmp/docker/*  /usr/local/bin/
                    '''
            }
        }
        stage ("Build image") {
            steps {
                echo "Build"
                sh 'make -e TAG=${TAG} build'
            }
        }

        stage ("Push image to repo"){
            steps {
                echo "Push to Docker repo"
                 withDockerRegistry(credentialsId: 'b7ca1bd5-fbe5-4c50-afc5-9c3cceff84cd', url: ""){
                    sh 'make -e TAG=${TAG} release'
                 }
            }
        }
    }
}
