workflow "build" {
  on = "push"
  resolves = ["GitHub Action for Maven-1"]
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

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@712ea355b0921dd7aea27d81e247c48d0db24ee4"
  needs = ["mvn clean install"]
  args = "branch release"
}

action "GitHub Action for Maven-1" {
  uses = "LucaFeger/action-maven-cli@9d8f23af091bd6f5f0c05c942630939b6e53ce44"
  needs = ["Filters for GitHub Actions"]
  args = "release:clean release:prepare release:perform"
}
