#!/usr/bin/env bash

if [[ -z $GHAPI_KEY ]]; then
    echo "Need a GitHub API Token for this to work"
else
    username=$(curl -s -L \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${GHAPI_KEY}" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        https://api.github.com/user | jq -r '.login')
fi

if [[ -d ~/Repos ]]; then 
    pushd ~/Repos
    mkdir ${username}
    pushd ${username}

    for i in $(curl -s -L \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer ${GHAPI_KEY}" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/user/repos \
      | jq -c '.[] | [ .name, .ssh_url ]'); do

        repo=$(echo "${i}" | jq -r '.[0]')
        if [[ -d ${repo} ]]; then
            echo "${repo} already cloned"
            pushd ${repo}
            git status
            popd
        else
            echo "cloning ${repo}"
            git clone $(echo "${i}" | jq -r '.[1]')
        fi

    done
fi
