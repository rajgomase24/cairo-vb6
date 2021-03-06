VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cProcesoCabecera2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Implements cIAFIPProceso
'--------------------------------------------------------------------------------
' cProcesoCabecera2
' 16-07-2003

'--------------------------------------------------------------------------------
' notas:

'--------------------------------------------------------------------------------
' api win32
    ' constantes
    ' estructuras
    ' funciones

'--------------------------------------------------------------------------------

' constantes
Private Const C_Module = "cProcesoCabecera2"
' estructuras
' variables privadas
Private m_ObjProc As cObjetoProceso
Private m_Campos    As cIAFIPCampos
' eventos
' propiedades publicas
Private Function cIAFIPProceso_ProcessRecord(Parametros As cIAFIPParametros, Fields As ADODB.Fields, Campos As cIAFIPCampos, ByVal IsLastRecord As Boolean, IsEmptyRecord As Boolean, ByVal lIndexRecord As Long, Esquema As cIAFIPEsquema) As Boolean
  
  If IsLastRecord Then
  
    ' Campo 4: Cantidad de registros de tipo 1
    m_Campos.Item(4).Valor = Esquema.LineCount
  
    IsEmptyRecord = Not pSetCampos(Campos, Parametros, Fields)
  
  Else
  
    ' Si m_Campos.Count = 0 estoy en el primer registro
    If m_Campos.Count = 0 Then
      
      ' Agrego el campo ID a la coleccion
      With Campos.Add(Nothing, C_ID)
        .Columna = C_ID
        .Posicion = -1
      End With
    End If
    
    If Not m_ObjProc.ProcessRecord(Parametros, Fields, Campos, IsLastRecord, IsEmptyRecord, lIndexRecord, Esquema) Then
      Esquema.Log C_Module, "Fallo al procesar el registro " & lIndexRecord, LogSevError
      Exit Function
    End If
  
    IsEmptyRecord = True
  
    ' Si m_Campos.Count = 0 estoy en el primer registro
    If m_Campos.Count = 0 Then
      pSetCampos Campos, Parametros, Fields
    Else
      pAddCampos Campos, Fields
    End If
  End If
  
  cIAFIPProceso_ProcessRecord = True
End Function
' propiedades friend
' propiedades privadas
' funciones publicas
' funciones friend
' funciones privadas
Private Function pSetCampos(ByRef rtnCampos As cIAFIPCampos, ByRef Parametros As cIAFIPParametros, ByRef Fields As ADODB.Fields) As Boolean
  Dim tmpCampos As cIAFIPCampos
  Dim rtn       As Boolean
  
  ' Si m_Campos no esta vacia es por que
  ' hay datos
  rtn = m_Campos.Count > 0

  ' Inicializo el flag de tasas iva
  Set tmpCampos = CSKernelClient2.CreateObject("CSInfoAFIP.cAFIPCampos")
  
  ' Paso de rtnCampos a TmpCampos
  CopyCampos rtnCampos, tmpCampos
  
  ' Si hay campos en m_Campos los paso a rtnCampos
  If rtn Then
    ' Paso de m_Campos a rtnCampos
    CopyCampos m_Campos, rtnCampos
  End If
  
  ' Ahora paso de TmpCampos (originalmente rtnCampos) a m_Campos
  CopyCampos tmpCampos, m_Campos
  
  ' Realizo las verificaciones a este registro como a cualquier otro
  pSetDefaults Parametros
  pAddCampos m_Campos, Fields
  
  pSetCampos = rtn
End Function

Private Sub pSetDefaults(ByRef Parametros As cIAFIPParametros)
    ' Tipo de campo
    m_Campos.Item(1).Valor = 2
    
    ' Per�odo
    ' Se deber� completar con el per�odo fiscal que se registra (AAAAMM).
    m_Campos.Item(2).Valor = GetDate(C_Param_FechaDesde, Parametros, "YYYYMM")
    
    ' CUIT del informante
    ' Se deber� completar con la CUIT del emisor de los comprobantes.
    m_Campos.Item(6).Valor = "30599012628"
    
    ' Importe total de la operacion
    m_Campos.Item(8).Valor = 0
    
    ' Campo 9: Importe total de conceptos que no integran
    '          el precio neto gravado
    m_Campos.Item(9).Valor = 0
    
    ' Campo 10: Importe neto gravado
    ' Se deber� consignar la sumatoria de los importes netos gravados
    ' correspondientes a las operaciones realizadas durante el per�odo
    ' que se informa (suma del campo 14 del registro de tipo 1).
    m_Campos.Item(10).Valor = 0
    
    ' Impuesto liquidado
    ' Se deber� consignar la sumatoria del total de los importes liquidados de IVA (suma del campo 15 del registro de tipo 1).
    m_Campos.Item(11).Valor = 0
    
    ' Impuesto liquidado a RNI o percepci�n a no categorizados
    ' Se deber� consignar la sumatoria del total de los importes liquidados de IVA en concepto de sobretasa a los RNI o a los sujetos no categorizados (suma del campo 16 del registro de tipo 1).
    m_Campos.Item(12).Valor = 0
    
    ' Importe de operaciones exentas
    ' Se deber� consignar la sumatoria del total de los importes de
    ' operaciones exentas (suma del campo 17 del registro de tipo 1).
    m_Campos.Item(13).Valor = 0
    
    ' Campo 14: Importe de percepciones o pagos a cuenta de
    ' impuestos nacionales
    ' Se deber� consignar la sumatoria del total de las
    ' percepciones o pagos a cuenta (suma del campo 18
    ' del registro de tipo 1).
    m_Campos.Item(14).Valor = 0
    
    ' Campo 15: Importe de percepci�n de ingresos brutos
    ' Se deber� consignar la sumatoria del Importe de percepci�n de
    ' ingresos brutos (suma del campo 19 del registro de tipo 1).
    m_Campos.Item(15).Valor = 0
    
    ' Campo 16: Importe de percepci�n de impuestos municipales
    ' Se deber� consignar la sumatoria del Importe de percepci�n
    ' de impuestos municipales (suma del campo 20 del registro de tipo 1).
    m_Campos.Item(16).Valor = 0
    
    ' Campo 17: Importe de impuestos internos
    ' Se deber� consignar la sumatoria del Importe de impuestos internos
    ' (suma del campo 21 del registro de tipo 1).
    m_Campos.Item(17).Valor = 0
End Sub

Private Sub pAddCampos(ByRef Campos As cIAFIPCampos, ByRef Fields As ADODB.Fields)
  ' Solo pongo los valores que me interesan
  ' En SetCampos se guardan los valores comunes
  ' a todos los registros
  
  If Not Fields Is Nothing Then
  
    Dim cpt As String
    Dim c As String
    
    cpt = Left(ValField(Fields, ("CODCPT")), 3)
    c = Left$(cpt, 1)
    
    ' Importe total de la operaci�n
    ' Se consignar� el importe total de las operaciones
    ' efectuadas durante el per�odo informado. Deber� ser
    ' igual a la sumatoria del campo hom�nimo de la totalidad
    ' de los registros de tipo 1 (suma del campo 12 del
    ' registro de tipo 1).
    If c = "T" Then
      With m_Campos.Item(8)
        .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
      End With
      
      ' Importe de operaciones exentas
      ' Se deber� consignar la sumatoria del total de los importes de
      ' operaciones exentas (suma del campo 17 del registro de tipo 1).
      If AFIPEsOperacionExenta(Fields) Then
        With m_Campos.Item(13)
          .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
        End With
      End If
  
    ' Impuesto liquidado
    ' Se deber� consignar la sumatoria del total de los importes liquidados de IVA (suma del campo 15 del registro de tipo 1).
    ' IMPORT Conceptos de tipo I01
    ElseIf cpt = "I01" Or cpt = "A27" Then
      With m_Campos.Item(11)
        .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
      End With

    ' Impuesto liquidado a RNI o percepci�n a no categorizados
    ' Se deber� consignar la sumatoria del total de los importes liquidados de IVA en concepto de sobretasa a los RNI o a los sujetos no categorizados (suma del campo 16 del registro de tipo 1).
    ' IMPORT Conceptos de tipo I02
    ElseIf cpt = "I02" Then
      With m_Campos.Item(12)
        .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
      End With
  
    ' Campo 15: Importe de percepci�n de ingresos brutos
    ' Se deber� consignar la sumatoria del Importe de percepci�n de
    ' ingresos brutos (suma del campo 19 del registro de tipo 1).
    ' IMPORT Conceptos de tipo J01 y J02
    ElseIf cpt = "J01" Or cpt = "J02" Then
      With m_Campos.Item(15)
        .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
      End With
    
    ' Si no es de tipo A o D no es un concepto exento.
    ElseIf c = "A" Or c = "D" Then

      If AFIPGetEsConceptoExento(cpt, False) Then
        ' Campo 9: Importe total de conceptos que no integran
        '          el precio neto gravado
        ' Se proceder� a informar la sumatoria de los importes
        ' que no integren el hecho imponible, el cual podr� ser
        ' cero (suma del campo 13 del registro de tipo 1).
        With m_Campos.Item(9)
          .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
        End With
      Else
        ' Campo 10: Importe neto gravado
        ' Se deber� consignar la sumatoria de los importes netos gravados
        ' correspondientes a las operaciones realizadas durante el per�odo
        ' que se informa (suma del campo 14 del registro de tipo 1).
        With m_Campos.Item(10)
          .Valor = CDbl(.Valor) + CDbl(ValField(Fields, "IMPORT"))
        End With
      End If
    
    End If
  End If
End Sub
' construccion - destruccion
Private Sub Class_Initialize()
  On Error GoTo ControlError
  
  Set m_ObjProc = New cObjetoProceso
  Set m_Campos = CSKernelClient2.CreateObject("CSInfoAFIP.cAFIPCampos")
  
  GoTo ExitProc
ControlError:
  MngError Err, "Class_Initialize", C_Module, ""
  If Err.Number <> 0 Then Resume ExitProc
ExitProc:
  On Error Resume Next
End Sub

Private Sub Class_Terminate()
  On Error GoTo ControlError

  Set m_ObjProc = Nothing
  Set m_Campos = Nothing
  
  GoTo ExitProc
ControlError:
  MngError Err, "Class_Terminate", C_Module, ""
  If Err.Number <> 0 Then Resume ExitProc
ExitProc:
  On Error Resume Next
End Sub

'//////////////////////////////
'  Codigo estandar de errores
'  On Error GoTo ControlError
'
'  GoTo ExitProc
'ControlError:
'  MngError err,"", C_Module, ""
'  If Err.Number <> 0 Then Resume ExitProc
'ExitProc:
'  On Error Resume Next




