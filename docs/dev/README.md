# dev notes for positronium

## Requirements

Building and testing requires 
 * Pester
 * PesterMatchArray 
 * PesterMatchHashtable


## Publishing

 * Update version number in `positronium.psd1`
 * Commit changes
 * update changelog in root README.md
 * git tag: `git tag -a v0.0.x -m "version 0.0.x"`
 * push changes and tag
 * Use Publish-Module cmdlet to publish to PowerShell Gallery (`Publish-Module -NuGetApiKey $key -Path .\`)