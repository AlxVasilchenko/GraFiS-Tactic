Attribute VB_Name = "m_ToolBarColorShem"
Option Explicit
'--------------------------------������ ��� ���������� ������ ������������ ��������� - �������� �����----------------------------


Public Sub AddTBColorShem()
'��������� ���������� ������ ���������� "�������� �����"-------------------------------
Dim i As Integer

'---��������� ���������� � ����������--------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String
    
'---��������� ���� �� ��� ������ ���������� "�������� �����"------------------------------
'    For i = 1 To Application.CommandBars.Count
'        If Application.CommandBars(i).Name = "�������� �����" Then Exit Sub
'    Next i

'---������� ������ ���������� "�������� �����"--------------------------------------------
    Set Bar = Application.CommandBars.Add(Position:=msoBarRight, Temporary:=True)
    With Bar
        .Name = "�������� �����"
        .Visible = True
    End With

End Sub

Public Sub RemoveTBColorShem()
'��������� �������� ������ ���������� "�������� �����"-------------------------------
    Application.CommandBars("�������� �����").Delete
End Sub

Public Sub AddButtonRefresh()
'��������� ���������� ����� ������ �� ������ ���������� "�������� �����"--------------

'---��������� ���������� � ����������--------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String

    Set Bar = Application.CommandBars("�������� �����")

'---��������� ������ �� ������ ���������� "�������� �����"--------------------------------
'---������ "�������� �������� �����"-------------------------------------------------
    Set Button = Bar.Controls.Add(Type:=msoControlButton)
    With Button
        .Caption = "��������"
        .Tag = "Refresh"
        .TooltipText = "�������� �������� �����"
'        .FaceID = Visio.visIconIXCUSTOM_BOX
        .FaceID = 625
    End With
    Set Button = Nothing

Set Bar = Nothing
End Sub


Public Sub DeleteButtonRefresh()
'---��������� �������� ������ "�������� �������� �����" � ������ ���������� "�������� �����"--------------

'---��������� ���������� � ����������-------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String

    Set Bar = Application.CommandBars("�������� �����")
'---�������� ������ "������� �����" �� ������ ���������� "������"------------------------
    Set Button = Bar.Controls("��������")
    Button.Delete

    
Set Button = Nothing
Set Bar = Nothing
End Sub


'-----------------------------������� ������------------------------------------------

Public Sub AddButtonColorDrop()
'��������� ���������� ����� ������ �� ������ ���������� "�������� �����"--------------

'---��������� ���������� � ����������--------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String

    Set Bar = Application.CommandBars("�������� �����")

'---��������� ������ �� ������ ���������� "�������� �����"--------------------------------
'---������ "�������� �������� �����"-------------------------------------------------
    Set Button = Bar.Controls.Add(Type:=visCtrlTypeSPLITBUTTON, ID:=1692)
'    Set Button = Application.CommandBars("�������� �����").Controls("����")
    With Button
        .Caption = "����"
        .Tag = "ColorDrop"
        .TooltipText = "�����"
'        .FaceID = Visio.visIconIXCUSTOM_BOX
        .FaceID = 3
    End With

    Set Button = Nothing

Set Bar = Nothing
End Sub


Public Sub DeleteButtonColor()
'---��������� �������� ������ "�������� �������� �����" � ������ ���������� "�������� �����"--------------

'---��������� ���������� � ����������-------------------------------------------------
    Dim Bar As CommandBar, Button As CommandBarButton
    Dim DocPath As String

    Set Bar = Application.CommandBars("�������� �����")
'---�������� ������ "������� �����" �� ������ ���������� "������"------------------------
    Set Button = Bar.Controls("����")
    Button.Delete

    
Set Button = Nothing
Set Bar = Nothing
End Sub


Public Sub Prov()
    AddButtonColorDrop '�������


End Sub

Public Sub DeProv()
    DeleteButtonColor '�������


End Sub




