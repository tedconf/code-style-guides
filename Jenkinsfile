properties([
  pipelineTriggers([
    cron('@daily')
  ])
]);

node {
  stage('git pull') {
    checkout scm
  }

  stage('prep') {
    // reinstall gems periodically
    if (tedUtil.isBuildCauseTimer()) {
      echo "Build was started by a timer, blowing away the gemset"
      rvm.emptyGemset()
    } else {
      echo "Build not started by a timer. Not emptying gemset."
    }

    rvm.exec "bundle install"
  }

  stage('lint') {
    rvm.exec 'bundle exec rake'
  }
}
