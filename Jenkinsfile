node {
    
    stage ('Clone Master') {
        git 'https://github.com/jtb75/insecure-apache.git'
    }
    
    stage ('Build image') {
        container('build') {
            echo 'Building..'
            sh """
            chmod 777 /var/run/docker.sock
            docker build -t jtb75/insecure-apache:latest .
            """
        }
    }
    
    stage ('Scan Image') {
        prismaCloudScanImage ca: '',
                    cert: '',
                    dockerAddress: 'unix:///var/run/docker.sock',
                    ignoreImageBuildTime: true,
                    image: 'jtb75/insecure-apache:latest',
                    key: '',
                    logLevel: 'info',
                    podmanPath: '',
                    project: '',
                    resultsFile: 'prisma-cloud-scan-results.json'
    }
    
    stage ('Publish') {
        prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
    }
    
}
