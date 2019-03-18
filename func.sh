#!/bin/bash

function get_changelog_header {
    local file=$1
    if [ ! -f ${file} ]; then
        echo "$file is not existed" >&2
        exit 1
    fi

    local result=`head -1 ${file}`
    echo ${result}
}

function get_version_from_changelog {
    local header=$(get_changelog_header $1)
    local version
    version=`echo ${header} | awk -F '[()]' '{print $2}'`
    echo ${version}
}

function get_next_version {
    local version=$(get_version_from_changelog $1)
    IFS='.' read -r major minor build <<< "${version}"
    new_version=${major}.${minor}.$((build+1))
    echo ${new_version}
}

function change_version_in_changelog {
    local version=$(get_version_from_changelog $1)
    local next_version=$(get_next_version $1)
    local header=$(get_changelog_header $1)
    touch tmp.txt
    echo ${header} > tmp.txt
    sed -i -e 's/'$version'/'$next_version'/g' tmp.txt
    local new_header=$(get_changelog_header tmp.txt)
    echo ${new_header}
}

echo $(get_changelog_header $1)
echo $(get_version_from_changelog $1)
echo $(get_next_version $1)
echo $(change_version_in_changelog $1)


