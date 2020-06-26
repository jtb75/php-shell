node {
    
    stage ('Clone Master') {
        git credentialsId: 'git-hub-credentials', url: 'https://github.com/jtb75/insecure-apache.git'
    }
    
    stage ('Build image') {
        container('build') {
            echo 'Building..'
            sh """
            chmod 777 /var/run/docker.sock
            docker build -t jtb75/insecure-apache:$BUILD_NUMBER .
            """
        }
    }
    
    stage ('Scan Image') {
        prismaCloudScanImage ca: '',
                    cert: '',
                    dockerAddress: 'unix:///var/run/docker.sock',
                    ignoreImageBuildTime: true,
                    image: 'jtb75/insecure-apache:$BUILD_NUMBER',
                    key: '',
                    logLevel: 'info',
                    podmanPath: '',
                    project: '',
                    resultsFile: 'prisma-cloud-scan-results.json'
    }
    
    stage ('Publish Scan Results') {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
    }
    
}
