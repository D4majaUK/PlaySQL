$release = "2019042019"
  
$files = gci "$release\*.sql" | sort-object -property Name
$files | Format-Table

$full = ""

$sqlcount = 0
foreach($file in $files) {
	$name = "2019042019\" + $file.Name
	write-host -NoNewLine "Reading sql file...."
	$name = "2019042019\" + $file.Name
	write-host -fore yellow $name
	$query = get-content $name -raw

if ($query.ToUpper() -match "DELETE FROM" -or $query.ToUpper() -match "TRUNCATE TABLE" -or $query.ToUpper() -match "DROP TABLE") {
	$full += "[This may cause data loss]       $query"
} else {
	$full += $query
}
$full += "`r`n`r`n"
	
		if ($query.ToUpper() -match "UPDATE" -or $query.ToUpper() -match "SET") {
			write-host -fore cyan $query
			write-host -back cyan -fore black "--- WARNING!!! I found a script that contains the following (UPDATE and SET) ---"
		} elseif ($query.ToUpper() -match "DELETE FROM" -or $query.ToUpper() -match "TRUNCATE TABLE" -or $query.ToUpper() -match "DROP TABLE" -or $query.ToUpper() -match "ALTER TABLE") {
			write-host -fore cyan $query
			write-host -back red "--- WARNING!!! I found a script that contains one of the following (DELETE FROM, TRUNCATE TABLE, DROP TABLE, ALTER TABLE) ---"
		} elseif ($query.ToUpper() -notmatch "DELETE FROM" -and $query.ToUpper() -notmatch "TRUNCATE TABLE" -and $query.ToUpper() -notmatch "DROP TABLE" -and $query.ToUpper() -notmatch "ALTER TABLE") {
			write-host -fore cyan $query
		} else {
			write-host -fore cyan $query
		}
		write-host ""
		write-host ""
}

write-host ""
write-host ""
write-host "==>   The following is the full collection of scripts in one block   <=="
write-host ""
write-host ""
write-host $full
write-host ""
write-host ""
