# Test 1: POST to set favorite flower to Lilia
Write-Host "=== Test 1: POST /flowers/fav/users/Kamil - Set favorite to Lilia ===" -ForegroundColor Cyan
$body1 = @{"flowerName" = "Lilia"} | ConvertTo-Json
try {
  $response1 = Invoke-WebRequest -Uri "http://localhost:8080/flowers/fav/users/Kamil" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body1 `
    -UseBasicParsing
  Write-Host "Status: $($response1.StatusCode)"
  Write-Host "Response: $($response1.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Message)"
}
Write-Host ""

# Test 2: GET to verify favorite flower
Write-Host "=== Test 2: GET /flowers/fav/users/Kamil - Verify favorite ===" -ForegroundColor Cyan
try {
  $response2 = Invoke-WebRequest -Uri "http://localhost:8080/flowers/fav/users/Kamil" `
    -Method GET `
    -UseBasicParsing
  Write-Host "Status: $($response2.StatusCode)"
  Write-Host "Response: $($response2.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Message)"
}
Write-Host ""

# Test 3: POST to add Róża to garden
Write-Host "=== Test 3: POST /flowers/garden/users/Kamil - Add Róża to garden ===" -ForegroundColor Cyan
$body3 = @{"flowerName" = "Róża"} | ConvertTo-Json
try {
  $response3 = Invoke-WebRequest -Uri "http://localhost:8080/flowers/garden/users/Kamil" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body3 `
    -UseBasicParsing
  Write-Host "Status: $($response3.StatusCode)"
  Write-Host "Response: $($response3.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Message)"
}
Write-Host ""

# Test 4: GET to verify garden
Write-Host "=== Test 4: GET /flowers/garden/users/Kamil - Verify garden ===" -ForegroundColor Cyan
try {
  $response4 = Invoke-WebRequest -Uri "http://localhost:8080/flowers/garden/users/Kamil" `
    -Method GET `
    -UseBasicParsing
  Write-Host "Status: $($response4.StatusCode)"
  Write-Host "Response: $($response4.Content)"
} catch {
  Write-Host "Error: $($_.Exception.Message)"
}
