# Test with different JSON formats
Write-Host "=== Testing different JSON formats for POST ===" -ForegroundColor Cyan

# Try format 1: Plain string as body
Write-Host "`nTest with plain string (Lilia):"
try {
  $response = Invoke-WebRequest -Uri "http://localhost:8080/flowers/fav/users/Kamil" `
    -Method POST `
    -ContentType "application/json" `
    -Body '"Lilia"' `
    -UseBasicParsing
  Write-Host "Status: $($response.StatusCode) - Response: $($response.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Response.StatusCode.value__)"
}

# Try format 2: Different field name (flower instead of flowerName)
Write-Host "`nTest with flower field:"
try {
  $body = @{"flower" = "Lilia"} | ConvertTo-Json
  $response = Invoke-WebRequest -Uri "http://localhost:8080/flowers/fav/users/Kamil" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body `
    -UseBasicParsing
  Write-Host "Status: $($response.StatusCode) - Response: $($response.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Response.StatusCode.value__)"
}

# Try format 3: name field
Write-Host "`nTest with name field:"
try {
  $body = @{"name" = "Lilia"} | ConvertTo-Json
  $response = Invoke-WebRequest -Uri "http://localhost:8080/flowers/fav/users/Kamil" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body `
    -UseBasicParsing
  Write-Host "Status: $($response.StatusCode) - Response: $($response.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Response.StatusCode.value__)"
}
