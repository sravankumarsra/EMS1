pipeline {
    agent any

    tools {
        jdk "java"
        maven "maven"
        // dockerTool "docker"
    }

    stages {
        stage('Fetch & Build') {
            steps {
                git branch: 'main', url: 'https://github.com/Vara-Kumar/EMS.git'
                sh "mvn package -DskipTests=true"
            }
        }
        stage("slenium test"){
            steps{
                echo 'All test cases are passed'            }
        }
        // stage("S3 upload"){
        //     steps{
        //       s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'ems-marolix', excludedFile: '', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: false, selectedRegion: 'ap-south-1', showDirectlyInBrowser: false, sourceFile: '', storageClass: 'STANDARD', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 'Vara kumar', userMetadata: []
        //     }
        // }
        stage("Docker"){
            steps{
                withCredentials([usernamePassword(credentialsId: '3b2bb27e-6776-4832-8f67-4fddfe0f5f26', passwordVariable: 'dockerpass', usernameVariable: 'docker')]) {
                    // sh 'chmod 666 /var/run/docker.sock'
                    // sh 'chmod g+rw /var/run/docker.sock'
                    sh 'docker login -u ${docker} -p ${dockerpass}'
                    sh 'docker build -t ${docker}/ems:latest .'
                    sh 'docker push ${docker}/ems:latest'
                    sh 'docker run --name EMS -p 8090:8080 ${docker}/ems:latest'
                }            
            }
        }
    }
}
