@'
# Dataverse Bulk Upload Script
$API_TOKEN = "6332b12e-d809-4001-b09c-a9e1c05f1c94"
$HOSTNAME = "https://demo.borealisdata.ca"
$DATAVERSE_ALIAS = "zeynepcevik"
$DIRECTORY = "\\utl.utoronto.ca\Staff2025\Data\cevikzey\Documents\Datasets"
$WAIT = 0

Write-Host "Starting bulk upload..." -ForegroundColor Green
$datasetDirs = Get-ChildItem -Path $DIRECTORY -Directory

foreach ($datasetDir in $datasetDirs) {
    Write-Host "Processing: $($datasetDir.Name)" -ForegroundColor Cyan
    
    $metadataPath = Join-Path $datasetDir.FullName "metadata.json"
    $filesPath = Join-Path $datasetDir.FullName "files.zip"
    
    if (-not (Test-Path $metadataPath)) {
        Write-Host "  ERROR: metadata.json not found" -ForegroundColor Red
        continue
    }
    
    if (-not (Test-Path $filesPath)) {
        Write-Host "  ERROR: files.zip not found" -ForegroundColor Red
        continue
    }
    
    if ($WAIT -gt 0) { Start-Sleep -Seconds $WAIT }
    
    Write-Host "  Creating dataset..." -ForegroundColor Yellow
    
    try {
        $createUrl = "$HOSTNAME/api/dataverses/$DATAVERSE_ALIAS/datasets/?key=$API_TOKEN"
        $metadata = Get-Content $metadataPath -Raw
        $response = Invoke-RestMethod -Uri $createUrl -Method Post -Body $metadata -ContentType "application/json"
        $DOI = $response.data.persistentId
        
        if ($DOI) {
            Write-Host "  Created: $DOI" -ForegroundColor Green
        } else {
            Write-Host "  ERROR: Failed to create dataset" -ForegroundColor Red
            continue
        }
    }
    catch {
        Write-Host "  ERROR: $($_.Exception.Message)" -ForegroundColor Red
        continue
    }
    
    $filesize = (Get-Item $filesPath).Length / 1KB
    Write-Host "  File size: $([math]::Round($filesize, 2)) KB" -ForegroundColor Yellow
    Write-Host "  Uploading files..." -ForegroundColor Yellow
    
    try {
        $uploadUrl = "$HOSTNAME/dvn/api/data-deposit/v1.1/swordv2/edit-media/study/$DOI"
        $fileBytes = [System.IO.File]::ReadAllBytes($filesPath)
        $base64Auth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${API_TOKEN}:"))
        
        $headers = @{
            "Authorization" = "Basic $base64Auth"
            "Content-Disposition" = "filename=files.zip"
            "Content-Type" = "application/zip"
            "Packaging" = "http://purl.org/net/sword/package/SimpleZip"
        }
        
        $uploadResponse = Invoke-RestMethod -Uri $uploadUrl -Method Post -Body $fileBytes -Headers $headers
        Write-Host "  Upload complete!" -ForegroundColor Green
    }
    catch {
        Write-Host "  Upload ERROR: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Done!" -ForegroundColor Green
'@ | Out-File -FilePath bulkloaddata.ps1 -Encoding UTF8
