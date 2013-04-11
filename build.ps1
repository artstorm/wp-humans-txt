# Build Script for WordPress Plugins
#
# @author       Johan Steen <artstorm at gmail dot com>
# @uri          http://johansteen.se/
# @date         4 Apr 2013

# ------------------------------------------------------------------------------
# Variables and Setup
# ------------------------------------------------------------------------------

# Make the script culture independent (ie, don't give me Swedish month names!)
$ct                  = [System.Threading.Thread]::CurrentThread
$ic                  = [System.Globalization.CultureInfo]::InvariantCulture
$ct.CurrentCulture   = $ic
$ct.CurrentUICulture = $ic

# Generic
$PLUGIN_NAME = 'WP humans.txt'
$VERSION     = '1.0'
$DATE        = get-date -format "d MMM yyyy"
$FILES       = @('wp-humans-txt.php', 'readme.txt')
$PLUGIN_FILE = 'wp-humans-txt.php'

# ------------------------------------------------------------------------------
# Build
# Replaces Version and Date in the plugin. 
# ------------------------------------------------------------------------------
function build_plugin
{
    Write-Host '--------------------------------------------'
    Write-Host 'Building plugin...'
    # cd $LESS_FOLDER

    # Replace Date and Version
    foreach ($file in $FILES)
    {
        cat $file `
            | %{$_ -replace "@BUILD_DATE", $DATE} `
            | %{$_ -replace "@DEV_HEAD", $VERSION} `
            | Set-Content $file'.tmp' 

        # Set UNIX line endings and UTF-8 encoding.
        Get-ChildItem $file'.tmp' | ForEach-Object {
          # get the contents and replace line breaks by U+000A
          $contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
          # create UTF-8 encoding without signature
          $utf8 = New-Object System.Text.UTF8Encoding $false
          # write the text back
          [IO.File]::WriteAllText($_, $contents, $utf8)
        }

        cp $file'.tmp' $file
        Remove-Item $file'.tmp'
    }
    Write-Host "Plugin successfully built! - $DATE"
}

# ------------------------------------------------------------------------------
# Bump
# Prepares strings for a new release. 
# ------------------------------------------------------------------------------
function bump($newVersion)
{
    $oldVersion = findVersionNumber

    Write-Host $('-' * 80)
    Write-Host "BUMP" -foregroundcolor "White"
    Write-Host "Bumping $oldVersion to $newVersion" -noNewLine
    # Let's have some dots printed out. Makes it old skool
    for ($ctr = 0; $ctr -lt 3; $ctr++) {
        Write-Host "." -noNewLine
        sleep -Milliseconds 500
    }
    Write-Host "."

    findReplaceFile $PLUGIN_FILE "Version: $oldVersion" "Version: $newVersion"
    bumpMessage $PLUGIN_FILE": bumped Version $oldVersion to $newVersion"
    findReplaceFile 'readme.txt' "Stable tag: $oldVersion" "Stable tag: $newVersion"
    bumpMessage "readme.txt: bumped Stable Tag $oldVersion to $newVersion"
    # For now, I keep the master branch readme pointing to develop...
    # So I don't forget to change it back after a release. Revise if I come up
    # with a better method to handle this during a release.
    # findReplaceFile 'README.md' "\?branch=develop" "?branch=master"
    # bumpMessage "README.md: Changed Travis CI badge from develop to master branch"

    Write-Host "Done!"
    Write-Host $('-' * 80)
}

function findReplaceFile($file, $old, $new)
{
    cat $file `
        | %{$_ -replace $old, $new} `
        | Set-Content "$($file).tmp"

    correctEncoding("$($file).tmp")

    # Copy and clean up
    cp "$($file).tmp" $file
    Remove-Item "$($file).tmp"
}

function bumpMessage($message)
{
    Write-Host "- $message" -foregroundcolor "DarkGray"
    sleep -Milliseconds 500
}

function correctEncoding($file)
{
    # Set UNIX line endings and UTF-8 encoding.
    Get-ChildItem $file | ForEach-Object {
        # get the contents and replace line breaks by U+000A
        $contents = [IO.File]::ReadAllText($_) -replace "`r`n?", "`n"
        # create UTF-8 encoding without signature
        $utf8 = New-Object System.Text.UTF8Encoding $false
        # write the text back
        [IO.File]::WriteAllText($_, $contents, $utf8)
    }
}

function findVersionNumber
{
    # The file comes in as an array (one line per key)
    $plugin = cat $PLUGIN_FILE
    # Convert it to string, with new lines added
    $plugin = [string]::Join("`n", ($plugin))

    # Search the plugin for the current version number
    $regex = [regex]"(?<=Version:)[^`n]*"
    $version =  $regex.Match($plugin).Value

    # Trim away white space, and convert from string to decimal
    $version = [decimal] $version.trim()

    return $version
}

# ------------------------------------------------------------------------------
# SVN
# Push a new release to the WordPress Repository
# ------------------------------------------------------------------------------
function svn
{
    $version = findVersionNumber

    Write-Host "Version to build: $version"
    # Checkout SVN repo
    svn.exe co http://plugins.svn.wordpress.org/wp-humanstxt/tags/ build/tags

    # Create new tag
    mkdir build/tags/$version

    # Copy files
    cp wp-humans-txt.php build/tags/$version/
    cp readme.txt build/tags/$version/

    cp assets/ -Destination build/tags/$version/assets/ -Recurse
    cp lang/   -Destination build/tags/$version/lang/   -Recurse
    cp lib/    -Destination build/tags/$version/lib/    -Recurse
    cp views/  -Destination build/tags/$version/views/  -Recurse

    # # Add and commit
    svn.exe add build/tags/$version

    cd build/tags
    svn.exe ci -m "Tagged version $version"

    # # Cleanup
    cd ../..
    rm build -Recurse

    # Git tag it
    git tag -a $version -m "Tagged version $version"

    echo "All done! Remember to update stable tag in SVN repo"
}

# ------------------------------------------------------------------------------
# Console Output
# ------------------------------------------------------------------------------
function header
{
    Write-Host $('-' * 80)
    Write-Host $PLUGIN_NAME -foregroundcolor "White"
    Write-Host "Version: $(findVersionNumber)"
    Write-Host $('-' * 80)
}

function checklist
{
    Write-Host "CHECKLIST"  -foregroundcolor "Red"
    Write-Host "Before tagging the new release"
    Write-Host "* Update .pot file." -foregroundcolor "White"
    Write-Host "* Update changelog." -foregroundcolor "White"
    Write-Host "* Run unit tests." -foregroundcolor "White"
    Write-Host $('-' * 80)
}

function arguments
{
    Write-Host "ARGUMENTS"  -foregroundcolor "White"
    Write-Host "bump     Bumps the version number of the plugin."
    Write-Host "svn      Push a new release to the WordPress repository."
    Write-Host $('-' * 80)
}

# ------------------------------------------------------------------------------
# Check Environment
# ------------------------------------------------------------------------------

<##
 # Checks if a function or cmdlet exists.
 # If the command does not exist, display an error message and exit.
 #
 # @param  $cmdName  function or cmdlet to check.
 # @param  $solMess  Solution message to display.
 # @return void
 #>
function commandExists($cmdName, $solMess)
{
    if (!(Get-Command $cmdName -errorAction SilentlyContinue))
    {
        "Error: $cmdName does not exists!"
        "Solution: $errMess"
        Exit
    } 
}

## Start checking the environment
commandExists 'Get-GitStatus' 'Get posh-git for PowerShell.'

# ------------------------------------------------------------------------------
# Handle Arguments
# ------------------------------------------------------------------------------

switch ($args[0])
{
    "bump" {
        header

        # Check branch
        $gitStatus = Get-GitStatus('.')
        if (!$gitStatus.Branch.StartsWith('release'))
        {
            Write-Host "Only bump in release branches..." -foregroundcolor "Red"
            Exit
        }

        # Set new version number
        $newVersion = Read-Host 'New version number'
        if ($newVersion -eq '') {
            Write-Host "Exited..." -foregroundcolor "Red"
            break
        }

        # And do the bumps
        bump($newVersion)

        # Let's display some reminders
        checklist
        break
    }

    "svn" {
        header

        # Check branch
        $gitStatus = Get-GitStatus('.')
        if (!$gitStatus.Branch.StartsWith('master')) {
            Write-Host "Only publish releases from the master branch..." `
                -foregroundcolor "Red"
            Exit
        }
        svn
    }

    default {
        header
        arguments
    }
}
