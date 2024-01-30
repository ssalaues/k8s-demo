#!/bin/bash
set -ex

for i in 1 2; do
cat <<- EOF > service${i}.yml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: service-${i}
    labels:
        app: service-${i}
    spec:
    replicas: 1
    selector:
        matchLabels:
        app: service-${i}
    template:
        metadata:
        labels:
            app: service-${i}
        spec:
        containers:
        - name: server
            image: test-service:${GITHUB_SHA:-latest}
            command:
            - bash
            - -exc
            - |
                while true; do
                echo "server-${i} up"
                sleep 1
                done
EOF
done