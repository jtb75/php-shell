node {

    stage ('Clone Master') {
        git credentialsId: 'git-hub-credentials', url: 'https://github.com/jtb75/insecure-apache.git'
    }
    
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
        environment {
            HARBOR_COMMON_CRED = credentials('harbor_cred')
        }
        container('build') {
            echo 'Pushing..'
            sh """
            sleep 300
            cat /etc/docker/daemon.json
            docker tag webapps/insecure-apache:$BUILD_NUMBER 192.168.1.211/webapps/insecure-apache:$BUILD_NUMBER
            docker tag webapps/insecure-apache:$BUILD_NUMBER 192.168.1.211/webapps/insecure-apache:latest
            docker push 192.168.1.211/webapps/insecure-apache:$BUILD_NUMBER
            docker push 192.168.1.211/webapps/insecure-apache:latest
            """
        }
    }
}
