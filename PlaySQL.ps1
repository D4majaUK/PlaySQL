$Global:SCCMSQLSERVER = "LOCALHOST" 
$Global:DBNAME = "TEST" 
Try 
{ 
$SQLConnection = New-Object System.Data.SQLClient.SQLConnection 
$SQLConnection.ConnectionString ="server=$SCCMSQLSERVER;database=$DBNAME;User ID=SA;Password=myStrongSnickers!&%B4r" 
$SQLConnection.Open() 
write-host "Connected"
} 
catch 
{ 
    write-host "Failed to connect" 
} 


$query = "SELECT * FROM Hello"
$command = $SQLConnection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteReader()

$table = new-object "System.Data.DataTable"
$table.Load($result)
$table | select-object @{Name="ID";Expression={$_.id}}, @{Name="First";Expression={$_.first}}, @{Name="Last";Expression={$_.last}}
$result.Close()

$SQLConnection.Close() 

docker
