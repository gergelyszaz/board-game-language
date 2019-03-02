workflow "build" {
  on = "push"
  resolves = [
    "deploy snapshot",
    "mvn clean install",
  ]
}

action "mvn clean install" {
  uses = "LucaFeger/action-maven-cli@9d8f23af091bd6f5f0c05c942630939b6e53ce44"
  args = "clean install"
}

workflow "pull-request-test" {
  on = "pull_request"
  resolves = ["GitHub Action for Maven"]
}

action "GitHub Action for Maven" {
  uses = "LucaFeger/action-maven-cli@9d8f23af091bd6f5f0c05c942630939b6e53ce44"
  args = "clean install"
}

action "master only" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  needs = ["mvn clean install"]
  args = "branch master"
}

action "deploy snapshot" {
  uses = "LucaFeger/action-maven-cli@9d8f23af091bd6f5f0c05c942630939b6e53ce44"
  args = "deploy"
  needs = ["master only"]
}
