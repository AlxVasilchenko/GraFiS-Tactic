Attribute VB_Name = "Tools"
Option Compare Database

'----------------------��������� �����������-----------------------
#If VBA7 Then
    Private Declare PtrSafe Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" ( _
                    ByVal Hwnd As Long, _
                    ByVal lpOperation As String, _
                    ByVal lpFile As String, _
                    ByVal lpParameters As String, _
                    ByVal lpDirectory As String, _
                    ByVal nShowCmd As Long) As Long
#Else
    Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" ( _
                    ByVal Hwnd As Long, _
                    ByVal lpOperation As String, _
                    ByVal lpFile As String, _
                    ByVal lpParameters As String, _
                    ByVal lpDirectory As String, _
                    ByVal nShowCmd As Long) As Long
#End If



Public Sub GotoWF(strMain As String, strAlt As String)
Const SW_SHOWNORMAL = 1
    
    '�������� ����� ����� �� ������ �������������, ��� ������������ ������
    strAlt = Replace(strAlt, "/", "_")
    
    If Len(strMain) > 0 Then
        If InStr(1, strMain, "wiki-fire.org") = 0 Then Exit Sub '���� � ������� ������ ��� �������� �� wiki-fire.org - ���������� ����� �� ��������� - ����� �������� ������ �� ��������� wiki-fire.org
        ShellExecute 0&, "Open", strMain, _
                vbNullString, vbNullString, SW_SHOWNORMAL
    Else
        ShellExecute 0&, "Open", "http://wiki-fire.org/" & strAlt & ".ashx", _
                vbNullString, vbNullString, SW_SHOWNORMAL
    End If
End Sub
