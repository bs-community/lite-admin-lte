if (!(Test-Path ./dart-sass)) {
    Invoke-WebRequest 'https://github.com/sass/dart-sass/releases/download/1.26.5/dart-sass-1.26.5-linux-x64.tar.gz' -OutFile ./sass.tar.gz
    tar -zxf ./sass.tar.gz
}

npm i
./dart-sass/sass -q ./admin-lte.scss | npx postcss -o dist/admin-lte.min.css

if (Test-Path ./dist/admin-lte.min.js) {
    Remove-Item ./dist/admin-lte.min.js
}
New-Item -Path ./dist/admin-lte.min.js -ItemType File
Get-Content ./node_modules/jquery/dist/jquery.min.js | Add-Content ./dist/admin-lte.min.js
Get-Content ./node_modules/bootstrap/dist/js/bootstrap.bundle.min.js | Add-Content ./dist/admin-lte.min.js
$adminLTE = Get-Content ./node_modules/admin-lte/dist/js/adminlte.min.js
$adminLTE = $adminLTE.Replace('//# sourceMappingURL=adminlte.min.js.map', '')
Add-Content -Path ./dist/admin-lte.min.js -Value $adminLTE
