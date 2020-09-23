VERSION 5.00
Begin VB.Form Form5 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SelectFile"
   ClientHeight    =   4410
   ClientLeft      =   3945
   ClientTop       =   2130
   ClientWidth     =   3045
   Icon            =   "SelectFile1.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4410
   ScaleWidth      =   3045
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   495
      Left            =   960
      TabIndex        =   3
      Top             =   3840
      Width           =   1215
   End
   Begin VB.FileListBox File1 
      BackColor       =   &H00C00000&
      ForeColor       =   &H80000009&
      Height          =   1260
      Left            =   240
      TabIndex        =   2
      Top             =   2400
      Width           =   2535
   End
   Begin VB.DirListBox Dir1 
      BackColor       =   &H00C00000&
      ForeColor       =   &H80000009&
      Height          =   1665
      Left            =   240
      TabIndex        =   1
      Top             =   600
      Width           =   2535
   End
   Begin VB.DriveListBox Drive1 
      BackColor       =   &H00C00000&
      ForeColor       =   &H80000009&
      Height          =   315
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   2535
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim p As New PanosDll

Private Sub Command1_Click()
On Error GoTo panos
If File1.ListIndex = -1 Then
MsgBox "Please Choose a file from the list", vbExclamation, App.Title
Exit Sub
End If
ChosenFile = File1.Path & "\" & File1.filename
Unload Me
Exit Sub
panos:
ChosenFile = ""
End Sub

Private Sub Dir1_Change()
File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
Dir1.Path = Drive1.Drive
End Sub


Private Sub Form_Load()
p.Gradient Me, 0, 0, 255, 1
End Sub
