VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Class1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public WithEvents ComBut As Office.CommandBarButton   '������� �����
Attribute ComBut.VB_VarHelpID = -1
Public WithEvents ComBut2 As Office.CommandBarButton  '����������� �����
Attribute ComBut2.VB_VarHelpID = -1
Public WithEvents ComBut3 As Office.CommandBarButton  '������������� �����
Attribute ComBut3.VB_VarHelpID = -1
Public WithEvents ComBut4 As Office.CommandBarButton  '������������
Attribute ComBut4.VB_VarHelpID = -1

Private Sub Class_Initialize()
    Set ComBut = Application.CommandBars("�����������").Controls("�����")
    Set ComBut2 = Application.CommandBars("�����������").Controls("����������� �����")
    Set ComBut3 = Application.CommandBars("�����������").Controls("������������� �����")
    Set ComBut4 = Application.CommandBars("�����������").Controls("������������")

End Sub

Private Sub Class_Terminate()
    Set ComBut = Nothing
End Sub

Private Sub ComBut_Click(ByVal Ctrl As Office.CommandBarButton, CancelDefault As Boolean)
'����������� ������� ������� ������ "�������� � �������� �����"
    
'    On Error GoTo EX

'---���������
'    If ClickAndOnSameButton(Ctrl.Caption) Then Exit Sub

'---��������� �������� �� ������ - ���� �������� - ���������
    If Ctrl.State = msoButtonDown Then
        Ctrl.State = msoButtonUp
        Exit Sub
    End If

    If Ctrl.State = msoButtonUp Then
        If IsSelectedOneShape(False) Then
        '---���� ������� ���� ���� ������ - �������� �� ��������
            If Not IsHavingUserSection(True) And Not IsSquare(True) Then
            '---�������� ������ � ������ �����
                MakeHoseLine 51, 0
            End If
        Else
'            MsgBox "�� ������� �� ����� ������! ����� ������� ����� ��������������� ���������!"
            PS_CheckButtons Ctrl
        End If
    End If
    
'            '---�������� ������ � ������ ���� �������
'                MorphToLake

Exit Sub
EX:
    SaveLog Err, "ComBut_Click"
End Sub

Private Sub ComBut2_Click(ByVal Ctrl As Office.CommandBarButton, CancelDefault As Boolean)
'����������� ������� ����� �� ������ "����������� �����"

    On Error GoTo EX

'---���������
'    If ClickAndOnSameButton(Ctrl.Caption) Then Exit Sub
    
'---��������� �������� �� ������ - ���� �������� - ���������
    If Ctrl.State = msoButtonDown Then
        Ctrl.State = msoButtonUp
        Exit Sub
    End If

    If Ctrl.State = msoButtonUp Then
        If IsSelectedOneShape(False) Then
        '---���� ������� ���� ���� ������ - �������� �� ��������
            If Not IsHavingUserSection(True) And Not IsSquare(True) Then
            '---�������� ������ � ������ ����������� �����
                MakeVHoseLine
            End If
        Else
'            MsgBox "�� ������� �� ����� ������! ����� ������� ����� ��������������� ���������!"
            PS_CheckButtons Ctrl
        End If
    End If
    
Exit Sub
EX:
    SaveLog Err, "ComBut2_Click"
End Sub

Private Sub ComBut3_Click(ByVal Ctrl As Office.CommandBarButton, CancelDefault As Boolean)
'����������� ������� ����� �� ������ "������������� �����"

    On Error GoTo EX
    
'---���������
'    If ClickAndOnSameButton(Ctrl.Caption) Then Exit Sub
    
'---��������� �������� �� ������ - ���� �������� - ���������
    If Ctrl.State = msoButtonDown Then
        Ctrl.State = msoButtonUp
        Exit Sub
    End If

    If Ctrl.State = msoButtonUp Then
        If IsSelectedOneShape(False) Then
        '---���� ������� ���� ���� ������ - �������� �� ��������
            If Not IsHavingUserSection(True) And Not IsSquare(True) Then
            '---�������� ������ � ������ ������������� �����
                MakeHoseLine 77, 1
            End If
        Else
'            MsgBox "�� ������� �� ����� ������! ����� ������� ����� ��������������� ���������!"
            PS_CheckButtons Ctrl
        End If
    End If

Exit Sub
EX:
    SaveLog Err, "ComBut3_Click"
End Sub



'--------------------------------���������� ������� ������---------------------
Private Function GetSelectedButtonCaption() As String
Dim v_Ctrl As CommandBarControl

    On Error GoTo EX
'---��������� ����� ������ ������ � � ����������� �� ����� ��������� ��������
    For Each v_Ctrl In Application.CommandBars("�����������").Controls
        If v_Ctrl.State = msoButtonDown Then
            GetSelectedButtonCaption = v_Ctrl.Caption
            Exit Function
        End If
    Next v_Ctrl
GetSelectedButtonCaption = ""

Exit Function
EX:
End Function


'-------------------------------������� ������ ������---------------------
'Public Sub MakeHoseLine()
''����� ��������� � �������� �����
'Dim ShpObj As Visio.Shape
'Dim ShpInd As Integer
'
''---�������� ��������� ������ - ��� �������������� ������� ������ ��� ������� ��������� ������
''    On Error GoTo Tail
'
''---��������� ��������� ������� �����������, �������� ������ � ����� �������� ��������� �������
'    Application.EventsEnabled = False
'    ImportHoseInformation
'    Application.EventsEnabled = True
'
''---�������������� �������� ������
'    Set ShpObj = Application.ActiveWindow.Selection(1)
'    ShpInd = ShpObj.ID
'
''---�������� ������ ��� ������
'    '---��������� ��������� ��������� ������ �������������
'    ShpObj.Cells("Prop.Unit.Format").FormulaU = ListImport("�������������", "�������������")
'    '---��������� ��������� ��������� ������� ���������� �������
'    ShpObj.Cells("Prop.HoseMaterial.Format").FormulaU = ListImport("�_������", "�������� ������")
'    '---��������� ��������� ��������� ������� ��������� �������
'    HoseDiametersListImport (ShpInd)
'    '---��������� ��������� ��������� �������� ������������� �������
'    HoseResistanceValueImport (ShpInd)
'    '---��������� ��������� ��������� �������� ���������� ����������� �������
'    HoseMaxFlowValueImport (ShpInd)
'    '---��������� ��������� ��������� �������� ����� �������
'    HoseWeightValueImport (ShpInd)
'
''---������������� �������� �������� ������� ��� ������
'    ShpObj.Cells("Prop.LineTime").FormulaU = _
'        "DATETIME(" & Str(ActiveDocument.DocumentSheet.Cells("User.CurrentTime").Result(visDate)) & ")"
'
''---�������� ������
''    Ctrl.State = False
'
''---��������� ���� ������� ���������� ������
'    On Error Resume Next
'    Application.DoCmd (1312)
'
'Exit Sub
'Tail:
'    '---������� �� ��������� ���������
'    Application.EventsEnabled = True
'End Sub
'
'Public Sub MakeVHoseLine()
''����� ��������� �� ����������� �������� �����
'Dim ShpObj As Visio.Shape
'Dim ShpInd As Integer
'
''---�������� ��������� ������ - ��� �������������� ������� ������ ��� ������� ��������� ������
'    On Error GoTo Tail
'
''---��������� ��������� ������� �����������, �������� ������ � ����� �������� ��������� �������
'    Application.EventsEnabled = False
'    ImportVHoseInformation
'    Application.EventsEnabled = True
'
''---�������������� �������� ������
'    Set ShpObj = Application.ActiveWindow.Selection(1)
'    ShpInd = ShpObj.ID
'
''---�������� ������ ��� ������
'    '---��������� ��������� ��������� ������ �������������
'    ShpObj.Cells("Prop.Unit.Format").FormulaU = ListImport("�������������", "�������������")
''    '---��������� ��������� ��������� ������� ���������� �������
''    ShpObj.Cells("Prop.HoseMaterial.Format").FormulaU = ListImport("�_������", "��������")
''    '---��������� ��������� ��������� ������� ��������� �������
''    HoseDiametersListImport (ShpInd)
''    '---��������� ��������� ��������� �������� ������������� �������
''    HoseResistanceValueImport (ShpInd)
''    '---��������� ��������� ��������� �������� ���������� ����������� �������
''    HoseMaxFlowValueImport (ShpInd)
''    '---��������� ��������� ��������� �������� ����� �������
''    HoseWeightValueImport (ShpInd)
'
''---������������� �������� �������� ������� ��� ������
'    ShpObj.Cells("Prop.LineTime").FormulaU = _
'        "DATETIME(" & Str(ActiveDocument.DocumentSheet.Cells("User.CurrentTime").Result(visDate)) & ")"
'
''---��������� ���� ������� ���������� ������
'    On Error Resume Next
'    Application.DoCmd (1312)
'
'Exit Sub
'Tail:
'    '---������� �� ��������� ���������
'    Application.EventsEnabled = True
'End Sub
'
'Public Sub MakeMagHoseLine()
''����� ��������� � ������������� �������� �����
'Dim ShpObj As Visio.Shape
'Dim ShpInd As Integer
'
''---�������� ��������� ������ - ��� �������������� ������� ������ ��� ������� ��������� ������
'    On Error GoTo Tail
'
''---��������� ��������� ������� �����������, �������� ������ � ����� �������� ��������� �������
'    Application.EventsEnabled = False
'    ImportHoseInformation
'    Application.EventsEnabled = True
'
''---�������������� �������� ������
'    Set ShpObj = Application.ActiveWindow.Selection(1)
'    ShpInd = ShpObj.ID
'
''---�������� ������ ��� ������
'    '---��������� ��������� ��������� ������ �������������
'    ShpObj.Cells("Prop.Unit.Format").FormulaU = ListImport("�������������", "�������������")
'    '---��������� ��������� ��������� ������� ���������� �������
'    ShpObj.Cells("Prop.HoseMaterial.Format").FormulaU = ListImport("�_������", "�������� ������")
'    '---��������� ��������� ��������� ������� ��������� �������
'    HoseDiametersListImport (ShpInd)
'    '---��������� ��������� ��������� �������� ������������� �������
'    HoseResistanceValueImport (ShpInd)
'    '---��������� ��������� ��������� �������� ���������� ����������� �������
'    HoseMaxFlowValueImport (ShpInd)
'    '---��������� ��������� ��������� �������� ����� �������
'    HoseWeightValueImport (ShpInd)
'
''---������������ �������� ��� ������������� �����
'    ShpObj.Cells("Prop.HoseDiameter").FormulaU = "INDEX(2,Prop.HoseDiameter.Format)"
'    ShpObj.Cells("Prop.LineType").FormulaU = "INDEX(1,Prop.LineType.Format)"
'
''---������������� �������� �������� ������� ��� ������
'    ShpObj.Cells("Prop.LineTime").FormulaU = _
'        "DATETIME(" & Str(ActiveDocument.DocumentSheet.Cells("User.CurrentTime").Result(visDate)) & ")"
'
''---��������� ���� ������� ���������� ������
'    On Error Resume Next
'    Application.DoCmd (1312)
'
'Exit Sub
'Tail:
'    '---������� �� ��������� ���������
'    Application.EventsEnabled = True
'End Sub
Private Sub ComBut4_Click(ByVal Ctrl As Office.CommandBarButton, CancelDefault As Boolean)
    NormalizeNRS
End Sub
