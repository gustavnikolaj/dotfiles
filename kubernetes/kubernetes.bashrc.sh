if ! command -v kubectl &> /dev/null
then
    return
fi


source <(kubectl completion bash)

kubectl-get-context() {
    local context=$(kubectl config current-context)

    if [ "$context" == "" ] ; then
        return 1
    fi

    local namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}')
    local cluster=$(kubectl config view --minify --output 'jsonpath={..cluster}' | sed 's/ *{.*} *//')

    echo CONTEXT=$context
    echo NAMESPACE=$namespace
    echo CLUSTER=$cluster
}

alias kubectl-set-context="kubectl config use-context \"\$(kubectl config get-contexts --no-headers -o name | fzf)\""
# alias kubectl-get-context="kubectl config current-context"


# https://jackma.com/2019/11/23/one-kubectl-context-per-shell-session/

export KUBECONFIG="${HOME}/.kube/config"

# kubeconfig per session
file="$(mktemp -t "kubectx.XXXXXX")"
export KUBECONFIG="${file}:${KUBECONFIG}"
cat <<EOF >"${file}"
apiVersion: v1
kind: Config
current-context: ""
EOF

kubectl-global-config() {
    export KUBECONFIG="${HOME}/.kube/config"
}
