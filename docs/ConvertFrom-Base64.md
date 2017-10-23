# ConvertTo-Base64

Convert a string from Base64


## Parameters

|Name|Description|
|-|-|
|Value|The value to decode|
|Encoding|The encoding to use - defaults to `[System.Text.Encoding]::UTF8`|

## Example

```powershell
> ConvertFrom-Base64 "dGVzdA=="
test
```