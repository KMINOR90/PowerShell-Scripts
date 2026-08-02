# Replace with your list of known server names or use AD computer search
$servers = Get-ADComputer -Filter {OperatingSystem -like "*Server*"} | Select-Object -ExpandProperty Name

foreach ($server in $servers) {
    try {
        $services = Get-WmiObject -ComputerName $server -Query "SELECT * FROM Win32_Service WHERE Name LIKE 'MSSQL%'" -ErrorAction Stop
        foreach ($svc in $services) {
            Write-Host "SQL Server service found on $server: $($svc.Name)"
        }
    } catch {
        Write-Host "Could not connect to $server"
    }
}




# Load the SQL Server module (SQLPS or SqlServer)
Import-Module SqlServer

# Define your SQL Server instances based on the output from the first script
$serverInstances = @("LaserMarker", "KohYoung SPI", "KohYoung AOI", "ASM SPI", "ASM PnP") # Replace with actual server names

foreach ($serverInstance in $serverInstances) {
    try {
        # Get list of databases
        $databases = Invoke-Sqlcmd -ServerInstance $serverInstance -Query "SELECT name, create_date, state_desc FROM sys.databases"
        
        # Export to CSV
        $databases | Export-Csv -Path "C:\Users\Public\SQL_Databases_Report_$serverInstance.csv" -NoTypeInformation
        
        Write-Host "Database list exported for $serverInstance."
    } catch {
        Write-Host "Could not connect to $serverInstance"
    }
}
