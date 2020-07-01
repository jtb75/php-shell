node {
    
    stage ('Clone Master') {
        git credentialsId: 'git-hub-credentials', url: 'https://github.com/jtb75/insecure-apache.git'
    }
    
    stage ('Embed Defender') {
        withCredentials([usernamePassword(credentialsId: 'embed_cred', passwordVariable: 'EMBED_PW', usernameVariable: 'EMBED_USER')]) {
            container('build') {
                echo 'Embedding..'
                sh label: '', script: '''apk add curl
                WSS_UP=`curl --insecure -k https://192.168.1.164:8083/api/v1/_ping`
                if [ "OK" = "$WSS_UP" ]; then
                    echo "Generating Authentication Token..."
                    TOKEN=`curl --insecure -H "Content-Type: application/json" -d \'{"username":"install","password":"install"}\' \\
                              https://192.168.1.164:8083/api/v1/authenticate  | cut -d\\" -f4`
                    echo "Downloading current twistcli..."
                    curl --progress-bar -L -k --header "authorization: Bearer ${TOKEN}" \\
                              https://192.168.1.164:8083/api/v1/util/twistcli > twistcli; chmod a+x twistcli;
                    ./twistcli app-embedded embed \\
                              --token ${TOKEN} \\
                              --address "https://192.168.1.164:8083" \\
                              --console-host 192.168.1.164 \\
                              -app-id "Apache" \\
                              --data-folder "/tmp" \\
                              Dockerfile
                    echo "Backing up original Dockerfile..."
                    mv Dockerfile Dockerfile.orig
                    echo "Extracting new Dockerfile and Defender..."
                    unzip app_embedded_embed_Apache.zip
                fi'''
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

