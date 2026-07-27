# deploy.ps1
# Script para hacer build local y desplegar a GitHub para activar Cloudflare Pages

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "    🚀 Despliegue de Landing Page Premium    " -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# 1. Build local (Verificación)
Write-Host "`n[1/3] Ejecutando validación de Build Local..." -ForegroundColor Yellow
npm.cmd run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error en el build. Despliegue cancelado." -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "✅ Build exitoso. El código es estable." -ForegroundColor Green

# 2. Agregar cambios a Git
Write-Host "`n[2/3] Agregando archivos a Git..." -ForegroundColor Yellow
git add .

$status = (git status --porcelain)
if ([string]::IsNullOrWhiteSpace($status)) {
    Write-Host "⚠️ No hay cambios para desplegar." -ForegroundColor Yellow
    exit 0
}

# 3. Commit y Push
$commitMessage = "deploy: actualización automática $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "`n[3/3] Haciendo Commit y Push a Main..." -ForegroundColor Yellow
git commit -m $commitMessage
git push origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error al hacer Push al repositorio." -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host "`n🎉 ¡Despliegue completado con éxito! Cloudflare Pages comenzará a publicar los cambios en unos segundos." -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
