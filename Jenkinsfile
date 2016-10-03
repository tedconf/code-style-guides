properties([
  pipelineTriggers([
    cron('@daily')
  ])
]);

node {
  stage('git pull') {
    checkout scm
  }

  stage('lint') {
    rvm.exec 'bundle exec rake'
  }
}
