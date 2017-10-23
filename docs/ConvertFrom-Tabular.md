# ConvertFrom-Tabular

Convert tabular output from CLIs to PowerShell objects.


Column headers are turned into property names for objects that are streamed on the PowerShell pipeline.

## Parameters

|Name|Description|
|-|-|
|input|The output from the CLI to parse|

## Example

Suppose you had the following output from `docker images`:

```
REPOSITORY                                             TAG                    IMAGE ID            CREATED             SIZE
microsoft/powershell                                   latest                 b47c44138f7c        2 weeks ago         381MB
acs-engine                                             latest                 68545367d656        7 weeks ago         3.17GB
microsoft/dotnet                                       2.0.0-runtime-jessie   62eaf678c267        2 months ago        233MB
microsoft/dotnet                                       2.0.0-runtime          83c5700eb926        2 months ago        219MB
microsoft/dotnet                                       1.1.2-runtime          5cb21e06fdda        3 months ago        251MB
elasticsearch                                          2.4.4                  2232dfa6321a        5 months ago        345MB
```

Then `docker images | ConvertFrom-Tabular | Format-Table` would give:

```
Repository                                           ImageId      Created       Tag                  Size  
----------                                           -------      -------       ---                  ----  
microsoft/powershell                                 b47c44138f7c 2 weeks ago   latest               381MB 
acs-engine                                           68545367d656 7 weeks ago   latest               3.17GB
microsoft/dotnet                                     62eaf678c267 2 months ago  2.0.0-runtime-jessie 233MB 
microsoft/dotnet                                     83c5700eb926 2 months ago  2.0.0-runtime        219MB 
microsoft/dotnet                                     5cb21e06fdda 3 months ago  1.1.2-runtime        251MB 
elasticsearch                                        2232dfa6321a 5 months ago  2.4.4                345MB 
```

Now you can easily sort the results or apply any other filtering/projection that you're used to in PowerShell. `docker images | ConvertFrom-Tabular | Sort-Object -Property Repository | ft`:

```
Repository                                           ImageId      Created       Tag                  Size  
----------                                           -------      -------       ---                  ----  
acs-engine                                           68545367d656 7 weeks ago   latest               3.17GB
elasticsearch                                        2232dfa6321a 5 months ago  2.4.4                345MB 
microsoft/dotnet                                     83c5700eb926 2 months ago  2.0.0-runtime        219MB 
microsoft/dotnet                                     62eaf678c267 2 months ago  2.0.0-runtime-jessie 233MB 
microsoft/dotnet                                     5cb21e06fdda 3 months ago  1.1.2-runtime        251MB 
microsoft/powershell                                 b47c44138f7c 2 weeks ago   latest               381MB 
```
