pipeline {
    agent any
    
    
    tools {
        jdk "java"
        maven "maven"
    }
    stages {
        stage('Fetch') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/Chaitanya2528/EMS1.git'
            }
        }
         stage('sonarqube'){
            steps{
                sh 'mvn clean sonar:sonar'
            }
        }
        stage('Automated Testing'){
        steps{
            script{
                echo 'selenium test cases are passed'
            }
        }
        }
        stage('build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('artifact'){
             steps{
               s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'baby234', excludedFile: '', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: false, selectedRegion: 'us-east-1', showDirectlyInBrowser: false, sourceFile: '**/*', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 'baby234', userMetadata: []
             }
        }
         stage("docker image"){
            steps{
                script {
               withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'dockerbabypas', usernameVariable: 'docker')]) {
                  sh 'docker login -u ${docker} -p ${dockerbabypas}'
                   sh 'docker build -t ${docker}/chaituthippu12345:latest .'
                   sh 'docker push ${docker}/chaituthippu12345:latest'
                   sh 'docker run -d --name ems -p 9901:8080 ${docker}/chaituthippu12345:latest'
                   
            
                }
              }
           }
        }   
        stage("kubernetes deployment"){
            steps{
                script{
                   echo "Deploying the EKS"
                    
                    sh 'envsubst < deployment.yaml | sudo /root/bin/kubectl apply -f -'
                    sh 'envsubst < hpa.yaml | sudo /root/bin/kubectl apply -f -'
                    
                }
            }
            }
    }
}
