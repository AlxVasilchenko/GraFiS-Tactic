Attribute VB_Name = "m_ToolBarReport"
Option Explicit
'--------------------------------������ ��� ���������� ������ ������������ ��������� - ������----------------------------


Public Sub AddTBReport()
'��������� ���������� ������ ���������� "������"-------------------------------
Dim i As Integer

'---��������� ���������� � ����������--------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String
    
'---��������� ���� �� ��� ������ ���������� "������"------------------------------
    For i = 1 To Application.CommandBars.Count
        If Application.CommandBars(i).Name = "������" Then Exit Sub
    Next i

'---������� ������ ���������� "�����������"--------------------------------------------
    Set Bar = Application.CommandBars.Add(Position:=msoBarRight, Temporary:=True)
    With Bar
        .Name = "������"
        .Visible = True
    End With

End Sub

Public Sub RemoveTBReport()
'��������� ���������� ������ ���������� "������"-------------------------------
    Application.CommandBars("������").Delete
End Sub

Public Sub AddButtonMakeReport()
'��������� ���������� ����� ������ �� ������ ���������� "�����������"--------------

'---��������� ���������� � ����������--------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String

    Set Bar = Application.CommandBars("������")
'    DocPath = Application.Documents("������.vss").Path

'---��������� ������ �� ������ ���������� "�����������"--------------------------------
'---������ "�������� � �������� �����"-------------------------------------------------
    Set Button = Bar.Controls.Add(Type:=msoControlButton)
    With Button
        .Caption = "������� �����"
        .Tag = "Report"
        .TooltipText = "������������ ����� ������"
        .FaceID = Visio.visIconIXCUSTOM_BOX
    End With
    Set Button = Nothing

Set Bar = Nothing
End Sub


Public Sub DeleteButtonReport()
'---��������� �������� ������ "������� �����" � ������ ���������� "������"--------------

'---��������� ���������� � ����������-------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String

    Set Bar = Application.CommandBars("������")
'---�������� ������ "������� �����" �� ������ ���������� "������"------------------------
    Set Button = Bar.Controls("������� �����")
    Button.Delete

    
Set Button = Nothing
Set Bar = Nothing
End Sub

