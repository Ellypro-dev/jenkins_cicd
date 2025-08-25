pipeline {
  agent any
  tools {
    nodejs "node"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        sh './scripts/build.sh'
      }
    }
    stage('Test') {
      steps {
        sh './scripts/test.sh'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          def imageName = (env.BRANCH_NAME == 'main') ? "nodemain:v1.0" : "nodedev:v1.0"
          def appPort = (env.BRANCH_NAME == 'main') ? "3000":"3001"
          sh """
	    docker build --build-arg APP_PORT=${appPort} -t ${imageName} .
	  """
	}
      }
    }
    stage('Deploy'){
      steps {
        script {
          def imageName = (env.BRANCH_NAME == 'main' ) ? "nodemain:v1.0" : "nodedev:v1.0"
          def appPort = (env.BRANCH_NAME == 'main') ? "3000" : "3001"
          sh"""
            docker stop myapp_${env.BRANCH_NAME} || true
	    docker rm myapp_${env.BRANCH_NAME} || true
	    docker run -d -p ${appPort}:${appPort} --name myapp_${env.BRANCH_NAME} ${imageName}
      	  """
          echo "App running at http://localhost:${appPort}"
        }
      }
    }
  }
}
