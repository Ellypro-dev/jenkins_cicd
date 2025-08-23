pipeline {
  agent any

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
          def appPort = (env.BRANCH_NAME == 'main') ? "3000":"3001"
          sh """
	    docker build --build-arg APP_PORT=${appPort} -t myapp:${env.BRANCH_NAME} .
	  """
	}
      }
    }
    stage('Deploy'){
      steps {
        script {
          def appPort = (env.BRANCH_NAME == 'main') ? "3000" : "3001"
          sh"""
            docker stop myapp_${env.BRANCH_NAME} || true
	    docker rm myapp_${env.BRANCH_NAME} || true
	    docker run -d -p ${appPort}:${appPort} --name myapp_${env.BRANCH_NAME} myapp:${env.BRANCH_NAME}
      	  """
          echo "App running at http://localhost:${appPort}"
        }
      }
    }
  }
}
