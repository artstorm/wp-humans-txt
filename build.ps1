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

function bump($newVersion)
{
    $oldVersion = findVersionNumber

    Write-Host $('-' * 80)
    Write-Host "BUMP" -foregroundcolor "White"
    Write-Host "Bumping $oldVersion to $newVersion" -noNewLine
    # Let's have some dots printed out. Makes it old skool
    for ($ctr = 0; $ctr -lt 3; $ctr++) {
        Write-Host "." -noNewLine
        sleep(1)
    }


    cat $PLUGIN_FILE `
        | %{$_ -replace "Version: $oldVersion", "Version: $newVersion"} `
        | Set-Content "$($PLUGIN_FILE).tmp"

    correctEncoding("$($PLUGIN_FILE).tmp")

    # Copy and clean up
    cp "$($PLUGIN_FILE).tmp" $PLUGIN_FILE
    Remove-Item "$($PLUGIN_FILE).tmp"

    Write-Host "Done!"
    Write-Host $('-' * 80)
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
    Write-Host $('-' * 80)
}


# ------------------------------------------------------------------------------
# Handle Arguments
# ------------------------------------------------------------------------------
switch ($args[0])
{
    "bump" {
        header
        $newVersion = Read-Host 'New version number'
        if ($newVersion -eq '') {
            Write-Host "Exited..." -foregroundcolor "Red"
            break
        }
        bump($newVersion)
        checklist
        break
    }

    default {
        header
        arguments
    }
}
