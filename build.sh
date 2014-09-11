#!/bin/sh

# Build Script for WordPress Plugins
#
# @author       Johan Steen <artstorm at gmail dot com>
# @uri          http://johansteen.se/

# ------------------------------------------------------------------------------
# Variables and Setup
# ------------------------------------------------------------------------------

# Make the script culture independent (ie, don't give me Swedish month names!)
# $ct                  = [System.Threading.Thread]::CurrentThread
# $ic                  = [System.Globalization.CultureInfo]::InvariantCulture
# $ct.CurrentCulture   = $ic
# $ct.CurrentUICulture = $ic

# Generic
PLUGIN_NAME='WP Humans.txt'
# $VERSION     = '1.0'
# $DATE        = get-date -format "d MMM yyyy"
# $FILES       = @('wp-humans-txt.php', 'readme.txt')
PLUGIN_FILE='wp-humans-txt.php'


# ------------------------------------------------------------------------------
# Build
# Replaces Version and Date in the plugin.
# ------------------------------------------------------------------------------
# function build_plugin
# {
#     Write-Host '--------------------------------------------'
#     Write-Host 'Building plugin...'
#     # cd $LESS_FOLDER

#     # Replace Date and Version
#     foreach ($file in $FILES)
#     {
#         cat $file `
#             | %{$_ -replace "@BUILD_DATE", $DATE} `
#             | %{$_ -replace "@DEV_HEAD", $VERSION} `
#             | Set-Content $file'.tmp'

#         # Set UNIX line endings and UTF-8 encoding.
#         Get-ChildItem $file'.tmp' | ForEach-Object {
#           # get the contents and replace line breaks by U+000A
#           $contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
#           # create UTF-8 encoding without signature
#           $utf8 = New-Object System.Text.UTF8Encoding $false
#           # write the text back
#           [IO.File]::WriteAllText($_, $contents, $utf8)
#         }

#         cp $file'.tmp' $file
#         Remove-Item $file'.tmp'
#     }
#     Write-Host "Plugin successfully built! - $DATE"
# }


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

}

# function bump($newVersion)
# {
#     # For now, I keep the master branch readme pointing to develop...
#     # So I don't forget to change it back after a release. Revise if I come up
#     # with a better method to handle this during a release.
#     # findReplaceFile 'README.md' "\?branch=develop" "?branch=master"
#     # bumpMessage "README.md: Changed Travis CI badge from develop to master branch"
#     git add .
#     git commit -m "Bumps version number."

#     bumpMessage "pot file: Updating..."
#     xgettext -o lang/wp-humans-txt.pot -L php --keyword=_e --keyword=__  `
#     *.php views/*.php lib/WPHumansTxt/*.php

#     Write-Host "Done!"
#     Write-Host $('-' * 80)

#     Write-Host "Changes since v$oldVersion"
#     git log $oldVersion`..HEAD --oneline
#     Write-Host $('-' * 80)
# }

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
# SVN
# Push a new release to the WordPress Repository
# ------------------------------------------------------------------------------
# function svn
# {
#     $version = findVersionNumber

#     Write-Host "Version to build: $version"
#     # Checkout SVN repo
#     Write-Host "Checking out tags folder..."
#     svn.exe co --depth empty http://plugins.svn.wordpress.org/wp-humanstxt/tags/ build/tags

#     # Create new tag
#     Write-Host "Building new tag..."
#     mkdir build/tags/$version

#     # Copy files
#     cp wp-humans-txt.php build/tags/$version/
#     cp readme.txt build/tags/$version/

#     cp assets/ -Destination build/tags/$version/assets/ -Recurse
#     cp lang/   -Destination build/tags/$version/lang/   -Recurse
#     cp lib/    -Destination build/tags/$version/lib/    -Recurse
#     cp views/  -Destination build/tags/$version/views/  -Recurse

#     # # Add and commit
#     svn.exe add build/tags/$version
#     cd build/tags
#     svn.exe ci -m "Tagged version $version"

#     if (!$LastExitCode -eq 0) {
#         Write-Host "Error! Could not commit the new tag. Exiting." -foregroundcolor "Red"
#         Exit
#     }

#     # Cleanup
#     cd ../..
#     Remove-Item build -Recurse -Force

#     # Git tag the new version, and push master to the repo.
#     git tag -a $version -m "Tagged version $version"
#     git push origin master --tags

#     Write-Host "All done!"
# }

# ------------------------------------------------------------------------------
# Assets
# Update the assets in the WordPress Repository
# ------------------------------------------------------------------------------
# function assets
# {
#     Write-Host "Checking out assets folder..."
#     svn.exe co http://plugins.svn.wordpress.org/wp-humanstxt/assets/ build
#     if (!$LastExitCode -eq 0) {
#         Write-Host "Error! Could not checkout the assets. Exiting." -foregroundcolor "Red"
#         Exit
#     }

#     Write-Host "Updating screenshots..."
#     Remove-Item build/*.*
#     Copy-Item repo/screenshot-*.* build/
#     Copy-Item repo/banner-*.jpg* build/

#     Write-Host "Commiting the assets folder..."
#     svn.exe add --force build/*.jpg
#     cd build
#     svn.exe ci -m "Updates repository assets."
#     if (!$LastExitCode -eq 0) {
#         Write-Host "Error! Could not commit the assets. Exiting." -foregroundcolor "Red"
#         Exit
#     }

#     cd ..
#     Remove-Item build -Recurse -Force
#     Write-Host "All done!"
# }


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
    echo 'svn      Push a new release to the WordPress repository.'
    echo 'assets   Updates the assets in the WordPress repository.'
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

case $1 in

    bump)
        view 'header'

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

    svn)
        echo 'ok'
    ;;

    assets)
        view 'header'
        assets
    ;;

    *)
        echo 'no'
        view 'header'
        view 'arguments'
    ;;

esac

# switch ($args[0])
# {
#     "svn" {
#         header

#         # Check branch
#         $gitStatus = Get-GitStatus('.')
#         if (!$gitStatus.Branch.StartsWith('master')) {
#             Write-Host "Only publish releases from the master branch..." `
#                 -foregroundcolor "Red"
#             Exit
#         }
#         svn
#     }

