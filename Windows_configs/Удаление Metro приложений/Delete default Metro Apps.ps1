Function PSCustomErrorRecord
{
	Param
	(		
		[Parameter(Mandatory=$true,Position=1)][String]$ExceptionString,
		[Parameter(Mandatory=$true,Position=2)][String]$ErrorID,
		[Parameter(Mandatory=$true,Position=3)][System.Management.Automation.ErrorCategory]$ErrorCategory,
		[Parameter(Mandatory=$true,Position=4)][PSObject]$TargetObject
	)
	Process
	{
		$exception = New-Object System.Management.Automation.RuntimeException($ExceptionString)
		$customError = New-Object System.Management.Automation.ErrorRecord($exception,$ErrorID,$ErrorCategory,$TargetObject)
		return $customError
	}
}
	
Function RemoveAppxPackage
{
	$index=1
	$apps=Get-AppxPackage
	Write-Host "ID`t App name"
	foreach ($app in $apps)
	{
		Write-Host " $index`t $($app.name)"
		$index++
	}
    
    Do
    {
        $IDs=Read-Host -Prompt "Which Apps do you want to remove? `nInput their IDs by space  (e.g. 5 12 17). `nIf you want to remove every possible apps, enter 'all'"
    }
   
 While($IDs -eq "")

    if ($IDs -eq "all") {Get-AppXPackage -All | Remove-AppxPackage -ErrorAction SilentlyContinue –confirm
    	
			$AppName=($ID -ge 1 -and $ID -le $apps.name)			

			if (-not(Get-AppxPackage -Name $AppName))
			{
				Write-host "Apps has been removed successfully"
			}
			else
			{
				Write-Warning "Remove '$AppName' failed! This app is part of Windows and cannot be uninstalled on a per-user basis."
			}
    
    }

    else {
    
	try
	{	
		[int[]]$IDs=$IDs -split " "
 		
	}
       
	catch
	{
        $errorMsg = $Messages.IncorrectInput
		$errorMsg = $errorMsg -replace "Placeholder01",$IDs
		$customError = PSCustomErrorRecord `
		-ExceptionString $errorMsg `
		-ErrorCategory NotSpecified -ErrorID 1 -TargetObject $pscmdlet
		$pscmdlet.WriteError($customError)
		return
	}

	foreach ($ID in $IDs)
	{
		#check id is in the range
		if ($ID -ge 1 -and $ID -le $apps.count)
		{
			$ID--
			#Remove each app
			$AppName=$apps[$ID].name

			Remove-AppxPackage -Package $apps[$ID] -ErrorAction SilentlyContinue –confirm
			if (-not(Get-AppxPackage -Name $AppName))
			{
				Write-host "$AppName has been removed successfully"
			}
			else
			{
				Write-Warning "Remove '$AppName' failed! This app is part of Windows and cannot be uninstalled on a per-user basis."
			}
		}
		else
		{
			$errorMsg = $Messages.WrongID
			$errorMsg = $errorMsg -replace "Placeholder01",$ID
			$customError = PSCustomErrorRecord `
			-ExceptionString $errorMsg `
			-ErrorCategory NotSpecified -ErrorID 1 -TargetObject $pscmdlet
			$pscmdlet.WriteError($customError)
		}
	}
  }
}

		
		


$result = 0;

while ($result -eq 0) {

RemoveAppxPackage

$title = "Delete Apps"
$message = "Do you want to continue?"

$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
    "Yes, I want to remove another application." 

$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
    "No, all unnecessary applications are removed."

$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

}