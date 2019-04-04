Function Get-AlbumsFromLocal {
    <#
        .SYNOPSIS
            Searches a folder structure and returns an object containg albumns and their associated artists. Assumes folder structure is in Artist\Albumn format.

        .EXAMPLE
            PS /Users/bart> Get-AlbumsFromLocal -Folder ./Music

        .PARAMETER Folder
            Required. Folder to search
    #>

    [CmdLetBinding(DefaultParameterSetName)]
    Param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Path to one location.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string]
        $Folder
    )

    $albums = @()

    $albumFolders = Get-ChildItem -Path $Folder -Recurse -Depth 1 -Directory
    foreach($albumFolder in $albumFolders){
        $splitAlbumFolder = ($albumFolder.FullName.Replace("$Folder\","")).Split("\")
        if($splitAlbumFolder.length -eq 2){
            $albums += @{"Artist"=$splitAlbumFolder[0];"Name"=$splitAlbumFolder[1];"LocalPath"=$albumFolder.FullName}
            
        }
    }
    Return $albums
}