VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "c_ManagementGDZS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'�����-������� ��� ���� ����� ����

'Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
'Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
'Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
'Private Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long

#If VBA7 Then
    Public FormHandle As LongPtr
    Private Declare PtrSafe Function FindWindow Lib "user32" Alias "FindWindowA" ( _
                    ByVal lpClassName As String, _
                    ByVal lpWindowName As String) As LongPtr
    Private Declare PtrSafe Function SetWindowLong Lib "user32" Alias "SetWindowLongA" ( _
                    ByVal hwnd As LongPtr, _
                    ByVal nIndex As LongPtr, _
                    ByVal dwNewLong As Long) As LongPtr
    Private Declare PtrSafe Function GetWindowLong Lib "user32" Alias "GetWindowLongA" ( _
                    ByVal hwnd As LongPtr, _
                    ByVal nIndex As Long) As LongPtr
    Private Declare PtrSafe Function SetParent Lib "user32" ( _
                    ByVal hWndChild As LongPtr, _
                    ByVal hWndNewParent As LongPtr) As LongPtr
#Else
    Public FormHandle As Long
    Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" ( _
                    ByVal lpClassName As String, _
                    ByVal lpWindowName As String) As Long
    Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" ( _
                    ByVal hwnd As Long, _
                    ByVal nIndex As Long, _
                    ByVal dwNewLong As Long) As Long
    Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" ( _
                    ByVal hwnd As Long, _
                    ByVal nIndex As Long) As Long
    Private Declare Function SetParent Lib "user32" ( _
                    ByVal hWndChild As Long, _
                    ByVal hWndNewParent As Long) As Long
#End If
Private Const GWL_STYLE = (-16)
Private Const WS_CHILD = &H40000000
Private Const WS_VISIBLE = &H10000000

Private WithEvents app As Visio.Application
Attribute app.VB_VarHelpID = -1
Private v_ManagementGDZS As f_ManagementGDZS
Private WithEvents wAddon As Visio.Window
Attribute wAddon.VB_VarHelpID = -1

Private Const con_BorderWidth = 6
Private Const con_ToolBarHeight = 50





'-------------------------------------------------------------------------------------------------------------------------------

Private Sub Class_Initialize()
    ShowWindow
    Set app = Visio.Application
End Sub

Private Sub Class_Terminate()
    Set v_ManagementGDZS = Nothing
    Set app = Nothing
End Sub

Private Sub app_WindowTurnedToPage(ByVal Window As IVWindow)
'��������� �� ������� ����� ����������
    ps_WindowRefresh v_ManagementGDZS
End Sub

Private Sub app_CellChanged(ByVal cell As IVCell)
'��������� �� ��������� ������
Dim v_ColumnIndex As Integer
Dim vO_LV As ListView
Dim vO_Shape As Visio.Shape

    '��������� ������� �� ����� v_ManagementGDZS ��� ������ � ���� ���, �� ������ ������ �� ������ �� ��������� ������
    If v_ManagementGDZS Is Nothing Then Exit Sub

    '��������� ��������� �� ������ � ���������� ������� � ��������� �����
    If Not cell.Shape.Parent.Name = Application.ActivePage.Name Then Exit Sub
    
    '���������� ��������� ����������
    Set vO_Shape = cell.Shape
    Set vO_LV = v_ManagementGDZS.ListView1
    
    If pf_IsInList(cell.Shape.Name) Then

        Select Case cell.Name
            Case Is = "Prop.Unit"
                vO_LV.ListItems(vO_Shape.Name).Text = pf_CellValue(vO_Shape, cell.Name)
'            Case Is = "Prop.AirDevice"
'                vO_LV.ListItems(vO_Shape.Name).ListSubItems(1).Text = pf_GetGDZSType(vO_Shape.Cells("User.IndexPers"))
            Case Is = "Prop.Call"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(2).Text = pf_GetCall(vO_Shape)
            Case Is = "Prop.FormingTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.FormingTime").ResultStr(visString)
            Case Is = "Prop.Personnel"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(4).Text = pf_CellValue(vO_Shape, "Prop.Personnel")
            Case Is = "Prop.AirDevice"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(5).Text = pf_GetSIZODModel(vO_Shape)
            Case Is = "Actions.MainManeure.Checked"
                '������� �� ������
                vO_LV.ListItems.Remove (vO_Shape.Name)  '.ListItems(Cell.Shape.Name).

        End Select

    Else

        '---���� ������ �������� ����������� �������, � ��� ���� �� ��� � ������ (�.�. ��� ���� �����������), ��...
        If vO_Shape.CellExists("User.IndexPers", 0) = True And vO_Shape.CellExists("User.Version", 0) = True Then
            If pf_IsGDZS(vO_Shape.Cells("User.IndexPers")) And Not pf_IsManeure(vO_Shape) Then
                '��������� � ������
                pf_AddNewRow vO_LV.ListItems.Count + 1, vO_Shape
            End If
        End If

    End If


End Sub


'---------------------------------��������� ������ � ������ � ����-------------------------------------------------------
Private Sub ShowWindow()
'��������� ���������� ���� "���������� ������ � ����������" � ����������� ��� � ������ Base
'Dim FormHandle As Long

    Set wAddon = ActiveWindow.Windows.Add("GDZS", visWSVisible + visWSDockedBottom, visAnchorBarAddon, , , 300, 210)
    Set v_ManagementGDZS = New f_ManagementGDZS
    v_ManagementGDZS.Caption = "GDZS"


    FormHandle = FindWindow(vbNullString, "GDZS")

    SetWindowLong FormHandle, GWL_STYLE, WS_CHILD Or WS_VISIBLE

    SetParent FormHandle, wAddon.WindowHandle32

'---��������� ListView
    v_ManagementGDZS.ListView1.View = lvwReport
    v_ManagementGDZS.ListView1.FullRowSelect = True
    v_ManagementGDZS.ListView1.GridLines = True
    v_ManagementGDZS.ListView1.LabelEdit = lvwManual
    
    v_ManagementGDZS.ListView1.ColumnHeaders.Add 1, "Prop.Unit", "�������������", 75
    v_ManagementGDZS.ListView1.ColumnHeaders.Add 2, "Type", "���", 70
    v_ManagementGDZS.ListView1.ColumnHeaders.Add 3, "Prop.Call", "��������", 70
    v_ManagementGDZS.ListView1.ColumnHeaders.Add 4, "Prop.FormingTime", "����� ������������", 90
    v_ManagementGDZS.ListView1.ColumnHeaders.Add 5, "Prop.Personnel", "������ ������", 70
    v_ManagementGDZS.ListView1.ColumnHeaders.Add 6, "Prop.AirDevice", "�����", 100

    wAddon.Caption = "���� ����"
    
'---�������� � ��������� ��������� ����������
    ps_GetGDZS v_ManagementGDZS

End Sub

Private Sub app_ShapeAdded(ByVal Shape As IVShape)
'��������� ���������� ����� �����
Dim Row As Integer

    On Error GoTo EX

    Row = v_ManagementGDZS.ListView1.ListItems.Count + 1

        If Shape.CellExists("User.IndexPers", 0) = True And Shape.CellExists("User.Version", 0) = True Then
            If pf_IsGDZS(Shape.Cells("User.IndexPers")) And Not pf_IsManeure(Shape) Then
                pf_AddNewRow Row, Shape
            End If
        End If

Exit Sub
EX:
    '������
End Sub

Private Sub app_BeforeShapeDelete(ByVal Shape As IVShape)
'��������� �������� ������

    On Error GoTo EX

    v_ManagementGDZS.ListView1.ListItems.Remove (Shape.Name)
    
Exit Sub
EX:
    '������
End Sub

Public Sub PS_ShowWindow()
    If v_ManagementGDZS Is Nothing Then
        ShowWindow
    End If
End Sub


Private Sub ps_GetGDZS(ByRef StvolForm As f_ManagementGDZS)
'��������� ���������� ��� ������ �� ����� � � ������, ���� ��� �������������� �������� ������ ��������� � ������ � �������
Dim vO_Shape As Visio.Shape
Dim Row As Integer

    Row = 1
    
On Error GoTo EX
    
    For Each vO_Shape In ActivePage.Shapes
        If vO_Shape.CellExists("User.IndexPers", 0) = True And vO_Shape.CellExists("User.Version", 0) = True Then
            If pf_IsGDZS(vO_Shape.Cells("User.IndexPers")) And Not pf_IsManeure(vO_Shape) Then
                pf_AddNewRow Row, vO_Shape
                
                Row = Row + 1
            End If
        End If
    Next

Exit Sub
EX:
    '������
End Sub

Private Sub wAddon_BeforeWindowClosed(ByVal Window As IVWindow)
    Set v_ManagementGDZS = Nothing
End Sub

Private Sub ps_WindowRefresh(ByRef TechForm As f_ManagementGDZS)
'��������� ���������� ����������� ListView
On Error GoTo EX
    TechForm.ListView1.Sorted = False
    TechForm.ListView1.ListItems.Clear
    ps_GetGDZS TechForm
Exit Sub
EX:
    'Exit
End Sub



'-----------------------������� �������� -----------------------------------------------
Private Function pf_IsGDZS(ByVal a_IndexPers As Integer) As Boolean
'���� ������ �������� ������� - ������������ ������, � ��������� ������ - ����
    If a_IndexPers >= 46 And a_IndexPers <= 48 Or a_IndexPers = 90 Then
        pf_IsGDZS = True
    Else
        pf_IsGDZS = False
    End If
End Function

Private Function pf_IsManeure(ByRef a_Shape As Visio.Shape) As Boolean
'���� ������ ����� �������� - "������" � ��� �������� ����� ������, �� ������������ ������, � ��������� ������ - ����
    pf_IsManeure = False
    If a_Shape.CellExists("Actions.MainManeure.Checked", 0) = True Then
        If a_Shape.Cells("Actions.MainManeure.Checked") = 1 Then pf_IsManeure = True
    End If
End Function

Private Function pf_IsInList(ByVal aS_ShapeName As String) As Boolean
'������� ���������� ������, ���� ��������� ������ ������� � ������ ListView � ����, ���� ���
Dim i As Integer

pf_IsInList = False
    For i = 1 To v_ManagementGDZS.ListView1.ListItems.Count
        If v_ManagementGDZS.ListView1.ListItems(i).Key = aS_ShapeName Then pf_IsInList = True
    Next i
End Function

Private Function pf_IsValidCellName(ByVal aS_CellName As String) As Boolean
'������� ���������� ������, ���� ��������� ������ ������� � ������ ListView � ����, ���� ���
Dim i As Integer

    pf_IsValidCellName = False
    
    For i = 1 To v_ManagementGDZS.ListView1.ColumnHeaders.Count
        If v_ManagementGDZS.ListView1.ColumnHeaders(i).Key = aS_CellName Then pf_IsValidCellName = True
    Next i

End Function


'-------------------------������� ��������� ������----------------------------------------
Private Function pf_CellValue(ByRef aO_Shape As Visio.Shape, ByVal aS_CellName As String) As String
'������� ���������� �������� ��������� ������ ��������� ������
    pf_CellValue = "-"
    If aO_Shape.CellExists(aS_CellName, 0) = True Then
        pf_CellValue = aO_Shape.Cells(aS_CellName).ResultStr(visString)
        If IsNumeric(pf_CellValue) Then
            pf_CellValue = Int(pf_CellValue)
        End If
    End If
End Function

Private Function pf_GetGDZSType(ByVal a_IndexPers As Integer) As String
'� ����������� �� ����, ��� �������� ������ - ���������� ����� ������� (�����, ���� ��� ���)
    Select Case a_IndexPers
        Case Is = 46 '����� ���� (����)
            pf_GetGDZSType = "����� (����)"
        Case Is = 90 '����� ���� (����)
            pf_GetGDZSType = "����� (����)"
        Case Is = 47 '���� ������������
            pf_GetGDZSType = "��"
        Case Is = 48 '����������-���������� �����
            pf_GetGDZSType = "���"
    End Select
End Function

Private Function pf_GetSIZODModel(ByRef aO_Shape As Visio.Shape) As String
'���������� ������ �����, ���� � ������� ��� ������ ��������� - ���������� ""
On Error GoTo EX
    
    pf_GetSIZODModel = aO_Shape.Cells("Prop.AirDevice").ResultStr(visString)
    
Exit Function
EX:
    pf_GetSIZODModel = " "
End Function

Private Function pf_GetCall(ByRef aO_Shape As Visio.Shape) As String
'������� ���������� �������� (���� �� ����)
On Error GoTo EX

    pf_GetCall = CallToStr(aO_Shape.Cells("Prop.Call").ResultStr(visString))
Exit Function
EX:
    pf_GetCall = "�� ��������"
End Function

Private Sub pf_AddNewRow(ByVal a_Row As Integer, ByRef a_Shape As Visio.Shape)
'��������� ��������� ����� ������ �������� ������ ������
Dim vO_LV As ListView

    Set vO_LV = v_ManagementGDZS.ListView1
    
    vO_LV.ListItems.Add a_Row, a_Shape.Name, a_Shape.Cells("Prop.Unit").ResultStr(visString)  '������ �������� ����� �����!
    
    vO_LV.ListItems(a_Row).ListSubItems.Add 1, "Prop.Type", pf_GetGDZSType(a_Shape.Cells("User.IndexPers"))
    vO_LV.ListItems(a_Row).ListSubItems.Add 2, "Prop.Call", CallToStr(a_Shape.Cells("Prop.Call").ResultStr(visString))
    vO_LV.ListItems(a_Row).ListSubItems.Add 3, "Prop.FormingTime", a_Shape.Cells("Prop.FormingTime").ResultStr(visString)
    vO_LV.ListItems(a_Row).ListSubItems.Add 4, "Prop.Personnel", pf_CellValue(a_Shape, "Prop.Personnel")
    vO_LV.ListItems(a_Row).ListSubItems.Add 5, "Prop.AirDevice", pf_GetSIZODModel(a_Shape)

End Sub
