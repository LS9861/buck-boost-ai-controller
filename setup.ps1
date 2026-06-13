# setup.ps1 - Run this once after creating the folder structure
Write-Host "🚀 Setting up Buck-Boost AI Controller project..." -ForegroundColor Green

# Create Python virtual environment
Write-Host "📦 Creating Python virtual environment..." -ForegroundColor Yellow
python -m venv venv

# Activate and install dependencies
Write-Host "📥 Installing Python dependencies..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1
pip install -r simulation\python\requirements.txt

# Create .env from template if not exists
if (-not (Test-Path ".env")) {
    Write-Host "🔑 Creating .env file. Please add your API key!" -ForegroundColor Yellow
    Copy-Item ".env.example" ".env" -ErrorAction SilentlyContinue
}

Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Edit .env file and add your DeepSeek API key"
Write-Host "2. Open MATLAB and run simulation/matlab/scripts/characterize_converter.m"
Write-Host "3. Run python simulation/python/deepseek_tuning.py to test API"