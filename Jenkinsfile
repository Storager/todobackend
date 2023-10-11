node {
    checkout scm
    
    try {
        stage 'Run unit/integration tests'
        sh "alias docker-compose='docker compose'"
        sh 'make test'
        
        stage 'Run build'
        sh 'make build'
        
        stage 'Run release'
        sh 'make release'
        
        stage 'Tag and publish release'
        sh "make tag 0.1 latest \$(git rev-parse --short HEAD)\$(git tag --points-at HEAD)"
        sh "make buildtag 0.1 \$(git rev-parse --abbrev-ref HEAD)"
        
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