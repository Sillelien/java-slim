#!/usr/bin/env bash
set -ex
cd helloworld
mvn clean install -Dmaven.test.skip=true
cd -
cd builder
docker build -t java-slim .
cd -
cd helloworld
ls -la /run/docker.sock
docker run -ti --privileged -v /run/docker.sock:/run/docker.sock -v $(pwd)/:/build/ java-slim helloworld hello-world target/java-slim.helloworld-1.0-SNAPSHOT.jar src/main/resources sillelien.HelloWorld
cd -
docker run -ti helloworld

