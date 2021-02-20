#!/bin/sh

set -e

podspec=`find . -type f -iname *.podspec | xargs basename`

set_version() {
    # Geting version from tag
    version=`git describe --abbrev=0 --tags`
    # Change version in podspec
    sed -i '.bak' 's/    s.version       = .*/    s.version       = "'$version'"/' $podspec
}

reset_podspec() {
    # Back to primary
    git checkout $podspec
    rm $podspec.bak
}

if [ "$1" == "lint" ]; then
    set_version
    pod lib lint
    reset_podspec
elif [ "$1" == "push" ]; then
    set_version
    pod trunk push $podspec
    reset_podspec
else
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    NC='\033[0m' # No Color
    echo "${YELLOW}pod-trunk-push.sh script${NC}"
    echo "${GREEN}lint${NC} — run pod lib lint (./pod-trunk-push.sh lint)"
    echo "${GREEN}push${NC} — push pod to cocoapods (./pod-trunk-push.sh push)"
fi
