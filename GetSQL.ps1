$release = "2019042019"
  
$files = gci "$release\*.sql" | sort-object -property Name
$files | Format-Table

$sqlcount = 0
foreach($file in $files) {
	$name = "2019042019\" + $file.Name
	write-host -NoNewLine "Reading sql file...."
	$name = "2019042019\" + $file.Name
	write-host -fore yellow $name
	$query = get-content $name -raw
	
	if ($query.ToUpper() -match "UPDATE" -or $query.ToUpper() -match "SET") {
		write-host -fore cyan $query
		write-host -back cyan -fore black "--- WARNING!!! I found a script that contains the following (UPDATE and SET) ---"
	} elseif ($query.ToUpper() -notmatch "DELETE FROM" -and $query.ToUpper() -notmatch "TRUNCATE TABLE" -and $query.ToUpper() -notmatch "DROP TABLE" -and $done -eq 0) {
		write-host -fore cyan $query
	} else {
		write-host -fore cyan $query
		write-host -back red "--- WARNING!!! I found a script that contains one of the following (DELETE FROM, TRUNCATE TABLE, DROP TABLE) ---"
	}
	write-host ""
	write-host ""
}
