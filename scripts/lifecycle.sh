#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

# shellcheck source=./common.sh
source "$CURR_DIR/common.sh";

section "Create a Cluster"

# Create cluster milkyway. Expose Kubernetes API on localhost:6550. 2 nodes 1 master 1 agent. map local 8080 om cluster's lb 80.

# info "Cluster Name: milkyway"
# info "--api-port 6550: expose the Kubernetes API on localhost:6550 (via loadbalancer)"
# info "--servers 1: create 1 server node"
# info "--agents 1: create 1 agent nodes"
# info "--port 8080:80@loadbalancer: map localhost:8080 to port 80 on the loadbalancer (used for ingress)"
# info "--volume /tmp/src:/src@all: mount the local directory /tmp/src to /src in all nodes (used for code)"
# info "--wait: wait for all server nodes to be up before returning"
info_pause_exec "Create a cluster" "k3d cluster create milkyway --api-port 6550 --servers 1 --agents 1 --port 8080:80@loadbalancer --volume $(pwd)/sample:/src@all --wait"

section "Access the Cluster"

info_pause_exec "List clusters" "k3d cluster list"

info_pause_exec "Update the default kubeconfig with the new cluster details" "k3d kubeconfig merge milkyway --merge-default-kubeconfig --switch-context"
# info "Cluster Name: milkyway"
# info "--merge-default-kubeconfig true: overwrite existing fields with the same name in kubeconfig (true by default)"
# info "--switch-context true: set the kubeconfig's current-context to the new cluster context (false by default)"


info_pause_exec "Use kubectl to checkout the nodes" "kubectl get nodes"

section "Use the Cluster"

info_pause_exec "Build the sample-app" "docker build sample/ -f sample/Dockerfile -t sample-app:local"

info_pause_exec "Load the sample-app image into the cluster" "k3d image import -c milkyway sample-app:local"

info_pause_exec "Create a new 'milkyway' namespace" "kubectl create namespace milkyway"
info_pause_exec "Switch to the new 'milkyway' namespace" "kubens milkyway"
info_pause_exec "Deploy the sample app with helm" "helm upgrade --install sample-app sample/conf/charts/sample-app --namespace milkyway --set app.image=sample-app:local"

info_pause_exec "Access the sample app frontend via ingress" "firefox --new-window http://sample.k3d.localhost:8080 &>/dev/null &"

section "The End"

info_pause_exec "Delete the Cluster" "k3d cluster delete milkyway"
