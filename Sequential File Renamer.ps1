<# The intention of this script is to somewhat automate the process of renaming video files, specifically TV shows or Anime series. #>
<# When I 'acquire' a show, often times the episodes are named in a way that I don't really like, so I've been manually renaming them, but that got old and I got bored...#>
<# I'm a very amateur programmer, so I'm sure there's a way to make this script completely automated but as it stands the script does require some user input to get going. #>
<# You will need to tell the program where the video files you want renamed are and you will also have to tell it what file type they are.  Once that information is provided it will gather a list of your chosen video files #>
<# You will then be prompted to provide the name of the show as well as what season.  From here the script will do it's thing and rename your files from something like "My_Show_S1_Episode_XYSSYXS.mkv" to "My Show S01E01.mkv" #>
<# That's basically it.  It's far from perfect and can easily break but it kind of works and is making my life a lot easier. #>

do{
    $i=0;
    $location = Read-Host -Prompt "Where are the files located?";
    $format = Read-Host -Prompt "What is the file type of the videos files? (Do not inclued the '.' mkv, mp4, etc...)";
    [array]$files=Get-ChildItem -File $location -Recurse -Include *.$format;
    $count = $files.Length;
    $showname = Read-Host -Prompt "Name of the Show?";
    $seasonNum = Read-Host -Prompt "Which Season? (Just the number, i.e. 1, 2, etc...)";

    do {

        $oldName = $files[$i].Name;
        $fileLocation = "$location\$oldName";
        $episode = $i + 1;
       
        if ($episode -ge 10){
            Rename-Item -Path $fileLocation -NewName "$($showname) S0$($seasonNum)E$($episode).$($format)";
        }else {
            Rename-Item -Path $fileLocation -NewName "$($showname) S0$($seasonNum)E0$($episode).$($format)";
        };

        $i++;  
           
    }until ($i -eq $count);
    
    $finish = Read-Host -Prompt "Would you like to rename anymore files? (Y/N)";

}until ($finish -eq "N" -or $finish -eq "n");