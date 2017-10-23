# ConvertTo-Base64

Convert a string to Base64


## Parameters

|Name|Description|
|-|-|
|Value|The value to encode|
|Encoding|The encoding to use - defaults to `[System.Text.Encoding]::UTF8`|

## Example

```powershell
> ConvertTo-Base64 "test"
dGVzdA==
```