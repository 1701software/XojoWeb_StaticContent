#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Function HandleURL(Request As WebRequest) As Boolean
		  // Call our static content handler. Each top level folder will require it's own handler.
		  If (App.HandleStaticContent(Request, App.ExecutableFile.Parent.Parent.Child("static1"), "application/pdf") = True) Then
		    // We overrode the default MIMEType because all files in "static1" are PDF's. This gives the browser additional context like opening the PDF inside the browser window.
		    Return True
		  End If
		  
		  If (App.HandleStaticContent(Request, App.ExecutableFile.Parent.Parent.Child("static2")) = True) Then
		    Return True
		  End If
		  
		  // Return False if none of our handlers returned true.
		  Return False
		  
		End Function
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
