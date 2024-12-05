# TODO: Replace with the raw contents, saves 50ms.
if command -v kubectl &> /dev/null
then
    source <(kubectl completion bash)
fi
