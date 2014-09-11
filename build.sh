#!/bin/sh

# Build Script for WordPress Plugins
#
# @author       Johan Steen <artstorm at gmail dot com>
# @uri          http://johansteen.se/

# ------------------------------------------------------------------------------
# Variables and Setup
# ------------------------------------------------------------------------------

PLUGIN_NAME='WP Humans.txt'
PLUGIN_FILE='wp-humans-txt.php'


# ------------------------------------------------------------------------------
# Bump
# Prepares strings for a new release.
# ------------------------------------------------------------------------------

bump()
{
    newVersion=$1
    oldVersion=$(findVersionNumber)

    echo $hr
    echo 'BUMP'
    echo "Bumping $oldVersion to $newVersion"

    # Let's have some dots printed out. Makes it old skool
    for i in `seq 1 3`;
    do
        printf .
        sleep 0.5
    done
    echo .

    sed -i.bak "s/Version: $oldVersion/Version: $newVersion/g" $PLUGIN_FILE
    bumpMessage "$PLUGIN_FILE: bumped version $oldVersion to $newVersion"

    sed -i.bak "s/Stable tag: $oldVersion/Stable tag: $newVersion/g" readme.txt
    bumpMessage "readme.txt: bumped version $oldVersion to $newVersion"

    rm *.*.bak

    git add .
    git commit -m "Bumps version number."

    echo "Done!"
    echo $hr

    echo "Changes since v$oldVersion"
    git log $oldVersion..HEAD --oneline
    echo $hr
}

bumpMessage()
{
    message=$1
    echo '- '$message
    sleep 0.25
}

findVersionNumber()
{
    # Get the line with the version number
    version=$(grep -Eow "^Version:.*$" $PLUGIN_FILE)
    # Remove everything up to the colon and the space
    version=${version#*: }

    echo $version
}


# ------------------------------------------------------------------------------
# Publish
# Push a new release to the WordPress Repository
# ------------------------------------------------------------------------------

publish()
{
    version=$(findVersionNumber)

    echo "Version to build: $version"
    # Checkout SVN repo
    echo "Checking out tags folder..."
    svn co --depth empty http://plugins.svn.wordpress.org/wp-humanstxt/tags/ build/tags

    # Create new tag
    echo "Building new tag..."
    mkdir build/tags/$version

    # Copy files
    cp wp-humans-txt.php build/tags/$version/
    cp readme.txt build/tags/$version/

    cp -r assets build/tags/$version/
    cp -r lang build/tags/$version/
    cp -r src build/tags/$version/
    cp -r views build/tags/$version/

    # Add and commit
    svn add build/tags/$version
    cd build/tags
    svn ci -m "Tagged version $version"

    if [ $? -ne 0 ]; then
        echo "Error! Could not commit the new tag. Exiting."
        exit
    fi

    # Cleanup
    cd ../..
    rm -rf build

    # Git tag the new version, and push master to the repo.
    git tag -a $version -m "Tagged version $version"
    git push origin master --tags

    echo "All done!"
}

# ------------------------------------------------------------------------------
# Assets
# Update the assets in the WordPress Repository
# ------------------------------------------------------------------------------

assets()
{
    echo "Checking out assets folder..."
    svn co http://plugins.svn.wordpress.org/wp-humanstxt/assets/ build
    if [ $? -ne 0 ]; then
        echo "Error! Could not checkout the assets. Exiting."
        exit
    fi

    echo "Updating assets..."
    rm build/*.*
    cp repo/screenshot-*.* build/
    cp repo/banner-*.*g build/
    cp repo/icon-*.*g build/

    echo "Commiting the assets folder..."
    svn add --force build/*.jpg
    cd build
    svn ci -m "Updates repository assets."
    if [ $? -ne 0 ]; then
        echo "Error! Could not commit the assets. Exiting."
        exit
    fi

    cd ..
    rm -rf build
    echo "All done!"
}


# ------------------------------------------------------------------------------
# Translation files
# ------------------------------------------------------------------------------

trans()
{
    # Generate pot file
    xgettext \
    -o lang/wp-humans-txt.pot \
    -L php --keyword=_e --keyword=__ --keyword=_n \
    *.php views/*.php src/WPHumansTxt/*.php

    # Update po files with potential new changes from the pot file
    msgmerge --update lang/wp-humans-txt-sv_SE.po lang/wp-humans-txt.pot

    # Compile .mo files
    msgfmt -cv -o lang/wp-humans-txt-sv_SE.mo lang/wp-humans-txt-sv_SE.po

    # Cleanup temporary file
    if [ -f lang/wp-humans-txt-sv_SE.po~ ]; then
        rm lang/wp-humans-txt-sv_SE.po~
    fi
}


# ------------------------------------------------------------------------------
# Console Output
# ------------------------------------------------------------------------------

hr=$(printf '=%.0s' {1..80})

view()
{
    $1
}

header()
{
    echo $hr
    echo $PLUGIN_NAME
    echo 'Version: '$(findVersionNumber)
    echo $hr
}

checklist()
{
    echo 'CHECKLIST'
    echo 'Before tagging the new release'
    echo '* Update changelog.'
    echo '* Run unit tests.'
    echo $hr
}

arguments()
{
    echo 'ARGUMENTS'
    echo 'bump     Bumps the version number of the plugin.'
    echo 'publish  Push a new release to the WordPress repository.'
    echo 'assets   Updates the assets in the WordPress repository.'
    echo 'trans    Updates translation files.'
    echo $hr
}


# ------------------------------------------------------------------------------
# Check Environment
# ------------------------------------------------------------------------------

gitBranch()
{
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="(unnamed branch)"     # detached HEAD

    branch_name=${branch_name##refs/heads/}

    echo $branch_name
}


# ------------------------------------------------------------------------------
# Handle Arguments
# ------------------------------------------------------------------------------

view 'header'

case $1 in

    bump)
        # Check branch
        if [ $(gitBranch) != 'master' ]; then
            echo 'Only bump in release branches...'
            exit
        fi

        # Set new version number
        echo 'New version number: '
        read version
        if [ -z $version ]; then
            echo 'Exited...'
            exit
        fi

        # And do the bumps
        bump $version

        # Let's display some reminders
        view 'checklist'
    ;;

    publish)
        # Check branch
        if [ $(gitBranch) != 'master' ]; then
            echo 'Only publish releases from the master branch...'
            exit
        fi

        publish
    ;;

    assets)
        assets
    ;;

    trans)
        trans
    ;;

    *)
        view 'arguments'
    ;;

esac
