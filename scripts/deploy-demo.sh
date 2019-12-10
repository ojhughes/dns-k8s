#!/usr/bin/env bash
set -euo pipefail
readonly PROG_DIR=$(readlink -m $(dirname $0))
readonly ROOT_DIR=$(dirname "${PROG_DIR}")

deploy_demo() {
    local -r namespace=dns-demo
    cd "${ROOT_DIR}"
    kubectl create namespace ${namespace}
    kapp deploy -n ${namespace} -a $(yq r ${ROOT_DIR}/skaffold.yaml metadata.name) -f <(skaffold render)
}

validate(){
	[[ $(type kapp) ]] || (echo "kapp tool not installed" >&2 ; kapp_usage ; exit 2)
	[[ $(type skaffold) ]] || (echo "skaffold tool not installed" >&2 ; skaffold_usage ; exit 2)
	[[ $(kubectl version --short) ]] || (echo "kubernetes context not configured" >&2 ; exit 2)
}

kapp_usage() {
    cat <<- EOF
Install kapp command line tool :
    Mac: see https://github.com/k14s/homebrew-tap
    Windows / Linux: see https://k14s.io/
EOF
}

skaffold_usage() {
    cat <<- EOF
Install skaffold command line tool :
    https://skaffold.dev/docs/install/
EOF
}

validate
deploy_demo
