Attribute VB_Name = "m_BaseProcs"
Option Compare Database


Public Sub PS_SplashFormShow(ByVal control As IRibbonControl)
'��������� ������ �������� - ��� ������ �� �����
'---�������� ��������� �������� ���� "���������� ��������" �� ����
    pS_ChangeShowPropertyFalse
    
'---���������� ��������
    DoCmd.OpenForm "��������", acNormal

End Sub

Public Sub PS_NavFormShow(ByVal control As IRibbonControl)
'��������� ������ ����� ��������� - ��� ������ �� �����
'---���������� ����� ���������
    DoCmd.OpenForm "���������", acNormal

End Sub

Public Sub PS_Import(ByVal control As IRibbonControl)
'��������� ������� ������ - ��� ������ �� �����
'---��������� ����� ������� ������
    BaseDataImport

End Sub

Public Sub PS_HelpShow(ByVal control As IRibbonControl)
'��������� ������ ������� - ��� ������ �� �����
'---���������� �������
    Dim f_pth As String
    
    f_pth = "hh.exe " & Application.CurrentProject.path & "\" & "������-�������.chm"
    Shell f_pth, vbNormalFocus

End Sub

Public Sub PS_CopyToAnotherSet(ByVal control As IRibbonControl)
'��������� ����������� ������ � ������ ����� - ��� ������ �� �����
'---���������� �������
    Dim f_pth As String
    
'    CopyRecordToSet
    DoCmd.OpenForm "����� ������"
End Sub




'---------------------------------------��������� ���������--------------------------------------------------
Private Sub pS_ChangeShowPropertyFalse()
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
        !������������� = False                      '�������� �������� �� ������
        .Update                                    '��������� ��������
    End With
    
'---��������� ��� �������
   vO_rst.Close
   Set vO_dbs = Nothing
End Sub

Public Sub CopyRecordToSet(ByVal ttxSet As Integer)
'����� �������� ������ ������� ������ � ����� � ����� �����
Dim frm As Access.Form
Dim rst As Recordset
Dim recordData() As Variant
Dim fld As Field
Dim i As Integer
   
    Set frm = Application.Screen.ActiveForm
    Set rst = frm.Recordset
    
    ReDim recordData(rst.Fields.Count - 1)
    
'---��������� �������� �������
    frm.Controls("���_�����").Requery
    
'---��������� ����� ������ ��� ������������ ������������
    For i = 1 To rst.Fields.Count - 1
        Set fld = rst.Fields(i)
        recordData(i - 1) = fld.Value
    Next i
    
'---������� ����� ������ � ��������� �� �������
    rst.AddNew
    For i = 0 To UBound(recordData) - 1
        Set fld = rst.Fields(i + 1)
        If fld.Name = "�����" Then
            fld.Value = ttxSet
        Else
            fld.Value = recordData(i)
        End If
        
    Next i
    rst.Update
    frm.Refresh
    
'---���� ������������ ����������� ������� ���������� ���������
    frm.Controls("�_�������������������").Value = True
    sP_ControlsBlockChange (frm.Name)
    
End Sub
