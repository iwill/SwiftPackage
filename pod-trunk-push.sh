#!/bin/sh

set -e

podspec=`find . -type f -iname *.podspec | xargs basename`
echo "podspec: $podspec"

set_version() {
    echo set_version1
    # Geting version from tag
    version=`git describe --abbrev=0 --tags`
    echo set_version2
    # Change version in podspec
    sed -i '.bak' 's/    s.version       = .*/    s.version       = "'$version'"/' $podspec
    echo set_version3
}

reset_podspec() {
    # Back to primary
    echo reset_podspec1
    git checkout $podspec
    echo reset_podspec2
    rm $podspec.bak
    echo reset_podspec3
}

if [ "$1" == "lint" ]; then
    set_version
    pod lib lint
    reset_podspec
elif [ "$1" == "push" ]; then
    echo push1
    set_version
    echo push2
    pod trunk push $podspec
    echo push3
    reset_podspec
    echo push4
else
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    NC='\033[0m' # No Color
    echo "${YELLOW}pod-trunk-push.sh script${NC}"
    echo "${GREEN}lint${NC} — run pod lib lint (./pod-trunk-push.sh lint)"
    echo "${GREEN}push${NC} — push pod to cocoapods (./pod-trunk-push.sh push)"
fi
