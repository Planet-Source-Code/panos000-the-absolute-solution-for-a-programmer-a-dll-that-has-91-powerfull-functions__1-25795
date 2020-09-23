VERSION 5.00
Begin VB.Form Form2 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Select Directory"
   ClientHeight    =   3240
   ClientLeft      =   6765
   ClientTop       =   2655
   ClientWidth     =   3015
   Icon            =   "SelectDir.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3240
   ScaleWidth      =   3015
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   495
      Left            =   840
      TabIndex        =   2
      Top             =   2640
      Width           =   1335
   End
   Begin VB.DirListBox Dir1 
      BackColor       =   &H00C00000&
      ForeColor       =   &H80000009&
      Height          =   1890
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
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim p As New PanosDll

Private Sub Command1_Click()
ChosenDirectory = Dir1.Path
Unload Me
End Sub

Private Sub Drive1_Change()
Dir1.Path = Drive1.Drive
End Sub

Private Sub Form_Load()
p.Gradient Me, 0, 0, 255, 1
End Sub
