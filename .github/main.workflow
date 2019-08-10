workflow "Test Pull Request" {
  on = "pull_request"
  resolves = [
    "Test"
  ]
}

workflow "Deploy Snapshot" {
  on = "push"
  resolves = [
    "Deploy"
  ]
}

action "Compile" {
  uses = "LucaFeger/action-maven-cli@9d8f23af091bd6f5f0c05c942630939b6e53ce44"
  args = "clean compile"
}

action "Test" {
  uses = "LucaFeger/action-maven-cli@9d8f23af091bd6f5f0c05c942630939b6e53ce44"
  needs = "Compile"
  args = "test"
}

action "master only" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  args = "branch master"
}

action "Deploy" {
  uses = "gergelyszaz/action-maven-cli@master"
  args = "clean deploy"
  needs = ["master only"]
  secrets = [
    "OSSRH_PASSWORD", "OSSRH_USERNAME"
  ]
}
