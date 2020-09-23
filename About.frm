VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H00C00000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About"
   ClientHeight    =   1065
   ClientLeft      =   3630
   ClientTop       =   2955
   ClientWidth     =   4440
   Icon            =   "About.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1065
   ScaleWidth      =   4440
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "PanosDll was created by Charitakis Panagiotis For Visual Basic e-mail: panos000@yahoo.com"
      ForeColor       =   &H8000000E&
      Height          =   495
      Left            =   840
      TabIndex        =   0
      Top             =   360
      Width           =   3375
   End
   Begin VB.Image Image1 
      Height          =   480
      Left            =   240
      Picture         =   "About.frx":030A
      Top             =   360
      Width           =   480
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H00FFFFFF&
      Height          =   855
      Left            =   120
      Top             =   120
      Width           =   4215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim p As New PanosDll

Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Form_Load()
p.Gradient Me, 0, 0, 255, 1
End Sub
