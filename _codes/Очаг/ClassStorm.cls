VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ClassStorm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public WithEvents ComBut2 As Office.CommandBarButton
Attribute ComBut2.VB_VarHelpID = -1


Private Sub Class_Initialize()
    Set ComBut2 = Application.CommandBars("�����������").Controls("�����")
End Sub

Private Sub Class_Terminate()
    Set ComBut2 = Nothing
End Sub

Private Sub ComBut2_Click(ByVal Ctrl As Office.CommandBarButton, CancelDefault As Boolean)

    On Error GoTo EX
'---��������� �������� �� ������ - ���� �������� - ���������
    If Ctrl.State = msoButtonDown Then
        Ctrl.State = msoButtonUp
        Exit Sub
    End If

    If Ctrl.State = msoButtonUp Then
        If IsSelectedOneShape(False) Then
        '---���� ������� ���� ���� ������ - �������� �� ��������
            If IsHavingUserSection(True) And IsSquare(True) Then
            '---�������� � �������� �����
                MorphToStorm
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

Public Sub MorphToStorm()

    On Error GoTo EX
'---��������� ������� �� ����������� ��������� ������
'    If Not CheckSquareShape Then
'    '---�������� ������
'        PS_CheckButtons ComBut2
'        Exit Sub
'    End If
    
'---��������� ��������� ��������� ��������� ������ � �������� �����
    ImportStormInformation
    
Exit Sub
EX:
    SaveLog Err, "MorphToStorm"
End Sub
