Attribute VB_Name = "m_FormProcs"
Option Compare Database

Public Sub sP_ControlsBlockChange(ass_FormName As String)
'��������� ����������-������������� ��������� ���������� � ������
Dim vo_Field As control
Dim vo_CurForm As Access.Form

'---���������� ������� ����� ��� ������ � ���
    Set vo_CurForm = Application.Forms(ass_FormName)

'---���������� ��� �������� ���������� � �����
    For Each vo_Field In vo_CurForm.Controls
        If vo_Field.ControlType = acComboBox Or vo_Field.ControlType = acTextBox _
                Or vo_Field.ControlType = acCheckBox Then       '���� ������� ���������� �������� ����� ��� ���������� ������� ��� �������
            vo_Field.Locked = Not vo_CurForm.Controls("�_�������������������").Value        '�������� ��������� ���������� �������� � ������������ � ���������� �����������
        End If
    Next vo_Field
    
End Sub
