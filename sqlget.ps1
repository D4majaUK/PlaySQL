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
    [System.Windows.Forms.MessageBox]::Show("Failed to connect SQL Server:")  
} 

$query = "DROP TABLE Hello"
$command = $SQLConnection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteNonQuery()
 
$query = "CREATE TABLE Hello(ID int, First varchar(50), Last varchar(50))"
$command = $SQLConnection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteNonQuery()
 
$command = $SQLConnection.CreateCommand()
$SQLInsert = "INSERT INTO Hello(id, first, last) VALUES (1, 'John', 'Doe');" 
$SQLInsert = $SQLInsert + "INSERT INTO Hello(id, first, last) VALUES (2, 'Jane', 'Doe');" 
$SQLInsert = $SQLInsert + "INSERT INTO Hello(id, first, last) VALUES (3, 'Fred', 'Smith');" 
$SQLInsert = $SQLInsert + "INSERT INTO Hello(id, first, last) VALUES (4, 'Humpty', 'Dumpty');" 
$command.CommandText = $SQLInsert
$result = $command.ExecuteNonQuery()

$command = $SQLConnection.CreateCommand()
$SQLInsert = "INSERT INTO Hello(id, first, last) VALUES (5, 'Joe', 'Bloggs');" 
$command.CommandText = $SQLInsert
$result = $command.ExecuteNonQuery()

$query = "SELECT * FROM Hello"
$command = $SQLConnection.CreateCommand()
$command.CommandText = $query
$result = $command.ExecuteReader()

$table = new-object "System.Data.DataTable"
$table.Load($result)
$table | select-object @{Name="ID";Expression={$_.id}}, @{Name="First";Expression={$_.first}}, @{Name="Last";Expression={$_.last}}
$result.Close()

$SQLConnection.Close() 
