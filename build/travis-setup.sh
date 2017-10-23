if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then 
    brew update
    brew tap caskroom/cask      
    brew cask install powershell
    powershell -Command "Write-Host 'Hello from powershell'"
fi
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then 
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -  
    curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list          
    sudo apt-get update          
    sudo apt-get install -y powershell          
    powershell -Command "Write-Host 'Hello from powershell'"
fi;