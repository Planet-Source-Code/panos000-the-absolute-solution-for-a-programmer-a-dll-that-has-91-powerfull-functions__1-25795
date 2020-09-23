VERSION 5.00
Begin VB.Form Form6 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "16 Bit Pallete"
   ClientHeight    =   1350
   ClientLeft      =   3180
   ClientTop       =   3090
   ClientWidth     =   3900
   Icon            =   "Form6.frx":0000
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1350
   ScaleWidth      =   3900
   Begin VB.PictureBox ColPal 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1140
      Left            =   1560
      Picture         =   "Form6.frx":08CA
      ScaleHeight     =   1110
      ScaleWidth      =   2145
      TabIndex        =   1
      Top             =   120
      Width           =   2175
   End
   Begin VB.PictureBox Picture1 
      Height          =   1140
      Left            =   120
      ScaleHeight     =   1080
      ScaleWidth      =   1155
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "Form6"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Public ChosenColor As Long

Private Sub ColPal_Click()
ChosenColor = Picture1.BackColor
Unload Me
End Sub


Private Sub ColPal_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
  Picture1.BackColor = ColPal.Point(x, y)
End Sub


