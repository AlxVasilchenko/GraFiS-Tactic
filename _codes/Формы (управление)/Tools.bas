Attribute VB_Name = "Tools"




Public Function CallToStr(ByVal a_Call As String) As String
'������� �������� ������ � ��������, � ���� �� ����� �������� � ����� - ��������, ���������� ��������� ��������
On Error Resume Next
    a_Call = Int(a_Call)
    CallToStr = a_Call
End Function

