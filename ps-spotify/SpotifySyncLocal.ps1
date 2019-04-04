    Import-Module .\ps-spotify\ps-spotify.psd1 -Force
    Remove-Item .\nomatch.out -Force
    Remove-Item .\exactMatch.out -Force
    Remove-Item .\multiMatch.out -Force
    $Folder = "E:\Music\iTunes\iTunes Media\Music"
    $localAlbumList = Get-AlbumsFromLocal -Folder  $Folder
    foreach($localAlbum in $localAlbumList){
        Write-Host "Searching Spotify for $($localAlbum.Name) by $($localAlbum.Artist)..." -NoNewline
        $spotifyResult = Find-SpotifyItem -Type album -Query "artist:`"$($localAlbum.Artist)`" album:`"$($localAlbum.Name)`""
        Write-Host "Found $($spotifyResult.albums.items.Count) album(s)"
        Start-Sleep -Milliseconds 500
        if($spotifyResult.albums.items.Count -eq 0){
            Out-File -FilePath .\nomatch.out -Append -InputObject $localAlbum.LocalPath
         }elseif($spotifyResult.albums.items.Count -eq 1){
            Out-File -FilePath .\exactMatch.out -Append -InputObject "$($localAlbum.Name) by $($localAlbum.Artist)"
         }elseif($spotifyResult.albums.items.Count -gt 1){
            Out-File -FilePath .\multiMatch.out -Append -InputObject "$($localAlbum.Name) by $($localAlbum.Artist)"
         }

    }
