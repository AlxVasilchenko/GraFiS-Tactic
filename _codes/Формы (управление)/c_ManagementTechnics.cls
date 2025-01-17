VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "c_ManagementTechnics"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'�����-������� ��� ���� ����� �������� �������

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
Private v_ManagementTechincs As f_ManagementTechincs
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
    Set v_ManagementTechincs = Nothing
    Set app = Nothing
End Sub

Private Sub app_WindowTurnedToPage(ByVal Window As IVWindow)
'��������� �� ������� ����� ����������
    ps_WindowRefresh v_ManagementTechincs
End Sub

Private Sub app_CellChanged(ByVal cell As IVCell)
'��������� �� ��������� ������
Dim v_ColumnIndex As Integer
Dim vO_LV As ListView
Dim vO_Shape As Visio.Shape

    '��������� ������� �� ����� f_ManagementTechnics ��� ������ � ���� ���, �� ������ ������ �� ������ �� ��������� ������
    If v_ManagementTechincs Is Nothing Then Exit Sub

    '��������� ��������� �� ������ � ���������� ������� � ��������� �����
    If Not cell.Shape.Parent.Name = Application.ActivePage.Name Then Exit Sub
    
    '���������� ��������� ����������
    Set vO_Shape = cell.Shape
    Set vO_LV = v_ManagementTechincs.ListView1
    
    If pf_IsInList(vO_Shape.Name) Then
        
        Select Case cell.Name
            Case Is = "Prop.Unit"
                vO_LV.ListItems(vO_Shape.Name).Text = pf_CellValue(vO_Shape, cell.Name)
            Case Is = "Prop.Call"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(1).Text = pf_GetCall(vO_Shape)
            Case Is = "Prop.Model"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(2).Text = vO_Shape.Cells("Prop.Model").ResultStr(visString)
            Case Is = "Prop.ArrivalTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.ArrivalTime").ResultStr(visString)
            Case Is = "Prop.PersonnelHave"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(4).Text = pf_CellValue(vO_Shape, "Prop.PersonnelHave")
            Case Is = "Actions.MainManeure.Checked"
                '������� �� ������
                vO_LV.ListItems.Remove (vO_Shape.Name)
        End Select
    Else
        '---���� ������ �������� ����������� ��������, � ��� ���� �� ��� � ������ (�.�. ��� ���� �����������), ��...
        If vO_Shape.CellExists("User.IndexPers", 0) = True And vO_Shape.CellExists("User.Version", 0) = True Then
            If pf_IsMainTechnics(vO_Shape.Cells("User.IndexPers")) And Not pf_IsManeure(vO_Shape) Then
                '��������� � ������
                pf_AddNewRow vO_LV.ListItems.Count + 1, vO_Shape
            End If
        End If
    
    End If

End Sub

Private Sub app_ShapeAdded(ByVal Shape As IVShape)
'��������� ���������� ����� �����
Dim Row As Integer

    On Error GoTo EX

    Row = v_ManagementTechincs.ListView1.ListItems.Count + 1

        If Shape.CellExists("User.IndexPers", 0) = True And Shape.CellExists("User.Version", 0) = True Then
            If pf_IsMainTechnics(Shape.Cells("User.IndexPers")) And Not pf_IsManeure(Shape) Then
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

    v_ManagementTechincs.ListView1.ListItems.Remove (Shape.Name)
    
Exit Sub
EX:
    '������
End Sub


'---------------------------------��������� ������ � ������ � ����-------------------------------------------------------
Private Sub ShowWindow()
'��������� ���������� ���� "���������� ������ � ����������" � ����������� ��� � ������ Base
'Dim FormHandle As Long

    Set wAddon = ActiveWindow.Windows.Add("Base", visWSVisible + visWSDockedBottom, visAnchorBarAddon, , , 300, 210)
    Set v_ManagementTechincs = New f_ManagementTechincs
    v_ManagementTechincs.Caption = "Base"


    FormHandle = FindWindow(vbNullString, "Base")

    SetWindowLong FormHandle, GWL_STYLE, WS_CHILD Or WS_VISIBLE

    SetParent FormHandle, wAddon.WindowHandle32

'---��������� ListView
    v_ManagementTechincs.ListView1.View = lvwReport
    v_ManagementTechincs.ListView1.FullRowSelect = True
    v_ManagementTechincs.ListView1.GridLines = True
    v_ManagementTechincs.ListView1.LabelEdit = lvwManual
    
    v_ManagementTechincs.ListView1.ColumnHeaders.Add 1, "Prop.Unit", "�������������", 50
    v_ManagementTechincs.ListView1.ColumnHeaders.Add 2, "Prop.Call", "��������", 80
    v_ManagementTechincs.ListView1.ColumnHeaders.Add 3, "Prop.Model", "������", 100
    v_ManagementTechincs.ListView1.ColumnHeaders.Add 4, "Prop.ArrivalTime", "����� ��������", 90
    v_ManagementTechincs.ListView1.ColumnHeaders.Add 5, "Prop.PersonnelHave", "������ ������", 70

    wAddon.Caption = "��������� �������������"
    
'---�������� � ��������� ��������� ����������
    ps_GetTechnics v_ManagementTechincs

End Sub

Public Sub PS_ShowWindow()
    If v_ManagementTechincs Is Nothing Then
        ShowWindow
    End If
End Sub


Private Sub ps_GetTechnics(ByRef TechForm As f_ManagementTechincs)
'��������� ���������� ��� ������ �� ����� � � ������, ���� ��� �������������� �������� ������ ��������� � ������ � �������
Dim vO_Shape As Visio.Shape
Dim Row As Integer

    Row = 1
    
On Error GoTo EX
    
    For Each vO_Shape In ActivePage.Shapes
        If vO_Shape.CellExists("User.IndexPers", 0) = True And vO_Shape.CellExists("User.Version", 0) = True Then
            If pf_IsMainTechnics(vO_Shape.Cells("User.IndexPers")) And Not pf_IsManeure(vO_Shape) Then
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
    Set v_ManagementTechincs = Nothing
End Sub

Private Sub ps_WindowRefresh(ByRef TechForm As f_ManagementTechincs)
'��������� ���������� ����������� ListView
On Error GoTo EX
    TechForm.ListView1.Sorted = False
    TechForm.ListView1.ListItems.Clear
    ps_GetTechnics TechForm
Exit Sub
EX:
    'Exit
End Sub



'-----------------------������� �������� -----------------------------------------------
Private Function pf_IsMainTechnics(ByVal a_IndexPers As Integer) As Boolean
'���� ������ �������� �������� - ������������ ������, � ��������� ������ - ����
    If a_IndexPers <= 20 Or a_IndexPers = 24 Or a_IndexPers = 25 Or a_IndexPers = 26 Or a_IndexPers = 27 Or _
        a_IndexPers = 28 Or a_IndexPers = 29 Or a_IndexPers = 30 Or a_IndexPers = 31 Or a_IndexPers = 32 Or _
        a_IndexPers = 161 Or a_IndexPers = 162 Then
        pf_IsMainTechnics = True
    Else
        pf_IsMainTechnics = False
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
    For i = 1 To v_ManagementTechincs.ListView1.ListItems.Count
        If v_ManagementTechincs.ListView1.ListItems(i).Key = aS_ShapeName Then pf_IsInList = True
    Next i
End Function

Private Function pf_IsValidCellName(ByVal aS_CellName As String) As Boolean
'������� ���������� ������, ���� ��������� ������ ������� � ������ ListView � ����, ���� ���
Dim i As Integer

    pf_IsValidCellName = False
    
    For i = 1 To v_ManagementTechincs.ListView1.ColumnHeaders.Count
        If v_ManagementTechincs.ListView1.ColumnHeaders(i).Key = aS_CellName Then pf_IsValidCellName = True
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

    Set vO_LV = v_ManagementTechincs.ListView1
    
    vO_LV.ListItems.Add a_Row, a_Shape.Name, a_Shape.Cells("Prop.Unit").ResultStr(visString)
    
    vO_LV.ListItems(a_Row).ListSubItems.Add 1, "Prop.Call", CallToStr(a_Shape.Cells("Prop.Call").ResultStr(visString))
    vO_LV.ListItems(a_Row).ListSubItems.Add 2, "Prop.Model", a_Shape.Cells("Prop.Model").ResultStr(visString)
    vO_LV.ListItems(a_Row).ListSubItems.Add 3, "Prop.ArrivalTime", a_Shape.Cells("Prop.ArrivalTime").ResultStr(visString)
    vO_LV.ListItems(a_Row).ListSubItems.Add 4, "Prop.PersonnelHave", pf_CellValue(a_Shape, "Prop.PersonnelHave")

End Sub
