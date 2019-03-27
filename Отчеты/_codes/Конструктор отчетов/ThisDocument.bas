VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisDocument"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
Private WithEvents ButEvent As Office.CommandBarButton
Attribute ButEvent.VB_VarHelpID = -1




Private Sub ButEvent_Click(ByVal Ctrl As Office.CommandBarButton, CancelDefault As Boolean)
'��������� ������������ �� ������� ������ "������� �����"
'---��������� - ������� �� ������ �����
    If ActiveWindow.Selection.Count > 1 Then
        sP_MakeReport
    Else
        MsgBox "�� ������� ������ ����� ��� ���������� � �����!"
    End If
End Sub

Private Sub Document_DocumentOpened(ByVal doc As IVDocument)
'---������� ������ ���������� "������" � ��������� �� ��� ������ "������� �����"
    AddTBReport
    AddButtonMakeReport
    Set ButEvent = Application.CommandBars("������").Controls("������� �����")
    
End Sub

Private Sub Document_BeforeDocumentClose(ByVal doc As IVDocument)
'---������� ������ ButEvent � ������� ������ "�����" � ������ ���������� "�����������"
    Set ButEvent = Nothing
    DeleteButtonReport
    RemoveTBReport
    
End Sub
