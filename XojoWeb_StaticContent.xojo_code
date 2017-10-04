#tag Module
Protected Module XojoWeb_StaticContent
	#tag Method, Flags = &h0
		Function HandleStaticContent(Extends WebApp As WebApplication, Request As WebRequest, Folder As FolderItem, MIMEType As String = "application/octet-stream") As Boolean
		  // Verify we have a valid path so as not to catch blank GET requests.
		  If (Request.Path = "") Then
		    Return False
		  End If
		  
		  // Determine if we have a file that matches this path.
		  Dim _filePath As String
		  _filePath = Request.Path
		  #If TargetWindows = True Then
		    _filePath = _filePath.ReplaceAll("/", "\")
		  #EndIf
		  
		  Dim _folderPath As String
		  _folderPath = Folder.NativePath
		  #If TargetWindows = True Then
		    _folderPath = _folderPath + "\"
		  #ElseIf TargetLinux = True Or TargetMacOS = True Then
		    _folderPath = _folderPath + "/"
		  #EndIf
		  
		  Dim _fullPath As String
		  _fullPath = _folderPath + _filePath
		  
		  Dim _fileInFolder As FolderItem
		  _fileInFolder = GetFolderItem(_folderPath + _filePath, FolderItem.PathTypeNative)
		  
		  If (_fileInFolder = Nil) Then
		    Return False
		  End If
		  
		  If (_fileInFolder.Exists() = False) Then
		    Return False
		  End If
		  
		  // We got this far which means there is a file that matches this request path. Let's set the request MIME type.
		  If (_fileInFolder.Name.Lowercase().Right(4) = ".css") Then
		    Request.MIMEType = "text/css"
		  Else
		    Request.MIMEType = MIMEType
		  End If
		  
		  // We should also update the status code because some browsers are picky about this.
		  Request.Status = 200 // HTTP OK
		  
		  // Read the file contents and append to the request.
		  Dim _fileStream As BinaryStream
		  _fileStream = BinaryStream.Open(_fileInFolder)
		  
		  Request.Print(_fileStream.Read(_fileStream.Length))
		  
		  // Return True so Xojo Web sends the file down to the browser.
		  Return True
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
