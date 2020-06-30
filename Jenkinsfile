node {
/*
    stage ('Clone Master') {
        git credentialsId: 'git-hub-credentials', url: 'https://github.com/jtb75/insecure-apache.git'
    }
*/
    stage ('Embed Defender') {
        withCredentials([usernamePassword(credentialsId: 'embed_cred', passwordVariable: 'EMBED_PW', usernameVariable: 'EMBED_USER')]) {
            container('build') {
                echo 'Embedding..'
                sh label: '', script: '''
                    apk add curl
                    WSS_UP=`curl --insecure -k https://192.168.1.164:8083/api/v1/_ping`
                    if [ "OK" = "$WSS_UP" ]; then
                        echo WSS Is Available
                        curl --insecure -H "Content-Type: application/json" -d '{"username":"$EMBED_USER","password":"$EMBED_PW"}' \
                                  https://192.168.1.164:8083/api/v1/authenticate
                    fi;
                    echo Here
                '''
            }
        }
    }
/*    
    stage ('Build image') {
        container('build') {
            echo 'Building..'
            sh """
            chmod 777 /var/run/docker.sock
            docker build -t webapps/insecure-apache:$BUILD_NUMBER .
            """
        }
    }
    
    stage ('Scan Image') {
        prismaCloudScanImage ca: '',
                    cert: '',
                    dockerAddress: 'unix:///var/run/docker.sock',
                    ignoreImageBuildTime: true,
                    image: 'webapps/insecure-apache:$BUILD_NUMBER',
                    key: '',
                    logLevel: 'info',
                    podmanPath: '',
                    project: '',
                    resultsFile: 'prisma-cloud-scan-results.json'
    }
    
    stage ('Publish Scan Results') {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
    }

    stage ('Push Image') {
        withCredentials([usernamePassword(credentialsId: 'harbor_cred', passwordVariable: 'HARBOR_PW', usernameVariable: 'HARBOR_USER')]) {
            container('build') {
                echo 'Pushing..'
                sh """
                docker tag webapps/insecure-apache:$BUILD_NUMBER 192.168.1.211:80/webapps/insecure-apache:$BUILD_NUMBER
                docker tag webapps/insecure-apache:$BUILD_NUMBER 192.168.1.211:80/webapps/insecure-apache:latest
                docker login --username ${HARBOR_USER} --password ${HARBOR_PW} 192.168.1.211:80
                docker push 192.168.1.211:80/webapps/insecure-apache:$BUILD_NUMBER
                docker push 192.168.1.211:80/webapps/insecure-apache:latest
                """
            }
        }
    }

    stage ('Cleanup') {
            container('build') {
            echo 'Pushing..'
            sh """
            docker rmi 192.168.1.211:80/webapps/insecure-apache:latest
            docker rmi 192.168.1.211:80/webapps/insecure-apache:$BUILD_NUMBER
            docker rmi webapps/insecure-apache:$BUILD_NUMBER
            """
        }
    }
*/
}

