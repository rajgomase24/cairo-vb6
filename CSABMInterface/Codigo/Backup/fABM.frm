VERSION 5.00
Object = "{353A8433-36B8-422E-ABBD-36CEE8BE628E}#1.0#0"; "CSButton.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{AB350268-0AA3-445C-8F38-C22EB727290F}#1.0#0"; "CSHelp2.ocx"
Object = "{F7BB685C-0860-4FD1-A9CF-22277199D7A5}#1.0#0"; "CSMaskEdit2.ocx"
Object = "{059DDBAF-ED7D-4789-A31E-638692EFCEA2}#1.0#0"; "CSGridAdvanced2.ocx"
Begin VB.Form fABM 
   ClientHeight    =   4905
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8520
   Icon            =   "fABM.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   4905
   ScaleWidth      =   8520
   Begin VB.ComboBox CB 
      Height          =   315
      Index           =   0
      Left            =   1710
      Style           =   2  'Dropdown List
      TabIndex        =   24
      Top             =   2835
      Visible         =   0   'False
      Width           =   2265
   End
   Begin CSMaskEdit2.cMultiLine TXM 
      Height          =   285
      Index           =   0
      Left            =   4725
      TabIndex        =   21
      Top             =   3300
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   503
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      MultiLine       =   -1  'True
      EnabledNoChngBkColor=   0   'False
      Text            =   ""
      BorderType      =   1
   End
   Begin CSHelp2.cHelp HL 
      Height          =   315
      Index           =   0
      Left            =   1620
      TabIndex        =   19
      Top             =   1080
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   556
      BorderType      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin VB.Timer tmUtil 
      Left            =   4680
      Top             =   720
   End
   Begin CSButton.cButtonLigth cmdDocs 
      Height          =   375
      Left            =   7260
      TabIndex        =   17
      ToolTipText     =   "Asociar archivos"
      Top             =   60
      Width           =   315
      _ExtentX        =   556
      _ExtentY        =   661
      Caption         =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      BackColor       =   -2147483643
      Picture         =   "fABM.frx":058A
      BackColorPressed=   -2147483643
      BackColorUnpressed=   -2147483643
   End
   Begin VB.Frame FR 
      BackColor       =   &H80000014&
      BorderStyle     =   0  'None
      Height          =   555
      Index           =   0
      Left            =   4680
      TabIndex        =   5
      Top             =   990
      Visible         =   0   'False
      Width           =   1185
      Begin VB.OptionButton OP 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000014&
         ForeColor       =   &H80000008&
         Height          =   330
         Index           =   0
         Left            =   45
         TabIndex        =   6
         Top             =   135
         Visible         =   0   'False
         Width           =   960
      End
   End
   Begin VB.CheckBox CHK 
      Appearance      =   0  'Flat
      BackColor       =   &H80000014&
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1755
      TabIndex        =   4
      Top             =   2475
      Visible         =   0   'False
      Width           =   2265
   End
   Begin CSMaskEdit2.cMaskEdit ME 
      Height          =   285
      Index           =   0
      Left            =   1620
      TabIndex        =   3
      Top             =   1620
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   503
      Alignment       =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      EnabledNoChngBkColor=   0   'False
      Text            =   "$ 0.00"
      BorderType      =   1
      csNotRaiseError =   -1  'True
      ButtonStyle     =   0
   End
   Begin CSButton.cButton cmdCancel 
      Height          =   330
      Left            =   4995
      TabIndex        =   1
      Top             =   4500
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   582
      Caption         =   "&Descartar cambios"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin CSButton.cButton cmdSave 
      Height          =   330
      Left            =   3600
      TabIndex        =   2
      Top             =   4500
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   582
      Caption         =   "&Guardar"
      Style           =   3
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin CSButton.cButton cbTab 
      Height          =   330
      Index           =   0
      Left            =   0
      TabIndex        =   8
      Top             =   540
      Visible         =   0   'False
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   582
      Caption         =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      TabButton       =   -1  'True
      TabSelected     =   -1  'True
      BackColor       =   -2147483643
      BackColorPressed=   -2147483643
   End
   Begin CSButton.cButton cmdClose 
      Height          =   330
      Left            =   7380
      TabIndex        =   9
      Top             =   4500
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   582
      Caption         =   "&Cerrar"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin CSMaskEdit2.cMaskEdit MEFE 
      Height          =   285
      Index           =   0
      Left            =   4725
      TabIndex        =   10
      Top             =   2160
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   503
      Alignment       =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      EnabledNoChngBkColor=   0   'False
      Text            =   "$ 0.00"
      BorderType      =   1
      csNotRaiseError =   -1  'True
      ButtonStyle     =   0
   End
   Begin CSMaskEdit2.cMaskEdit txPassword 
      Height          =   285
      Index           =   0
      Left            =   4725
      TabIndex        =   11
      Top             =   1800
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   503
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      PasswordChar    =   "*"
      EnabledNoChngBkColor=   0   'False
      Text            =   ""
      csType          =   5
      BorderType      =   1
      csNotRaiseError =   -1  'True
      ButtonStyle     =   0
   End
   Begin CSMaskEdit2.cMaskEdit TX 
      Height          =   285
      Index           =   0
      Left            =   4725
      TabIndex        =   12
      Top             =   2520
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   503
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      PasswordChar    =   "*"
      EnabledNoChngBkColor=   0   'False
      Text            =   ""
      csType          =   5
      BorderType      =   1
      csNotRaiseError =   -1  'True
      ButtonStyle     =   0
   End
   Begin CSButton.cButton CMD 
      Height          =   330
      Index           =   0
      Left            =   4725
      TabIndex        =   13
      Top             =   2880
      Visible         =   0   'False
      Width           =   2265
      _ExtentX        =   3995
      _ExtentY        =   582
      Caption         =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin CSButton.cButton cmdNew 
      Height          =   330
      Left            =   120
      TabIndex        =   15
      Top             =   4500
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   582
      Caption         =   "&Nuevo"
      Style           =   4
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin CSButton.cButton cmdCopy 
      Height          =   330
      Left            =   1500
      TabIndex        =   16
      Top             =   4500
      Width           =   1320
      _ExtentX        =   2328
      _ExtentY        =   582
      Caption         =   "&Duplicar"
      Style           =   5
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
   End
   Begin CSGridAdvanced2.cGridAdvanced GR 
      Height          =   3015
      Index           =   0
      Left            =   7080
      TabIndex        =   20
      Top             =   1080
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   5318
   End
   Begin MSComctlLib.ProgressBar prgBar 
      Height          =   285
      Index           =   0
      Left            =   1620
      TabIndex        =   22
      Top             =   3300
      Visible         =   0   'False
      Width           =   2400
      _ExtentX        =   4233
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      Scrolling       =   1
   End
   Begin CSButton.cButtonLigth cmdPrint 
      Height          =   375
      Left            =   7620
      TabIndex        =   23
      ToolTipText     =   "Asociar archivos"
      Top             =   60
      Width           =   315
      _ExtentX        =   556
      _ExtentY        =   661
      Caption         =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontName        =   "MS Sans Serif"
      FontSize        =   8.25
      BackColor       =   -2147483643
      Picture         =   "fABM.frx":06E4
      BackColorPressed=   -2147483643
      BackColorUnpressed=   -2147483643
   End
   Begin VB.Label LB2 
      BackStyle       =   0  'Transparent
      Caption         =   "pirulo en pirulo por pirulo"
      Height          =   420
      Index           =   0
      Left            =   360
      TabIndex        =   18
      Top             =   2040
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Image Img 
      Height          =   375
      Index           =   0
      Left            =   900
      Top             =   3600
      Visible         =   0   'False
      Width           =   555
   End
   Begin VB.Label lbTitleEx2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   3645
      TabIndex        =   14
      Top             =   45
      Width           =   75
   End
   Begin VB.Label LB 
      Caption         =   "pirulo en pirulo por pirulo"
      ForeColor       =   &H80000008&
      Height          =   420
      Index           =   0
      Left            =   360
      TabIndex        =   7
      Top             =   1035
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Line Line2 
      BorderColor     =   &H8000000E&
      X1              =   135
      X2              =   6660
      Y1              =   4380
      Y2              =   4380
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000010&
      X1              =   135
      X2              =   6660
      Y1              =   4365
      Y2              =   4365
   End
   Begin VB.Image Image1 
      Height          =   480
      Left            =   90
      Picture         =   "fABM.frx":0C7E
      Top             =   0
      Width           =   480
   End
   Begin VB.Label lbTitle 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tercero"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   330
      Left            =   720
      TabIndex        =   0
      Top             =   45
      Width           =   1005
   End
   Begin VB.Shape shTitle 
      BackStyle       =   1  'Opaque
      BorderStyle     =   0  'Transparent
      Height          =   510
      Left            =   -45
      Top             =   0
      Width           =   6975
   End
   Begin VB.Shape ShTab 
      BackStyle       =   1  'Opaque
      BorderColor     =   &H8000000C&
      Height          =   3390
      Left            =   90
      Top             =   855
      Width           =   8340
   End
   Begin VB.Menu popGrid 
      Caption         =   "popGrid"
      Visible         =   0   'False
      Begin VB.Menu popGridGroup 
         Caption         =   "&Agrupar..."
      End
      Begin VB.Menu popGridSep1 
         Caption         =   "-"
      End
      Begin VB.Menu popGridExportToExcel 
         Caption         =   "&Exportar a Excel..."
      End
   End
End
Attribute VB_Name = "fABM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'--------------------------------------------------------------------------------
' fABM
' 14-01-01

'--------------------------------------------------------------------------------
' notas:

'--------------------------------------------------------------------------------
' api win32
    ' constantes
    ' estructuras
    ' funciones
'--------------------------------------------------------------------------------

' constantes
Private Const C_Module = "fABM"

Private Const c_tm_use_save = 1
Private Const c_tm_use_unload = 2

' estructuras
Private Type T_GridInfo
  GridObj             As Object
  OriginalHeight      As Long
  OriginalWidth       As Long
  OriginalTop         As Long
  OriginalLeft        As Long
  TabIndex            As Long
  bDontRemove         As Boolean
  bDontResize         As Boolean
  bDontResizeHeight   As Boolean
End Type

' variables privadas
Private m_oldCB()       As String
'Private m_oldCBhock()   As String
Private m_oldME()       As String
Private m_oldMEFE()     As String
Private m_oldOP()       As String
Private m_oldTXM()      As String
Private m_oldTX()       As String
Private m_oldTXPassword() As String
Private m_WasActivated    As Boolean

Private m_OriginalShapeBottom       As Integer
Private m_OriginalButtonsBottom     As Integer
Private m_OriginalLinesBottom       As Integer

Private m_SetFocusInActivate   As Boolean

' Controles
Private WithEvents m_Toolbar  As Toolbar
Attribute m_Toolbar.VB_VarHelpID = -1
Private m_ToolBars            As Collection
Private m_FramesToolBar       As Collection
Private m_NextToolBar         As Integer
Private m_NextFrameToolBar    As Integer

Private m_ActiveGrid          As cGridAdvanced
Private m_vGridInfo()         As T_GridInfo

Private m_DontMoveGenericButton As Boolean

Private m_tmUse             As Long
Private m_bUnloadInternal   As Boolean
Private m_bSaving           As Boolean

' eventos
Public Event CBChange(ByVal Index As Integer)
'Public Event CBhockChange(ByVal Index As Integer)
Public Event CHKClick(ByVal Index As Integer)
Public Event cmdCancelClick()
Public Event cmdSaveClick()
Public Event cmdCloseClick()
Public Event cmdCopyClick()
Public Event cmdNewClick()
Public Event cmdDocsClick()
Public Event cmdPrintClick()

Public Event HLChange(ByVal Index As Integer)
Public Event MEChange(ByVal Index As Integer)
Public Event MEDateChange(ByVal Index As Integer)
Public Event OPClick(ByVal Index As Integer)
Public Event TXMChange(ByVal Index As Integer)
Public Event TXChange(ByVal Index As Integer)
Public Event TXButtonClick(Index As Integer, Cancel As Boolean)
Public Event TXPasswordChange(ByVal Index As Integer)
Public Event FormUnload(ByRef Cancel As Integer)
Public Event FormQueryUnload(ByRef Cancel As Integer, ByVal UnloadMode As Integer)
Public Event FormLoad()
Public Event cbTabClick(ByVal Index As Integer)
Public Event CMDClick(ByVal Index As Integer)

Public Event ToolBarButtonClick(ByVal Button As MSComctlLib.Button)

Public Event GRColumnAfterEdit(ByVal Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal NewValue As Variant, ByVal NewValueID As Long, ByRef bCancel As Boolean)
Public Event GRColumnAfterUpdate(ByVal Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal NewValue As Variant, ByVal NewValueID As Long)
Public Event GRColumnBeforeEdit(ByVal Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal iKeyAscii As Integer, ByRef bCancel As Boolean)

Public Event GRClick(ByVal Index As Integer)
Public Event GRDblClick(ByVal Index As Integer, ByVal RowIndex As Long, ByVal ColIndex As Long)
Public Event GRValidateRow(ByVal Index As Integer, ByVal RowIndex As Long, ByRef bCancel As Boolean)
Public Event GRNewRow(ByVal Index As Integer, ByVal RowIndex As Long)
Public Event GRDeleteRow(Index As Integer, ByVal lRow As Long, bCancel As Boolean)
Public Event GRRowWasDeleted(ByVal Index As Integer, ByVal RowIndex As Long)
Public Event GRSelectionChange(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
Public Event GRSelectionColChange(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
Public Event GRSelectionRowChange(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
Public Event GRColumnButtonClick(Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal iKeyAscii As Integer, bCancel As Boolean)

Public Event ShowHelp()

' propiedades publicas
Public ABMObject As Object

Public Property Let Loading(ByVal RHS As Boolean)
End Property

Public Property Let DontMoveGenericButton(ByVal RHS As Boolean)
  m_DontMoveGenericButton = RHS
End Property

' propiedades privadas
' funciones publicas
Public Function CtrlKeySave() As Boolean
  cmdSave_Click
  CtrlKeySave = True
End Function

Public Function CtrlKeyNew() As Boolean
  cmdNew_Click
  CtrlKeyNew = True
End Function

Public Function CtrlKeyCopy() As Boolean
  cmdCopy_Click
  CtrlKeyCopy = True
End Function

Public Function CtrlKeyRefresh() As Boolean
  cmdCancel_Click
  CtrlKeyRefresh = True
End Function

Public Function CtrlKeyClose() As Boolean
  cmdClose_Click
  CtrlKeyClose = True
End Function

Public Function CtrlKeyPrint() As Boolean
  cmdPrint_Click
  CtrlKeyPrint = True
End Function

Public Function CtrlKeyHelp() As Boolean
  RaiseEvent ShowHelp
  CtrlKeyHelp = True
End Function

Public Function GetToolBar() As Toolbar
  Set GetToolBar = m_Toolbar
End Function

Public Sub UnLoadToolbar()
  Dim o As Control
  
  With Me.Controls
    For Each o In m_ToolBars
      .Remove o
    Next
    For Each o In m_FramesToolBar
      .Remove o
    Next
  End With
  
  CollClear m_FramesToolBar
  CollClear m_ToolBars
End Sub

Public Sub SetToolbar(ByRef Tbl As Toolbar)
  Set m_Toolbar = Tbl
End Sub

Public Function LoadToolbar(ByRef frToolBar As Frame) As Toolbar
  Dim f As Frame
  Dim t As Toolbar
  
  With Me.Controls
    Set f = .Add("VB.Frame", pGetFrameToolBarName)
    m_FramesToolBar.Add f
    Set t = .Add("MSComctlLib.Toolbar", pGetToolBarName, f)
    m_ToolBars.Add t
  End With
  
  Set frToolBar = f
  Set LoadToolbar = t
End Function

Public Sub SetFocusFirstControl()
  If Me.Visible Then
    SetFocusFirstCtrlAux
  Else
    m_SetFocusInActivate = True
  End If
End Sub

Public Sub ShowForm()
  pCreateGridVector
End Sub

Public Property Let SetDontResize(ByVal Index As Long, ByVal RHS As Boolean)
  If UBound(m_vGridInfo) < Index Then Exit Property
  m_vGridInfo(Index).bDontResize = RHS
End Property

Public Sub FirstResize()
  Form_Resize
End Sub

Public Sub SetSaved()
  m_bSaving = False
End Sub

' funciones privadas
Private Function SetFocusFirstCtrlAux()
  On Error Resume Next
  
  Dim c       As Control
  Dim n       As Long
  Dim TabIdx  As Long
  
  TabIdx = 0
  Do
    For Each c In Me.Controls
    
      With c
        Err.Clear
        If .Name <> "cbTab" Then
          If Err.Number = 0 Then
            If Not TypeOf c Is Timer Then
              If .TabIndex = TabIdx And Not (TypeOf c Is Label) Then
                If Err.Number = 0 Then
                  If Not TypeOf c Is OptionButton Then .SetFocus
                  If Err.Number = 0 Then
                    Exit Function
                  End If
                  Exit For
                Else
                  Err.Clear
                End If
              End If
            End If
          End If
        End If
      End With
    Next
    TabIdx = TabIdx + 1
    n = n + 1
  Loop Until n = Me.Controls.Count
End Function

Private Sub CB_Click(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldCB) < Index Then ReDim Preserve m_oldCB(Index)
  RaiseEvent CBChange(Index)
  m_oldCB(Index) = CB(Index).Text
ControlError:
End Sub
Private Sub CB_GotFocus(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldCB) < Index Then ReDim Preserve m_oldCB(Index)
  m_oldCB(Index) = CB(Index).Text
ControlError:
End Sub
Private Sub CB_LostFocus(Index As Integer)
  If m_oldCB(Index) = CB(Index).Text Then Exit Sub
  RaiseEvent CBChange(Index)
End Sub

'Private Sub CBhock_GotFocus(Index As Integer)
'  On Error GoTo ControlError
'  If UBound(m_oldCBhock) < Index Then ReDim Preserve m_oldCBhock(Index)
'  m_oldCBhock(Index) = CBhock(Index).Text
'ControlError:
'End Sub
'Private Sub CBhock_LostFocus(Index As Integer)
'  If m_oldCBhock(Index) = CBhock(Index).Text Then Exit Sub
'  RaiseEvent CBhockChange(Index)
'ControlError:
'End Sub

Private Sub cbTab_Click(Index As Integer)
  RaiseEvent cbTabClick(Index)
End Sub

Private Sub CHK_Click(Index As Integer)
  RaiseEvent CHKClick(Index)
End Sub

Private Sub CMD_Click(Index As Integer)
  RaiseEvent CMDClick(Index)
End Sub

Private Sub cmdCancel_Click()
  If cmdCancel.Enabled Then
    Set m_ActiveGrid = Nothing
    ReDim m_vGridInfo(0)
    RaiseEvent cmdCancelClick
    pCreateGridVector
    Form_Resize
  End If
End Sub

Private Sub cmdClose_Click()
  If cmdClose.Enabled Then
    RaiseEvent cmdCloseClick
  End If
End Sub

Private Sub cmdCopy_Click()
  If cmdCopy.Enabled Then
    RaiseEvent cmdCopyClick
  End If
End Sub

Private Sub cmdDocs_Click()
  If cmdDocs.Enabled Then
    RaiseEvent cmdDocsClick
  End If
End Sub

Private Sub cmdNew_Click()
  If cmdNew.Enabled Then
    RaiseEvent cmdNewClick
  End If
End Sub

Private Sub cmdPrint_Click()
  If cmdPrint.Enabled Then
    RaiseEvent cmdPrintClick
  End If
End Sub

Private Sub cmdSave_Click()
  On Error Resume Next
  If cmdSave.Enabled Then
    cmdSave.SetFocus
    DoEvents
    pSaving True
    m_tmUse = c_tm_use_save
    tmUtil.Interval = 500
  End If
End Sub

Private Sub Form_Activate()
  
  If m_SetFocusInActivate Then
    SetFocusFirstCtrlAux
    m_SetFocusInActivate = False
  End If
  
  If m_WasActivated Then Exit Sub
  m_WasActivated = True
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
  ProcessVirtualKey KeyCode, Shift, Me
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)

  ' Si esta guardando no le permito
  ' cerrar el formulario, (esto se puede dar por una
  ' rapida convinacion de ctrl+g y ctrl+s)
  '
  If m_bSaving Then
    Cancel = True
    Exit Sub
  End If

  ' Si esta llamada se produce
  ' por el codigo de esta ventana
  ' ya no hay forma de evitar el unload
  '
  If Not m_bUnloadInternal Then
    
    ' Damos una chance al usuario de evitar
    ' el unload
    '
    RaiseEvent FormQueryUnload(Cancel, UnloadMode)
    
    ' Si decidio cancelar el form no se descarga
    '
    If Cancel Then
      gUnloadCancel = True
    
    ' Si el usuario no cancela el unload, nosotros
    ' lo frenamos por 1/2 segundo (el interval de tmUtil)
    ' para evitar el fatidico error
    '     "The object invoked has disconnected from its clients"
    '
    Else
    
      ' Solo podemos hacer esto si no hizo click
      ' en el boton control box de la ventana
      ' (la x) - Por ende solo nos hacemos cargo
      ' cuando el unload se genero por una llamada
      ' al metodo unload, normalmente por capturar
      ' el boton escape o el boton cerrar
      '
      If UnloadMode = vbFormCode Then
    
        Cancel = True
        m_tmUse = c_tm_use_unload
        cmdCopy.Enabled = False
        cmdNew.Enabled = False
        cmdCancel.Enabled = False
        cmdClose.Enabled = False
        cmdSave.Enabled = False
        tmUtil.Interval = 500
      End If
    End If
  End If
End Sub

Private Sub GR_ColumnAfterEdit(Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal NewValue As Variant, ByVal NewValueID As Long, bCancel As Boolean)
  RaiseEvent GRColumnAfterEdit(Index, lRow, lCol, NewValue, NewValueID, bCancel)
End Sub

Private Sub GR_ColumnAfterUpdate(Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal NewValue As Variant, ByVal NewValueID As Long)
  RaiseEvent GRColumnAfterUpdate(Index, lRow, lCol, NewValue, NewValueID)
End Sub

Private Sub GR_ColumnBeforeEdit(Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal iKeyAscii As Integer, bCancel As Boolean)
  RaiseEvent GRColumnBeforeEdit(Index, lRow, lCol, iKeyAscii, bCancel)
End Sub

Private Sub GR_ColumnButtonClick(Index As Integer, ByVal lRow As Long, ByVal lCol As Long, ByVal iKeyAscii As Integer, bCancel As Boolean)
  RaiseEvent GRColumnButtonClick(Index, lRow, lCol, iKeyAscii, bCancel)
End Sub

Private Sub GR_ColumnClick(Index As Integer, ByVal lCol As Long)
  RaiseEvent GRClick(Index)
End Sub

Private Sub GR_DblClick(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
  RaiseEvent GRDblClick(Index, lRow, lCol)
End Sub

Private Sub GR_DeleteRow(Index As Integer, ByVal lRow As Long, bCancel As Boolean)
  RaiseEvent GRDeleteRow(Index, lRow, bCancel)
End Sub

Private Sub GR_RowWasDeleted(Index As Integer, ByVal lRow As Long)
  RaiseEvent GRRowWasDeleted(Index, lRow)
End Sub

Private Sub GR_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single, bDoDefault As Boolean)
  On Error Resume Next
  Set m_ActiveGrid = GR(Index)
  If Button = vbRightButton Then
    Me.PopupMenu popGrid
    bDoDefault = False
  End If
End Sub

Private Sub GR_NewRow(Index As Integer, ByVal lRow As Long)
  RaiseEvent GRNewRow(Index, lRow)
End Sub

Private Sub GR_SelectionChange(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
  RaiseEvent GRSelectionChange(Index, lRow, lCol)
End Sub

Private Sub GR_SelectionColChange(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
  RaiseEvent GRSelectionColChange(Index, lRow, lCol)
End Sub

Private Sub GR_SelectionRowChange(Index As Integer, ByVal lRow As Long, ByVal lCol As Long)
  RaiseEvent GRSelectionRowChange(Index, lRow, lCol)
End Sub

Private Sub GR_ValidateRow(Index As Integer, ByVal lRow As Long, bCancel As Boolean)
  RaiseEvent GRValidateRow(Index, lRow, bCancel)
End Sub

Private Sub HL_Change(Index As Integer)
  RaiseEvent HLChange(Index)
End Sub

Private Sub m_ToolBar_ButtonClick(ByVal Button As MSComctlLib.Button)
  RaiseEvent ToolBarButtonClick(Button)
End Sub

Private Sub ME_GotFocus(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldME) < Index Then ReDim Preserve m_oldME(Index)
  m_oldME(Index) = Me.Me(Index).csValue
ControlError:
End Sub

Private Sub ME_LostFocus(Index As Integer)
  If m_oldME(Index) = Me.Me(Index).csValue Then Exit Sub
  RaiseEvent MEChange(Index)
End Sub

Private Sub MEFE_GotFocus(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldMEFE) < Index Then ReDim Preserve m_oldMEFE(Index)
  m_oldMEFE(Index) = Me.MEFE(Index).csValue
ControlError:
End Sub

Private Sub MEFE_LostFocus(Index As Integer)
  If m_oldMEFE(Index) = Me.MEFE(Index).csValue Then Exit Sub
  RaiseEvent MEDateChange(Index)
End Sub

Private Sub OP_Click(Index As Integer)
  RaiseEvent OPClick(Index)
End Sub

Private Sub popGridExportToExcel_Click()
  On Error Resume Next
  Dim Export As cExporToExcel
  Set Export = New cExporToExcel
  
  Export.ShowDialog = True
  Export.Export dblExGridAdvanced, "", m_ActiveGrid
End Sub

Private Sub popGridGroup_Click()
  On Error Resume Next
  m_ActiveGrid.GroupColumns
End Sub

Private Sub tmUtil_Timer()
  On Error Resume Next
  
  ' Lo primero es desactivar el timer
  '
  tmUtil.Interval = 0
  
  ' Si se esta usando para guardar
  '
  If m_tmUse = c_tm_use_save Then
    RaiseEvent cmdSaveClick
    pSaving False
    Form_Resize
  
    ' Esto es para evitar una descarga del
    ' form por un mal manejo de errores
    '
    Err.Clear
    Exit Sub
  
  ' Si se esta usando para descargar el form
  '
  ElseIf m_tmUse = c_tm_use_unload Then
  
    m_bUnloadInternal = True
    
    pUnloadGridAdvanced
    
    Unload Me
  
    ' Para no dejar el objeto error cargado
    '
    Err.Clear
  End If
End Sub

Private Sub pUnloadGridAdvanced()
  On Error Resume Next
  Dim i As Long
  For i = GR.LBound To GR.UBound
    GR.Item(i).Unloaded = True
  Next
  Err.Clear
End Sub

Private Sub TXM_GotFocus(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldTXM) < Index Then ReDim Preserve m_oldTXM(Index)
  m_oldTXM(Index) = TXM(Index).Text
ControlError:
End Sub

Private Sub TXM_LostFocus(Index As Integer)
  On Error GoTo ControlError
  If m_oldTXM(Index) = TXM(Index).Text Then Exit Sub
  RaiseEvent TXMChange(Index)
ControlError:
End Sub

Private Sub TX_ButtonClick(Index As Integer, Cancel As Boolean)
  RaiseEvent TXButtonClick(Index, Cancel)
End Sub

Private Sub TX_GotFocus(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldTX) < Index Then ReDim Preserve m_oldTX(Index)
  m_oldTX(Index) = TX(Index).Text
ControlError:
End Sub

Private Sub TX_ReturnFromHelp(Index As Integer)
  On Error Resume Next
  If m_oldTX(Index) = TX(Index).Text Then Exit Sub
  RaiseEvent TXChange(Index)
  m_oldTX(Index) = TX(Index).Text
End Sub

Private Sub TXPassword_GotFocus(Index As Integer)
  On Error GoTo ControlError
  If UBound(m_oldTXPassword) < Index Then ReDim Preserve m_oldTXPassword(Index)
  m_oldTXPassword(Index) = TXPassword(Index).Text
ControlError:
End Sub

Private Sub TX_LostFocus(Index As Integer)
  On Error GoTo ControlError
  If m_oldTX(Index) = TX(Index).Text Then Exit Sub
  RaiseEvent TXChange(Index)
ControlError:
End Sub

Private Sub TXPassword_LostFocus(Index As Integer)
  If m_oldTXPassword(Index) = TXPassword(Index).Text Then Exit Sub
  RaiseEvent TXPasswordChange(Index)
End Sub

Private Sub Form_Resize()
  On Error Resume Next

  If WindowState = vbMinimized Then Exit Sub
  
  shTitle.Move 0, 0, ScaleWidth
  
  With Line1
    .Y1 = Me.ScaleHeight - m_OriginalLinesBottom
    .Y2 = .Y1
    Line2.Y1 = .Y1 + 10
    Line2.Y2 = Line2.Y1
    
    .X1 = 0
    .X2 = ScaleWidth
    Line2.X1 = 0
    Line2.X2 = ScaleWidth
  End With
  
  With ShTab
    .Height = ScaleHeight - .Top - m_OriginalShapeBottom
    .Width = Me.ScaleWidth - .Left * 2
  End With
  
  With cmdClose
    .Top = Me.ScaleHeight - m_OriginalButtonsBottom - cmdCancel.Height
    cmdCopy.Top = .Top
    cmdNew.Top = .Top
    If Not m_DontMoveGenericButton Then
      cmdSave.Top = .Top
      cmdCancel.Top = .Top
    End If
  
    .Left = ScaleWidth - 480 - .Width
    If cmdPrint.Visible Then
      cmdDocs.Left = ScaleWidth - cmdDocs.Width - cmdPrint.Width - 250
      cmdPrint.Left = ScaleWidth - cmdPrint.Width - 200
    Else
      cmdDocs.Left = ScaleWidth - cmdDocs.Width - 200
    End If
    If Not m_DontMoveGenericButton Then
      cmdCancel.Left = .Left - cmdCancel.Width - 250
      cmdSave.Left = cmdCancel.Left - cmdSave.Width - 80
    End If
  End With
  
  Dim ctl As Control
  
  For Each ctl In Controls
    If TypeOf ctl Is cGridAdvanced Then
    
      With ctl
        If Not pInGridInfo(ctl) Then
          .Height = ScaleHeight - .Top - m_OriginalShapeBottom - 100
          If .Left < 3000 Then
            .Width = Me.ScaleWidth - .Left * 2
          Else
            .Width = Me.ScaleWidth - .Left - 300
          End If
        Else
          With pGetGridInfo(ctl)
            If Not .bDontResize Then
              ctl.Width = Me.ScaleWidth - ctl.Left * 2
            End If
            If Not .bDontResizeHeight Then
              ctl.Height = ScaleHeight - ctl.Top - m_OriginalShapeBottom - 100
            End If
          End With
        End If
      End With
    End If
  Next
End Sub

Private Function pGetFrameToolBarName() As String
  pGetFrameToolBarName = "FrameToolBar" & m_NextFrameToolBar
  m_NextFrameToolBar = m_NextFrameToolBar + 1
End Function

Private Function pGetToolBarName() As String
  pGetToolBarName = "ToolBar" & m_NextToolBar
  m_NextToolBar = m_NextToolBar + 1
End Function

Private Sub pSaving(ByVal bSaving As Boolean)
  Dim Enabled As Boolean
  m_bSaving = bSaving
  Enabled = Not bSaving
  cmdCopy.Enabled = Enabled
  cmdNew.Enabled = Enabled
  cmdCancel.Enabled = Enabled
  cmdClose.Enabled = Enabled
  cmdSave.Enabled = Enabled
End Sub

Private Function pInGridInfo(ByVal ctl As Control) As Boolean
  pInGridInfo = pGetGridInfoIndex(ctl)
End Function

Private Function pGetGridInfo(ByVal ctl As Control) As T_GridInfo
  Dim i As Long
  i = pGetGridInfoIndex(ctl)
  pGetGridInfo = m_vGridInfo(i)
End Function

Private Function pGetGridInfoIndex(ByVal ctl As Control) As Long
  Dim i As Long
  For i = 1 To UBound(m_vGridInfo)
    If m_vGridInfo(i).GridObj Is ctl Then
      pGetGridInfoIndex = i
      Exit Function
    End If
  Next
End Function

Private Sub pCreateGridVector()
  On Error GoTo ControlError

  Dim ctl       As Control
  Dim i         As Long
  Dim j         As Long
  Dim bFound    As Boolean
  
  ReDim m_vGridInfo(0)
  
  For Each ctl In Controls
    If TypeOf ctl Is cGridAdvanced Then
      ReDim Preserve m_vGridInfo(UBound(m_vGridInfo) + 1)
      With m_vGridInfo(UBound(m_vGridInfo))
        Set .GridObj = ctl
        .OriginalHeight = ctl.Height
        .OriginalLeft = ctl.Left
        .OriginalTop = ctl.Top
        .OriginalWidth = ctl.Width
        .TabIndex = Val(ctl.Tag)
      End With
    End If
  Next
  
  Dim TabIndex As Long
  
  For i = 1 To UBound(m_vGridInfo) - 1
    If Not m_vGridInfo(i).bDontRemove Then
      TabIndex = m_vGridInfo(i).TabIndex
      For j = i + 1 To UBound(m_vGridInfo)
        If TabIndex = m_vGridInfo(j).TabIndex Then
          With m_vGridInfo(i)
            .bDontRemove = True
            .bDontResizeHeight = True
          End With
          With m_vGridInfo(j)
            .bDontRemove = True
            .bDontResizeHeight = True
          End With
        End If
      Next
    End If
  Next
  
  Dim vGridInfo() As T_GridInfo
  
  ReDim vGridInfo(0)
  
  For i = 1 To UBound(m_vGridInfo)
    If m_vGridInfo(i).bDontRemove Then
      ReDim Preserve vGridInfo(UBound(vGridInfo) + 1)
      LSet vGridInfo(UBound(vGridInfo)) = m_vGridInfo(i)
    End If
  Next
  
  ReDim m_vGridInfo(0)
  m_vGridInfo = vGridInfo
  
  Dim LastGridIndex As Long
  
  For i = 1 To UBound(m_vGridInfo)
    TabIndex = m_vGridInfo(i).TabIndex
    LastGridIndex = i
    For j = i + 1 To UBound(m_vGridInfo)
      If TabIndex = m_vGridInfo(j).TabIndex Then
        LastGridIndex = j
      End If
    Next
  
    m_vGridInfo(LastGridIndex).bDontResizeHeight = False
  Next
  
  GoTo ExitProc
ControlError:
  MngError Err, "pCreateGridVector", C_Module, ""
  If Err.Number Then Resume ExitProc
ExitProc:
  On Error Resume Next
End Sub

' construccion - destruccion
Private Sub Form_Load()
  On Error GoTo ControlError
  
  ReDim m_oldCB(0)
  'ReDim m_oldCBhock(0)
  ReDim m_oldME(0)
  ReDim m_oldMEFE(0)
  ReDim m_oldOP(0)
  ReDim m_oldTX(0)
  ReDim m_oldTXM(0)
  ReDim m_oldTXPassword(0)
  ReDim m_vGridInfo(0)
    
  With Me
    
    .FR(0).BackColor = vb3DHighlight
    .OP(0).BackColor = vb3DHighlight
  
    .lbTitle.AutoSize = True
  
    Set m_FramesToolBar = New Collection
    Set m_ToolBars = New Collection
    
    m_WasActivated = False
    
    m_OriginalShapeBottom = .ScaleHeight - ShTab.Height - ShTab.Top
    m_OriginalButtonsBottom = .ScaleHeight - cmdCancel.Height - cmdCancel.Top
    m_OriginalLinesBottom = .ScaleHeight - Line1.Y1 - Line1.BorderWidth
  End With
  
  RaiseEvent FormLoad

  GoTo ExitProc
ControlError:
  MngError Err, "Form_Load", C_Module, ""
  If Err.Number Then Resume ExitProc
ExitProc:
  On Error Resume Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
  On Error Resume Next
  
  ReDim m_oldCB(0)
  'ReDim m_oldCBhock(0)
  ReDim m_oldME(0)
  ReDim m_oldMEFE(0)
  ReDim m_oldOP(0)
  ReDim m_oldTX(0)
  ReDim m_oldTXM(0)
  ReDim m_oldTXPassword(0)
  ReDim m_vGridInfo(0)
  
  Set ABMObject = Nothing
  
  Set m_FramesToolBar = Nothing
  Set m_ToolBars = Nothing
  Set m_Toolbar = Nothing
  Set m_ActiveGrid = Nothing
  
  RaiseEvent FormUnload(Cancel)
  CSKernelClient2.UnloadForm Me, "ABM_" & Me.lbTitle.Caption
  
  Set fABM = Nothing
End Sub

#If PREPROC_DEBUG Then
Private Sub Form_Initialize()
  gdbTerminateInstance C_Module
End Sub

Private Sub Form_Terminate()
  gdbInitInstance C_Module
End Sub
#End If

'//////////////////////////////
'  Codigo estandar de errores
'  On Error GoTo ControlError
'
'  GoTo ExitProc
'ControlError:
'  MngError err,"", C_Module, ""
'  If Err.Number Then Resume ExitProc
'ExitProc:
'  On Error Resume Next

