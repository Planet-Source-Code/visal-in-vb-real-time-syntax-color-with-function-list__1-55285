VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RichTx32.ocx"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6420
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   11340
   LinkTopic       =   "Form1"
   ScaleHeight     =   6420
   ScaleWidth      =   11340
   StartUpPosition =   3  'Windows Default
   Begin RichTextLib.RichTextBox RTF 
      Height          =   6375
      Left            =   3600
      TabIndex        =   1
      Top             =   0
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   11245
      _Version        =   393217
      ScrollBars      =   3
      DisableNoScroll =   -1  'True
      RightMargin     =   80000
      AutoVerbMenu    =   -1  'True
      TextRTF         =   $"Form1.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.TreeView TV 
      Height          =   6375
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   11245
      _Version        =   393217
      HideSelection   =   0   'False
      Indentation     =   18
      LabelEdit       =   1
      LineStyle       =   1
      Sorted          =   -1  'True
      Style           =   7
      ImageList       =   "ImgList"
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ImageList ImgList 
      Left            =   8520
      Top             =   5160
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   7
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":0080
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":100BA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":10A6C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":10D86
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":110A0
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":113BA
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":116D4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu m_file 
      Caption         =   "File"
      Begin VB.Menu m_open 
         Caption         =   "Load Test File ..."
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'###########################################################################
' Copyright ©2004 by Visal ,In
'
' Author  : Visal ,In
' eMail:    invisal@gmail.com
'
' Description : VB(Visual Basic) Real Time Syntax Color Very Fast
' And With List Of Sub Function Event etc.. And Also Easy Color To Understan.
' And If You Use My Code In Your Project Please Put Me Name On It
' If You Use My Code For Sale Please Let Me Know.
'#############################################################################

'Send Message Declare
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" _
(ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long

'wMSG For Find Line Position
Const EM_LINEINDEX = &HBB
Const WM_SETREDRAW = &HB

Dim bKey As Boolean
' True If The RTF Is Change
Dim bChange As Boolean
' Last Line Of RTF
Dim LastLine As Integer

' Color
Dim K_COLOR(1 To 2) As Long
Dim C_COLOR As Long
Dim Q_COlOR As Long
Dim N_Color As Long

Dim strDelimiter As String
Dim Delimiter(27) As String

Dim LastStart As Long

' Keyword
Const ReservWord = " Declare And ByRef ByVal Call Case Class Const Dim Do Each Else ElseIf Empty End Eqv Erase Error Exit Explicit False For Function Get If Imp In Is Let Loop Mod Next Not Nothing Null On Option Or Private Property Public Randomize ReDim Resume Select Set Step Sub Then To True Until Wend While Xor As Long Integer Boolean New "
Const FuncWord = " Anchor Array Asc Atn CBool CByte CCur CDate CDbl Chr CInt CLng Cos CreateObject CSng CStr Date DateAdd DateDiff DatePart DateSerial DateValue Day Dictionary Document Element Err Exp FileSystemObject  Filter Fix Int Form FormatCurrency FormatDateTime FormatNumber FormatPercent GetObject Hex History Hour InputBox InStr InstrRev IsArray IsDate IsEmpty IsNull IsNumeric IsObject Join LBound LCase Left Len Link LoadPicture Location Log LTrim RTrim Trim Mid Minute Month MonthName MsgBox Navigator Now Oct Replace Right Rnd Round ScriptEngine ScriptEngineBuildVersion ScriptEngineMajorVersion ScriptEngineMinorVersion Second Sgn Sin Space Split Sqr StrComp String StrReverse Tan Time TextStream TimeSerial TimeValue TypeName UBound UCase VarType Weekday WeekDayName Window Year "

Private Sub Form_Load()

' Loading Color
N_Color = vbBlack   '' Normal Text Color
C_COLOR = RGB(0, 150, 0) '' Comment Text Color
Q_COlOR = RGB(200, 100, 100) ''Quoation Text Color
K_COLOR(1) = RGB(0, 0, 200) '' ReservWord Color
K_COLOR(2) = RGB(255, 0, 0) '' Function Wrold Color

strDelimiter = ",(){}[]-+*%/='~!&|<>?:;.#@" & Chr(34) & vbTab

For i = 0 To Len(strDelimiter) - 1
    
    'Delimiter
    Delimiter(i) = Mid(strDelimiter, i + 1, 1)
    
    Select Case Delimiter(i)
        
        Case "\"
            Delimiter(i) = "\\"
        Case "}"
            Delimiter(i) = "\}"
        Case "{"
            Delimiter(i) = "\{"
        
    End Select
    
Next i

'Loading...
LastLine = -1
'Update The TreeView List
UpdateTV

End Sub

Private Sub UpdateTV()

On Error Resume Next

Dim TVNode As Node

Dim strLines() As String
Dim strRLines() As String
Dim strCode As String
Dim strLine As String
Dim strAdd As String
Dim onSUB As Boolean
Dim iKey As Integer
Dim onType As Boolean
Dim i As Integer

bKey = Not bKey

'##############################
'Replace The RTF Text to strCode
'So It More Easy To Search
'###############################

strCode = RTF.Text
strCode = Replace(strCode, "Global ", "Global" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Const ", "Const" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Dim ", "Dim" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Private ", "Private" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Public ", "Public" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Sub ", "Sub" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Function ", "Function" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Type ", "Type" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "End ", "End" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Declare ", "Declare" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Enum ", "Enum" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Event ", "Event" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Property ", "Property" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Get ", "Get" & Chr(1), , , vbTextCompare)
strCode = Replace(strCode, "Let ", "Let" & Chr(1), , , vbTextCompare)

strCode = Replace(strCode, " ", "")
strCode = Replace(strCode, vbTab, "")

strLines = Split(strCode, vbCrLf)
strRLines = Split(RTF.Text, vbCrLf)

'##################
'Load The Directory
'##################

Set TVNode = TV.Nodes.Add(, , "D", "Declears", 1)
Set TVNode = TV.Nodes.Add(, , "EN", "Enums", 1)
Set TVNode = TV.Nodes.Add(, , "T", "Types", 1)
Set TVNode = TV.Nodes.Add(, , "V", "Varibles", 1)
Set TVNode = TV.Nodes.Add(, , "C", "Constans", 1)
Set TVNode = TV.Nodes.Add(, , "E", "Events", 1)
Set TVNode = TV.Nodes.Add(, , "S", "Sub", 1)
Set TVNode = TV.Nodes.Add(, , "F", "Functions", 1)
Set TVNode = TV.Nodes.Add(, , "PG", "Properties Get", 1)
Set TVNode = TV.Nodes.Add(, , "PL", "Properties Let", 1)

'##################################
'Starting Add The Child In To Nodes
'##################################

For i = 0 To UBound(strLines)
    strLine = strLines(i)
    strAdd = strRLines(i)
    
'###########################################################################
'DECLEARS (Private Declare Function,Public Declare Function,Declare Function)
'###########################################################################
    
    'Declare
    If UCase(Left(strLine, 17)) = "DECLAREFUNCTION" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "DECLARE FUNCTION", vbTextCompare) - 16)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("D", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Private Declare
    If UCase(Left(strLine, 25)) = "PRIVATEDECLAREFUNCTION" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE DECLARE FUNCTION", vbTextCompare) - 24)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("D", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Private Declare
    If UCase(Left(strLine, 24)) = "PUBLICDECLAREFUNCTION" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC DECLARE FUNCTION", vbTextCompare) - 23)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("D", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
'###########################################################################
'Property Get (Private Property Get,Public Property Get,Property Get)
'###########################################################################
    
    'Property Get
    If UCase(Left(strLine, 13)) = "PROPERTYGET" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PROPERTY GET", vbTextCompare) - 12)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("PG", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Property Get
    If UCase(Left(strLine, 21)) = "PRIVATEPROPERTYGET" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE PROPERTY GET", vbTextCompare) - 20)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("PG", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Property Get
    If UCase(Left(strLine, 20)) = "PUBLICPROPERTYGET" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC PROPERTY GET", vbTextCompare) - 19)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("PG", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
'###########################################################################
'Property Let (Private Property Let,Public Property Let,Property Let)
'###########################################################################
    
    'Property Let
    If UCase(Left(strLine, 13)) = "PROPERTYLET" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PROPERTY LET", vbTextCompare) - 12)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("PL", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Property Let
    If UCase(Left(strLine, 21)) = "PRIVATEPROPERTYLET" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE PROPERTY LET", vbTextCompare) - 20)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("PL", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Property Let
    If UCase(Left(strLine, 20)) = "PUBLICPROPERTYLET" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC PROPERTY LET", vbTextCompare) - 19)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("PL", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If

'####################################################
'FUNCTION (PUBLIC FUNCTION,PRIVATE FUNCTION,FUNCTION)
'####################################################

    'Function
    If UCase(Left(strLine, 9)) = "FUNCTION" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "FUNCTION", vbTextCompare) - 8)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("F", tvwChild, bKey & i, strAdd, 2)
            onSUB = True
        End If
        GoTo SkipIt
    End If
    
    'Private Function
    If UCase(Left(strLine, 17)) = "PRIVATEFUNCTION" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE FUNCTION", vbTextCompare) - 16)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("F", tvwChild, bKey & i, strAdd, 2)
            onSUB = True
        End If
        GoTo SkipIt
    End If
    
    'Public Function
    If UCase(Left(strLine, 16)) = "PUBLICFUNCTION" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC FUNCTION", vbTextCompare) - 15)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("F", tvwChild, bKey & i, strAdd, 2)
            onSUB = True
        End If
        GoTo SkipIt
    End If
    
'################################
'SUB (PUBLIC SUB,PRIVATE SUB,SUB)
'################################

    'Sub
    If UCase(Left(strLine, 4)) = "SUB" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "SUB", vbTextCompare) - 3)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("S", tvwChild, bKey & i, strAdd, 2)
            onSUB = True
        End If
        GoTo SkipIt
    End If
    
    'Private Sub
    If UCase(Left(strLine, 12)) = "PRIVATESUB" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE SUB", vbTextCompare) - 11)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("S", tvwChild, bKey & i, strAdd, 2)
            onSUB = True
        End If
        GoTo SkipIt
    End If
    
    'Public Sub
    If UCase(Left(strLine, 11)) = "PUBLICSUB" Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC SUB", vbTextCompare) - 10)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("S", tvwChild, bKey & i, strAdd, 2)
            onSUB = True
        End If
        GoTo SkipIt
    End If
    
'##################################
'ENUM(PRIVATE ENUM,PUBLIC ENUM,ENUM)
'##################################
    
    'ENUM
    If UCase(Left(strLine, 5)) = "ENUM" And onSUB = False And onType = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "ENUM", vbTextCompare) - 4)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("EN", tvwChild, bKey & i, strAdd, 2)
            onType = True
        End If
        GoTo SkipIt
    End If
    
    'Private Enum
    If UCase(Left(strLine, 13)) = "PRIVATEENUM" And onSUB = False And onType = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE ENUM", vbTextCompare) - 12)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("EN", tvwChild, bKey & i, strAdd, 2)
            onType = True
        End If
        GoTo SkipIt
    End If
    
    'Public Enum
    If UCase(Left(strLine, 12)) = "PUBLICENUM" And onSUB = False And onType = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC ENUM", vbTextCompare) - 11)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("EN", tvwChild, bKey & i, strAdd, 2)
            onType = True
        End If
        GoTo SkipIt
    End If


'####################################
'Types (TYPE,PRIVATE TYPE,PUBLIC TYPE)
'####################################

    'Type
    If UCase(Left(strLine, 5)) = "TYPE" And onSUB = False And onType = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "TYPE", vbTextCompare) - 4)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("T", tvwChild, bKey & i, strAdd, 2)
            onType = True
        End If
        GoTo SkipIt
    End If
    
    'Private Type
    If UCase(Left(strLine, 13)) = "PRIVATETYPE" And onSUB = False And onType = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE TYPE", vbTextCompare) - 12)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("T", tvwChild, bKey & i, strAdd, 2)
            onType = True
        End If
        GoTo SkipIt
    End If
    
    'Public Type
    If UCase(Left(strLine, 12)) = "PUBLICTYPE" And onSUB = False And onType = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC TYPE", vbTextCompare) - 11)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("T", tvwChild, bKey & i, strAdd, 2)
            onType = True
        End If
        GoTo SkipIt
    End If
    
    'End Type
    If UCase(Left(strLine, 8)) = "ENDTYPE" And onSUB = False And onType = True Then
        onType = False
        GoTo SkipIt
    End If
    

'##################################################
'Events (Event PRIVATE Event,PUBLIC Event)
'##################################################

    'Event
    If UCase(Left(strLine, 6)) = "EVENT" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "EVENT", vbTextCompare) - 5)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("E", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Private Event
    If UCase(Left(strLine, 14)) = "PRIVATEEVENT" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE EVENT", vbTextCompare) - 13)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("E", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Public Event
    If UCase(Left(strLine, 13)) = "PUBLICEVENT" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC EVENT", vbTextCompare) - 12)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("E", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If

'##################################################
'Constans (GLOBAL CONST,PRIVATE CONST,PUBLIC CONST)
'##################################################

    'Global
    If UCase(Left(strLine, 7)) = "GLOBAL" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "GLOBAL", vbTextCompare) - 6)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("C", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If

    'Const
    If UCase(Left(strLine, 6)) = "CONST" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "CONST", vbTextCompare) - 5)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("C", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Private Const
    If UCase(Left(strLine, 14)) = "PRIVATECONST" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE CONST", vbTextCompare) - 13)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("C", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Public Const
    If UCase(Left(strLine, 13)) = "PUBLICCONST" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC CONST", vbTextCompare) - 12)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("C", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If

'#############################
'Varibles (DIM PRIVATE PUBLIC)
'#############################

    'Dim
    If UCase(Left(strLine, 4)) = "DIM" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "DIM", vbTextCompare) - 3)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("V", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Private
    If UCase(Left(strLine, 8)) = "PRIVATE" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PRIVATE", vbTextCompare) - 7)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("V", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If
    
    'Public
    If UCase(Left(strLine, 7)) = "PUBLIC" And onSUB = False Then
        strAdd = Right(strAdd, Len(strAdd) - InStr(1, strAdd, "PUBLIC", vbTextCompare) - 6)
        If Len(strAdd) > 0 Then
            Set TVNode = TV.Nodes.Add("V", tvwChild, bKey & i, strAdd, 2)
        End If
        GoTo SkipIt
    End If

SkipIt:
Next i

'################
'Remove Old Nodes
'################
i = 0
Do Until i = TV.Nodes.Count
    i = i + 1
    If Left(TV.Nodes(i).Key, Len(CStr(Not bKey))) = CStr(Not bKey) Then
        TV.Nodes.Remove (i)
        i = i - 1
    End If
Loop

bChange = False

End Sub

Private Sub Form_Resize()

On Error Resume Next

TV.Left = 0
TV.Top = 0
TV.Height = Me.Height - 700

RTF.Height = TV.Height
RTF.Left = TV.Width
RTF.Top = 0
RTF.Width = Me.Width - (TV.Width + 150)

RTF.SetFocus

End Sub

Private Sub m_open_Click()

Dim strData As String

Open App.Path & "\test.txt" For Input As #1
    strData = StrConv(InputB(LOF(1), 1), vbUnicode)
Close #1

RTF.Text = ""
RTF.SelText = strData

End Sub

Private Sub RTF_Change()

bChange = True

' Update Color
Dim OStart As Long
Dim OLen As Long

Dim StartPos As Long
Dim EndPos As Long

Dim EndLine As Integer
Dim StartLine As Integer
Dim X As Long

Dim Text As String

With RTF

If .Text = "" Then Exit Sub

X = SendMessage(.hWnd, WM_SETREDRAW, 0, 0)

If LastStart > .SelStart Then
    EndLine = .GetLineFromChar(LastStart)
    StartLine = .GetLineFromChar(.SelStart)
Else
    StartLine = .GetLineFromChar(LastStart)
    EndLine = .GetLineFromChar(.SelStart)
End If

StartPos = SendMessage(.hWnd, EM_LINEINDEX, StartLine, 0&)
EndPos = SendMessage(.hWnd, EM_LINEINDEX, EndLine + 1, 0&)

If EndPos <= 0 Then EndPos = Len(.Text)

OStart = .SelStart
OLen = .SelLength

.SelStart = StartPos
.SelLength = EndPos - StartPos

.SelColor = N_Color
.SelBold = False
Text = .SelText
.SelRTF = ColorIt(Text)

.SelStart = OStart
.SelLength = OLen

LastStart = .SelStart

X = SendMessage(.hWnd, WM_SETREDRAW, 1, 0)
.Refresh

End With

End Sub

Private Sub RTF_KeyDown(KeyCode As Integer, Shift As Integer)

Dim LevelText As String
Dim StartLastLine As Long
Dim EndLastLine As Long
Dim i As Long

LevelText = ""

If KeyCode = 9 Then
    RTF.SetFocus
    RTF.SelText = vbTab
    KeyCode = 0
End If

If KeyCode = 13 Then
    KeyCode = 0
    
        LastLine = RTF.GetLineFromChar(RTF.SelStart)
        
        StartLastLine = SendMessage(RTF.hWnd, EM_LINEINDEX, LastLine, 0&)
        EndLastLine = SendMessage(RTF.hWnd, EM_LINEINDEX, LastLine + 1, 0&)
        
        If EndLastLine = -1 Then EndLastLine = Len(RTF.Text)
        
        For i = StartLastLine + 1 To EndLastLine
            If Mid(RTF.Text, i, 1) = " " Or Mid(RTF.Text, i, 1) = vbTab Then
                LevelText = LevelText & Mid(RTF.Text, i, 1)
            Else
                Exit For
            End If
        Next i
        
        RTF.SelText = vbCrLf & LevelText
        
End If

End Sub

Private Sub RTF_KeyUp(KeyCode As Integer, Shift As Integer)

'Update While The Code Change
If RTF.GetLineFromChar(RTF.SelStart) <> LastLine And bChange = True Then
    UpdateTV
End If

LastLine = RTF.GetLineFromChar(RTF.SelStart)

End Sub

Private Sub TV_Click()

RTF.SetFocus

End Sub

Private Sub TV_DblClick()

Dim i As Integer
Dim TVKey As String
Dim iLine As Integer
Dim LinePos As Long

'Get TreeView Index
i = TV.SelectedItem.Index
'Get TreeView Key
TVKey = TV.Nodes(i).Key

'Get Line Number
If TV.Nodes(i).Image = 2 Then
    iLine = CInt(Right(TVKey, Len(TVKey) - Len(CStr(bKey))))
    'Goto iLine
    LinePos = SendMessage(RTF.hWnd, EM_LINEINDEX, iLine, 0&)
    RTF.SelStart = LinePos
    RTF.SetFocus
End If

End Sub

Private Function ColorIt(Text As String) As String

Dim strLines() As String
Dim strLine As String
Dim strWord() As String
Dim intWord As Integer
Dim strWord1 As String

Dim strRTF As String
Dim strAllRTF As String
Dim strHeader As String

Dim onComment As Boolean
Dim onQuotation As Boolean

Dim i As Integer
Dim j As Integer

strLines = Split(Text, vbCrLf)

' Color
For i = LBound(strLines) To UBound(strLines)

    'Reset
    onComment = False
    onQuotation = False
    
    strLine = strLines(i)
    
    strLine = Replace(strLine, "\", "\\")
    strLine = Replace(strLine, "}", "\}")
    strLine = Replace(strLine, "{", "\{")
    
    ' Replace space to strline
    For j = 0 To 27
        
        strLine = Replace(strLine, Delimiter(j), Delimiter(j) & " ", , , vbTextCompare)
        
    Next j
    
    ' Split line to word
    strWord = Split(strLine, " ")
    
    For j = LBound(strWord) To UBound(strWord)
        
        Select Case UCase(strWord(j))
        
            ' Comment
            Case "'"
                
                If onQuotation = False Then
                    If onComment = False Then
                
                        onComment = True
                        strWord(j) = "\cf4 " & strWord(j)
                        
                        GoTo EndLine
                    
                    End If
                End If
            
            ' Quotation
            Case Chr(34)
            
                If onComment = False Then
                    If onQuotation = False Then
                
                        onQuotation = True
                        strWord(j) = "\cf5 " & strWord(j)
                        
                        GoTo EndIt
                
                    Else
                
                        onQuotation = False
                        strWord(j) = strWord(j) & "\cf0"
                        
                        GoTo EndIt
                
                    End If
                End If
                
            ' Comment
            Case "REM"
                
                If onQuotation = False Then
                    If onComment = False Then
                
                        onComment = True
                        strWord(j) = "\cf4 " & strWord(j)
                        
                        GoTo EndLine
                    
                    End If
                End If
            
            Case Else
                
                intWord = InStr(1, strDelimiter, Right(strWord(j), 1))
                
                If intWord > 0 Then
                
                    strWord1 = Delimiter(intWord - 1)
                    If Len(strWord(j)) <= 0 Then GoTo EndIt
                    strWord(j) = Left(strWord(j), Len(strWord(j)) - Len(strWord1))
                    
                End If
                
                If onQuotation = False Then
                
                    If InStr(1, ReservWord, " " & strWord(j) & " ", vbTextCompare) > 0 Then
                        strWord(j) = "\cf2\b1 " & strWord(j) & "\b0\cf0 "
                    End If
                    
                    If InStr(1, FuncWord, " " & strWord(j) & " ", vbTextCompare) > 0 Then
                        strWord(j) = "\cf3 " & strWord(j) & "\cf0 "
                    End If
                    
                End If
                
                If intWord > 0 Then
                
                    ' Comment and Quotation
                    Select Case strWord1
                    
                        ' Comment
                        Case "'"
                            If onQuotation = False Then
                                If onComment = False Then
                
                                    onComment = True
                                    strWord1 = "\cf4 " & strWord1
                                    
                                    GoTo EndColor
                    
                                End If
                            End If
                            
                        'Quotation
                        Case Chr(34)
                        
                            If onComment = False Then
                                If onQuotation = False Then
                
                                    onQuotation = True
                                    strWord1 = "\cf5 " & strWord1
                                    
                                    GoTo EndColor
                        
                
                                Else
                
                                onQuotation = False
                                strWord1 = strWord1 & "\cf0"
                                
                                GoTo EndColor
                
                                End If
                            End If
                    
                    End Select
                    
EndColor:
                
                    strWord(j) = strWord(j) & strWord1
                    
                    If onComment = True Then
                        GoTo EndLine
                    End If
                    
                End If
                
        End Select
        
EndIt:
    
    Next j
EndLine:
    
    strLine = Join(strWord, " ")
    
    For j = 0 To 27
        
        strLine = Replace(strLine, Delimiter(j) & " ", Delimiter(j), , , vbTextCompare)
        
    Next j
    
    
    If onComment = True Then
        strLine = strLine & "\cf0"
    End If
    
    If onQuotation = True Then
        strLine = strLine & "\cf0"
    End If
    
    strLines(i) = strLine
    
Next i

strRTF = Join(strLines, vbCrLf & "\par ")
strHeader = CreateHeader

strAllRTF = strHeader & strRTF & vbCrLf & "}"

ColorIt = strAllRTF


End Function

Private Function CreateHeader() As String

Dim H1 As String
Dim H2 As String
Dim ColorH As String
Dim i As Integer

' Color Header
ColorH = "{\colortbl " & ConverColorToRTF(N_Color)
For i = 1 To 2
    ColorH = ColorH & ConverColorToRTF(K_COLOR(i))
Next i

ColorH = ColorH & ConverColorToRTF(C_COLOR)
ColorH = ColorH & ConverColorToRTF(Q_COlOR)
ColorH = ColorH & ";}"

' Header
H1 = "{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 " & RTF.Font.Name & ";}}"
H2 = "\viewkind4\uc1\pard\f0\fs" & Round(RTF.Font.Size * 2) & " "

CreateHeader = H1 & vbCrLf & ColorH & vbCrLf & H2

End Function

' ##############################
' Conver Long Color To RTF Color
' This Code I'm Copy From Author Reboot
' ##############################
Private Function ConverColorToRTF(LongColor As Long) As String

    Dim ColorRTFCode As String
    Dim lc As Long
    
    lc = LongColor And &H10000FF
    ColorRTFCode = ";\red" & lc
    lc = (LongColor And &H100FF00) / (2 ^ 8)
    ColorRTFCode = ColorRTFCode & "\green" & lc
    lc = (LongColor And &H1FF0000) / (2 ^ 16)
    ColorRTFCode = ColorRTFCode & "\blue" & lc
    ColorRTFCode = ColorRTFCode & ""
    
    ' Return Var
    ConverColorToRTF = ColorRTFCode
    
End Function
