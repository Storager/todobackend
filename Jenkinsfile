node {
    checkout scm
    
    try {
        stage 'Run unit/integration tests'
        sh 'make test'
        
        stage 'Run build'
        sh 'make build'
        
        stage 'Run release'
        sh 'make release'
        
        stage 'Tag and publish release'
        sh "make tag latest \$(git rev-parse --short HEAD) \$(git tag --points-at HEAD)"
        sh "make buildtag master \$(git rev-parse --points-at HEAD)"
        
        withEnv(["DOCKER_USER=${DOCKER_USER}", 
                  "DOCKER_PASSWORD=${DOCKER_PASSWORD}"]) {
                    sh 'make login'      
                  }
        sh 'make publish'
    }
    finally {
        stage 'Collect test reports'
        step([$class: 'JUnitResultArchiver', testResults: '**/reports/*.xml'])
        
        stage 'Clean up'
        sh 'make clean'
        sh 'make logout'
    }
}