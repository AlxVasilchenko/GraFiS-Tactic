VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "c_ManagementTimeLine"
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
Private v_ManagementTimeLine As f_ManagementTimeLine
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
    Set v_ManagementTimeLine = Nothing
    Set app = Nothing
End Sub

Private Sub app_WindowTurnedToPage(ByVal Window As IVWindow)
'��������� �� ������� ����� ����������
    ps_WindowRefresh v_ManagementTimeLine
End Sub

Private Sub app_CellChanged(ByVal cell As IVCell)
'��������� �� ��������� ������
Dim v_ColumnIndex As Integer
Dim vO_LV As ListView
Dim vO_Shape As Visio.Shape

    '��������� ������� �� ����� v_ManagementTimeLine ��� ������ � ���� ���, �� ������ ������ �� ������ �� ��������� ������
    If v_ManagementTimeLine Is Nothing Then Exit Sub

    '��������� ��������� �� ������ � ���������� ������� � ��������� �����
    If Not cell.Shape.Parent.Name = Application.ActivePage.Name Then Exit Sub

    '���������� ��������� ����������
    Set vO_Shape = cell.Shape
    Set vO_LV = v_ManagementTimeLine.ListView1

    If pf_IsInList(cell.Shape.Name) Then

        Select Case cell.Name
            Case Is = "Prop.Unit"
                vO_LV.ListItems(vO_Shape.Name).Text = pf_CellValue(vO_Shape, cell.Name)
            Case Is = "Prop.Call"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(1).Text = pf_GetCall(vO_Shape)
            Case Is = "User.IndexPers.Prompt"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(2).Text = pf_GetTimeLineType(vO_Shape)
            Case Is = "Prop.ArrivalTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.ArrivalTime").ResultStr(visString)
            Case Is = "Prop.LineTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.LineTime").ResultStr(visString)
            Case Is = "Prop.SetTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.SetTime").ResultStr(visString)
            Case Is = "Prop.FormingTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.FormingTime").ResultStr(visString)
            Case Is = "Prop.SquareTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.SquareTime").ResultStr(visString)
            Case Is = "Prop.FireTime"
                vO_LV.ListItems(vO_Shape.Name).ListSubItems(3).Text = vO_Shape.Cells("Prop.FireTime").ResultStr(visString)
            
            Case Is = "Actions.MainManeure.Checked"
                '������� �� ������
                vO_LV.ListItems.Remove (vO_Shape.Name)  '.ListItems(Cell.Shape.Name).

        End Select

    End If


End Sub

Private Sub app_SelectionChanged(ByVal Window As IVWindow)
'��������� ������ ��� ������ ����� ������
'����������!!!
'Dim vO_LV As ListView
'Dim vO_Shape As Visio.Shape
'
'    If Application.ActiveWindow.Selection.Count = 1 Then
'        '���������� ��������� ����������
'        Set vO_Shape = Application.ActiveWindow.Selection(1)
'        Set vO_LV = v_ManagementTimeLine.ListView1
'
'        vO_LV.ListItems.Item(2).Selected = True '.ListSubItems(2).ForeColor = vbRed   '.Bold = True
'    End If

End Sub


'---------------------------------��������� ������ � ������ � ����-------------------------------------------------------
Private Sub ShowWindow()
'��������� ���������� ���� "���������� ������ � ����������" � ����������� ��� � ������ Base
'Dim FormHandle As Long

'    Set wAddon = ActiveWindow.Windows.Add("TimeLine", visWSVisible + visWSDockedBottom, visAnchorBarAddon, , , 300, 210)
    Set wAddon = ActiveWindow.Windows.Add("TimeLine", visWSVisible + visWSDockedRight, visAnchorBarAddon, , , 450, 300)
    
    Set v_ManagementTimeLine = New f_ManagementTimeLine
    v_ManagementTimeLine.Caption = "TimeLine"


    FormHandle = FindWindow(vbNullString, "TimeLine")

    SetWindowLong FormHandle, GWL_STYLE, WS_CHILD Or WS_VISIBLE

    SetParent FormHandle, wAddon.WindowHandle32

'---��������� ListView
    v_ManagementTimeLine.ListView1.View = lvwReport
    v_ManagementTimeLine.ListView1.FullRowSelect = True
    v_ManagementTimeLine.ListView1.GridLines = True
    v_ManagementTimeLine.ListView1.LabelEdit = lvwManual
    
    v_ManagementTimeLine.ListView1.ColumnHeaders.Add 1, "Prop.Unit", "�������������", 75
    v_ManagementTimeLine.ListView1.ColumnHeaders.Add 2, "Prop.Call", "��������", 70
    v_ManagementTimeLine.ListView1.ColumnHeaders.Add 3, "Type", "���", 70
    v_ManagementTimeLine.ListView1.ColumnHeaders.Add 4, "Prop.FormingTime", "�����", 90

    wAddon.Caption = "���������� �� �������"
    
'---�������� � ��������� ��������� ����������
    ps_GetTimeLine v_ManagementTimeLine

'---��������� �� �������
    v_ManagementTimeLine.ps_SortBy (5)

End Sub

Private Sub app_ShapeAdded(ByVal Shape As IVShape)
'��������� ���������� ����� �����
Dim Row As Integer

    On Error GoTo EX

    Row = v_ManagementTimeLine.ListView1.ListItems.Count + 1

        If Shape.CellExists("User.IndexPers", 0) = True And Shape.CellExists("User.Version", 0) = True Then
            If pf_IsTimeLine(Shape) And Not pf_IsManeure(Shape) Then
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

    v_ManagementTimeLine.ListView1.ListItems.Remove (Shape.Name)
    
Exit Sub
EX:
    '������
End Sub

Public Sub PS_ShowWindow()
    If v_ManagementTimeLine Is Nothing Then
        ShowWindow
    End If
End Sub


Private Sub ps_GetTimeLine(ByRef StvolForm As f_ManagementTimeLine)
'��������� ���������� ��� ������ �� ����� � � ������, ���� ��� �������������� �������� ������ ��������� � ������ � �������
Dim vO_Shape As Visio.Shape
Dim Row As Integer

    Row = 1
    
On Error GoTo EX
    
    For Each vO_Shape In ActivePage.Shapes
        If vO_Shape.CellExists("User.IndexPers", 0) = True And vO_Shape.CellExists("User.Version", 0) = True Then
            If pf_IsTimeLine(vO_Shape) And Not pf_IsManeure(vO_Shape) Then
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
    Set v_ManagementTimeLine = Nothing
End Sub

Private Sub ps_WindowRefresh(ByRef TechForm As f_ManagementTimeLine)
'��������� ���������� ����������� ListView
On Error GoTo EX
    TechForm.ListView1.Sorted = False
    TechForm.ListView1.ListItems.Clear
    ps_GetTimeLine TechForm
Exit Sub
EX:
    'Exit
End Sub



'-----------------------������� �������� -----------------------------------------------
Private Function pf_IsTimeLine(ByRef a_Shape As Visio.Shape) As Boolean
'���� ������ �������� ������� ��������� - ������������ ������, � ��������� ������ - ����
    If a_Shape.CellExists("Prop.ArrivalTime", 0) = True Or a_Shape.CellExists("Prop.LineTime", 0) = True _
        Or a_Shape.CellExists("Prop.SetTime", 0) = True Or a_Shape.CellExists("Prop.FormingTime", 0) = True _
        Or a_Shape.CellExists("Prop.SquareTime", 0) = True Or a_Shape.CellExists("Prop.FireTime", 0) = True _
        Then
        pf_IsTimeLine = True
    Else
        pf_IsTimeLine = False
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
    For i = 1 To v_ManagementTimeLine.ListView1.ListItems.Count
        If v_ManagementTimeLine.ListView1.ListItems(i).Key = aS_ShapeName Then pf_IsInList = True
    Next i
End Function

Private Function pf_IsValidCellName(ByVal aS_CellName As String) As Boolean
'������� ���������� ������, ���� ��������� ������ ������� � ������ ListView � ����, ���� ���
Dim i As Integer

    pf_IsValidCellName = False
    
    For i = 1 To v_ManagementTimeLine.ListView1.ColumnHeaders.Count
        If v_ManagementTimeLine.ListView1.ColumnHeaders(i).Key = aS_CellName Then pf_IsValidCellName = True
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

Private Function pf_GetUnit(ByRef aO_Shape As Visio.Shape) As String
'������� ���������� �������� (���� �� ����)
On Error GoTo EX

    pf_GetUnit = CallToStr(aO_Shape.Cells("Prop.Unit").ResultStr(visString))
Exit Function
EX:
    pf_GetUnit = "-"
End Function

Private Function pf_GetTimeLineType(ByRef aO_Shape As Visio.Shape) As String
'� ����������� �� ����, ��� �������� ������ - ���������� ����� ������� (�����, ���� ��� ���)
On Error GoTo EX
    pf_GetTimeLineType = aO_Shape.Cells("User.IndexPers.Prompt").ResultStr(visString)
Exit Function
EX:
    pf_GetTimeLineType = "�� ��������"
End Function


Private Function pf_GetCall(ByRef aO_Shape As Visio.Shape) As String
'������� ���������� �������� (���� �� ����)
On Error GoTo EX

    pf_GetCall = CallToStr(aO_Shape.Cells("Prop.Call").ResultStr(visString))
Exit Function
EX:
    pf_GetCall = "�� ��������"
End Function

Private Function pf_GetTime(ByRef aO_Shape As Visio.Shape) As String
'������� ���������� ����� ������ (��������)
On Error GoTo EX

    If aO_Shape.CellExists("Prop.ArrivalTime", 0) = True Then
        pf_GetTime = aO_Shape.Cells("Prop.ArrivalTime").ResultStr(visString)
        Exit Function
    End If
    If aO_Shape.CellExists("Prop.LineTime", 0) = True Then
        pf_GetTime = aO_Shape.Cells("Prop.LineTime").ResultStr(visString)
        Exit Function
    End If
    If aO_Shape.CellExists("Prop.SetTime", 0) = True Then
            pf_GetTime = aO_Shape.Cells("Prop.SetTime").ResultStr(visString)
        Exit Function
    End If
    If aO_Shape.CellExists("Prop.FormingTime", 0) = True Then
            pf_GetTime = aO_Shape.Cells("Prop.FormingTime").ResultStr(visString)
        Exit Function
    End If
    If aO_Shape.CellExists("Prop.SquareTime", 0) = True Then
            pf_GetTime = aO_Shape.Cells("Prop.SquareTime").ResultStr(visString)
        Exit Function
    End If
    If aO_Shape.CellExists("Prop.FireTime", 0) = True Then
            pf_GetTime = aO_Shape.Cells("Prop.FireTime").ResultStr(visString)
        Exit Function
    End If

Exit Function
EX:
    pf_GetTime = "�� ��������"
End Function


Private Sub pf_AddNewRow(ByVal a_Row As Integer, ByRef a_Shape As Visio.Shape)
'��������� ��������� ����� ������ �������� ������ ������
Dim vO_LV As ListView

    Set vO_LV = v_ManagementTimeLine.ListView1
    
    vO_LV.ListItems.Add a_Row, a_Shape.Name, pf_GetUnit(a_Shape)  '������ �������� ����� �����!
    
    vO_LV.ListItems(a_Row).ListSubItems.Add 1, "Prop.Call", pf_GetCall(a_Shape)
    vO_LV.ListItems(a_Row).ListSubItems.Add 2, "Prop.Type", pf_GetTimeLineType(a_Shape)
    vO_LV.ListItems(a_Row).ListSubItems.Add 3, "Prop.Time", pf_GetTime(a_Shape)

End Sub



