param (
	[string] $force = "N"
)

$Global:SCCMSQLSERVER = "LOCALHOST" 
$Global:DBNAME = "TEST" 
$goFwd = 0

clear

Try 
{ 
    $SQLConnection = New-Object System.Data.SQLClient.SQLConnection 
    $SQLConnection.ConnectionString ="server=$SCCMSQLSERVER;database=$DBNAME;User ID=SA;Password=myStrongSnickers!&%B4r" 
    $SQLConnection.Open() 
	write-host ""
    write-host -NoNewLine "Database Connection status: "
	write-host -fore green "Connected"
    $goFwd = 1
} 
catch 
{ 
    write-host -fore red "Failed to connect" 
} 

if ($goFwd -eq 1) {

	write-host ""
    write-host "Getting info from database...."
    $query = "SELECT * FROM Hello"
    $command = $SQLConnection.CreateCommand()
    $command.CommandText = $query
    $result = $command.ExecuteReader()

    $table = new-object "System.Data.DataTable"
    $table.Load($result)
	$table | Format-Table
    $result.Close()
  
	$release = "2019042019"
	if (test-path "$release\complete") {
		if ($force.ToUpper() -eq "Y") {
			remove-item "$release\complete\*.*" -recurse -force
		} else {
			write-host "Found folder"
			$ofiles = gci "$release\complete" | sort-object -property Name
			$ofiles | Format-Table
			if ($ofiles.count -gt 0) {
				$prun = $ofiles.count
				write-host "Looks like this function has been executed already - 2 files exist"
			}
		}
	} else {
		md "$release\complete"
	}
  
	$files = gci "$release\*.sql" | sort-object -property Name
	$files | Format-Table

	$sqlcount = 0
	foreach($file in $files) {
		$name = "2019042019\" + $file.Name
		write-host -NoNewLine "Reading sql file...."
		$name = "2019042019\" + $file.Name
		write-host -fore yellow $name
		$query = get-content $name
		
		$done = 0
		$ofiles | where-object{$_.Name -eq $file.Name} | foreach-object {write-host -fore green "   Found this:    complete\$_ - WILL NOT RUN!!!"; $done = 1;}
		
		if ($query -match "UPDATE" -or $query -match "SET") {
			write-host -fore cyan "  " $query
			write-host -NoNewLine "   "
			write-host -back cyan -fore black "--- WARNING!!! I found a script that contains the following (UPDATE and SET) ---"
		} elseif ($query -notmatch "DELETE FROM" -and $query -notmatch "TRUNCATE TABLE" -and $query -notmatch "DROP TABLE" -and $done -eq 0) {
			write-host -fore cyan "  " $query
			$command = $SQLConnection.CreateCommand()
			$command.CommandText = $query
			$result = $command.ExecuteReader()
			$table = new-object "System.Data.DataTable"
			$table.Load($result)
			$result.Close()
			$table | Format-Table
			$result.Close()			
			copy-item $name "$release\complete"
			$sqlcount++
		} else {
			write-host -fore cyan "  " $query
			write-host -NoNewLine "   "
			write-host -back red "--- WARNING!!! I found a script that contains one of the following (DELETE FROM, TRUNCATE TABLE, DROP TABLE) ---"
		}
		write-host ""
	}
    write-host "Closing database...."
    $SQLConnection.Close() 

	if ($sqlcount -gt 0) {
		write-host "You have executed $sqlcount script(s)"
		$files = gci "$release\complete\*.sql" | sort-object -property Name
		$files | Format-Table
	}
}
