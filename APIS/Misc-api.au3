; #FUNCTION# ====================================================================================================================
; Name ..........: _GetStringSize
; Description ...: Determine the size in bytes of a text string.
; Syntax ........: _GetStringSize($sString[, $iOutput = 0])
; Parameters ....: $sString             - String to determine the size of.
;                  $iOutput             - [optional] Format the bytes to the largest value e.g. 1024 bytes will be returned as 1 KB. Default is False - Unformatted or True - Formatted.
; Return values .: None
; Author ........: guinness
; Remarks........; Thanks to spiff59 for the format idea - http://www.autoitscript.com/forum/topic/116897-folder-sync-tool/page__view__findpost__p__815328 & trancexx for using StringLen.
; Example .......: Yes
; ===============================================================================================================================
Func _GetStringSize($sString, $fOutput = False)
    Local $aOutput[9] = [' bytes', ' KB', ' MB', ' GB', ' TB', ' PB', ' EB', ' ZB', ' YB'], $iCount = 0
    Local $iFileGetSize = StringLen($sString)
    If $fOutput = Default Then $fOutput = False
    If $fOutput Then
        While $iFileGetSize > 1023
            $iCount += 1
            $iFileGetSize /= 1024
        WEnd
        $iFileGetSize = Round($iFileGetSize, 2) & $aOutput[$iCount]
    EndIf
    Return $iFileGetSize
EndFunc   ;==>_GetStringSize


Func _decdec($code)
	Return _StringEncrypt(0,$code,"dedmenmiller@googlemail.com",1)
EndFunc