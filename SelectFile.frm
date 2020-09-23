VERSION 5.00
Begin VB.Form Form3 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SelectImageFile"
   ClientHeight    =   4410
   ClientLeft      =   1815
   ClientTop       =   2130
   ClientWidth     =   6915
   Icon            =   "SelectFile.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4410
   ScaleWidth      =   6915
   StartUpPosition =   2  'CenterScreen
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
      Pattern         =   "*.jpg;*.bmp;*.gif*;*.pic;*.ico"
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
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Preview Picture"
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   3000
      TabIndex        =   4
      Top             =   240
      Width           =   3855
   End
   Begin VB.Image Image1 
      Height          =   3615
      Left            =   2880
      Top             =   600
      Width           =   3975
   End
End
Attribute VB_Name = "Form3"
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
ChosenImageFile = File1.Path & "\" & File1.filename
Unload Me
Exit Sub
panos:
ChosenImageFile = ""
End Sub

Private Sub Dir1_Change()
File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
Dir1.Path = Drive1.Drive
End Sub

Private Sub File1_Click()
Image1.Picture = LoadPicture(File1.Path & "\" & File1.filename)
End Sub

Private Sub Form_Load()
p.Gradient Me, 0, 0, 255, 1
End Sub
