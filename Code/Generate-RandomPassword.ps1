<#
    Generate-RandomPassword.ps1

    Description:
    This script defines a function to generate a random password with a specified minimum and maximum length.
    The generated password will include at least one lowercase letter, one uppercase letter, one digit, and one special character.

    Key Features:
    - Parameters to specify the minimum and maximum password lengths (default: 12 to 16 characters).
    - The password includes lowercase, uppercase, numeric, and special characters.
    - Ensures that at least one character from each category is present in the generated password.
    - Shuffles the final password to randomize the order of characters.

    Parameters:
    - `$MinLength`: The minimum length of the generated password (default is 12).
    - `$MaxLength`: The maximum length of the generated password (default is 16).

    Output:
    - The script outputs a randomly generated password that meets the specified criteria.

    Example Usage:
    - Call the function `Generate-RandomPassword` to generate a password and output it.

    Requirements:
    - PowerShell environment (version 5.1 or later recommended).

    Note:
    - Ensure that the generated password meets your security requirements before use.
#>

function Generate-RandomPassword {
    param (
        [int]$MinLength = 12,
        [int]$MaxLength = 16
    )

    # Define character sets
    $lowercase = 'abcdefghijklmnopqrstuvwxyz'
    $uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $numbers = '0123456789'
    $specialChars = '!@#$%^&*()-_=+[]{}|;:,.<>?'
    
    # Ensure all types of characters are included
    $password = -join (
        $lowercase[(Get-Random -Minimum 0 -Maximum $lowercase.Length)],
        $uppercase[(Get-Random -Minimum 0 -Maximum $uppercase.Length)],
        $numbers[(Get-Random -Minimum 0 -Maximum $numbers.Length)],
        $specialChars[(Get-Random -Minimum 0 -Maximum $specialChars.Length)]
    )
    
    # Determine the remaining length needed
    $remainingLength = (Get-Random -Minimum $MinLength -Maximum ($MaxLength + 1)) - $password.Length
    
    # Combine all character sets for the remaining characters
    $allChars = $lowercase + $uppercase + $numbers + $specialChars
    $randomChars = -join ((1..$remainingLength) | ForEach-Object { $allChars[(Get-Random -Minimum 0 -Maximum $allChars.Length)] })
    
    # Shuffle the result to mix mandatory characters with random characters
    $password += $randomChars
    $password = -join ($password.ToCharArray() | Sort-Object {Get-Random})
    
    return $password
}

# Example usage:
$randomPassword = Generate-RandomPassword
Write-Output $randomPassword