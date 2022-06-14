    $chrome_version = (Invoke-WebRequest https://chromedriver.storage.googleapis.com/LATEST_RELEASE).Content
    $chrome_driver_url = "https://chromedriver.storage.googleapis.com/" + $chrome_version + "/chromedriver_win32.zip"
    $download_path = "C:\Users\" + $env:UserName + "\Downloads"
    $output_file_path = $download_path + "\chromedriver_win32.zip"
    $TempFileUnzipPath = $output_file_path.Replace(".zip", "")

    Invoke-WebRequest -Uri $chrome_driver_url -OutFile $output_file_path
    Expand-Archive $output_file_path -DestinationPath $TempFileUnzipPath -Force
    Write-Output $TempFileUnzipPath

    [Environment]::SetEnvironmentVariable("Path", $env:Path + ";" + $TempFileUnzipPath, "Machine")