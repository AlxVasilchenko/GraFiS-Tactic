VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_��������"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database


Private Sub Form_Close()
    If Me.�_������������.Value = True Then
        pS_ChangeShowProperty
    End If

'---���������� ����� "���������"
    DoCmd.OpenForm "���������", acNormal
End Sub

Private Sub Form_Load()
Dim vss_NotShowSplash, vss_Version, vss_Author As String
'Dim vss_Version As String

'--��������� �������� � ���������� �� ��������
'---��������� �������� �������� "�� ���������� ��������"
    vss_NotShowSplash = DFirst("�������������", "SRVC", "[��������] = 'SplashNotShow'")
    Me.�_������������.Value = vss_NotShowSplash
'---��������� �������� �������� "������"
    vss_Version = "v " & DFirst("�������������", "SRVC", "[��������] = 'Version'")
    Me.�_������.Value = vss_Version
'---��������� �������� �������� "�����"
'    vss_Author = "����� ���� � �����������: " & DFirst("�������������", "SRVC", "[��������] = 'Author'")
'    Me.�_�����.Caption = vss_Author
    
    
'---���� �������� �������� "�� ���������� ��������" = True, �������� ��������
    If vss_NotShowSplash = True Then DoCmd.Close acForm, "��������"
        
End Sub

Private Sub �_�����_Click()
    DoCmd.Close acForm, "��������"
End Sub

Private Sub �������14_Click()
    DoCmd.Close acForm, "��������"
End Sub

Private Sub �������2_Click()
    DoCmd.Close acForm, "��������"
End Sub

Private Sub �������������_Click()
'��������� ������� �� ������ ����� ������� ����
    DoCmd.Close acForm, "��������"
End Sub

Private Sub pS_ChangeShowProperty()
'��������� ��������� �������� ���������� �������� ���� "���������� ��������"
'---��������� ����������
Dim vO_dbs As Database
Dim vO_rst As Recordset


'---���������� ������� ���������
    Set vO_dbs = CurrentDb
    Set vO_rst = vO_dbs.OpenRecordset("SRVC", dbOpenDynaset)
    
'---������� ����������� ������ � �������� �
    With vO_rst
        .FindFirst "[��������] = 'SplashNotShow'"
        .Edit                                      '��������� ��������������.
        !������������� = True                      '�������� �������� �� ������
        .Update                                    '��������� ��������
    End With
    
'---��������� ��� �������
   vO_rst.Close
   Set vO_dbs = Nothing
End Sub

