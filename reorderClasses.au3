#include <Array.au3>
#include <FileConstants.au3>
Local $sFileRead = FileRead("testIn.txt")


Local $baseClasses = StringRegExp($sFileRead, '(class .*?;)', $STR_REGEXPARRAYGLOBALMATCH, 0)

#include <Array.au3>

Local $classes[0]
$iOffset = 1
While 1
   $aArray = StringRegExp($sFileRead, '(class .*?(: ?.*? ?){)', $STR_REGEXPARRAYMATCH, $iOffset)
   If @error Then ExitLoop
   $iOffset = @extended
   $startOffset = $iOffset - StringLen($aArray[0])

   $braceCounter = 1
   While 1
	  $chararacter = StringMid($sFileRead,$iOffset,1)
	  If ($chararacter  == "{") Then
		 $braceCounter = $braceCounter + 1
	  EndIf
	  If ($chararacter  == "}") Then
		 $braceCounter = $braceCounter - 1
	  EndIf
	  If ($braceCounter ==0) Then
		 $iOffset = $iOffset+1
		 ExitLoop
	  EndIf
	  $iOffset = $iOffset+1
   WEnd

   $iOffset = $iOffset+1;Semicolon at end

   ;_ArrayDisplay($aArray, StringMid($sFileRead,$iOffset,20))

   ;MsgBox($MB_SYSTEMMODAL, "RegExp Test with Option 1 - ", StringMid($sFileRead, $startOffset, $iOffset-$startOffset))
   _ArrayAdd($classes, StringMid($sFileRead, $startOffset, $iOffset-$startOffset))
WEnd

Local $2DBaseClasses[0][2]

For $vElement In $baseClasses
   $match = StringRegExp($vElement, 'class ([^:; ]*)', $STR_REGEXPARRAYMATCH, 0)

   Local $arr[1][2]
   $arr[0][0] = $match[0]
   $arr[0][1] = $vElement

   _ArrayAdd($2DBaseClasses, $arr )
Next
_ArrayDisplay($2DBaseClasses, "Base classes")

;Local $unsortedBaseClasses[0]
;For $a=0 to ubound($2DBaseClasses)-1
;   _ArrayAdd($unsortedBaseClasses, $2DBaseClasses[$a][0] )
;Next
;_ArrayDisplay($unsortedBaseClasses)

_ArraySort($2DBaseClasses, 0, 0, 0, 0)

;Local $sortedBaseClasses[0]
;for $a=0 to ubound($2DBaseClasses)-1
;   _ArrayAdd($sortedBaseClasses, $2DBaseClasses[$a][0] )
;Next
;_ArrayDisplay($sortedBaseClasses)

Local $2DClasses[0][2]

For $vElement In $classes
   $match = StringRegExp($vElement, 'class ([^:; ]*)', $STR_REGEXPARRAYMATCH, 0)

   Local $arr[1][2]
   $arr[0][0] = $match[0]
   $arr[0][1] = $vElement

   _ArrayAdd($2DClasses, $arr )
Next
_ArrayDisplay($2DClasses, "classes")

_ArraySort($2DClasses, 0, 0, 0, 0)


$outFile = FileOpen("testOut.txt", $FO_OVERWRITE )


for $a=0 to ubound($2DBaseClasses)-1
   FileWrite($outFile, $2DBaseClasses[$a][1] & @LF)
Next

for $a=0 to ubound($2DClasses)-1
   FileWrite($outFile, $2DClasses[$a][1] & @LF)
Next