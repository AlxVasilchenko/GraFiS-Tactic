Attribute VB_Name = "ManagementFormsUse"
Private c_ManagementTech As c_ManagementTechnics '���������� � ������� ������� ������ �� c_ManagementTechnics
Private c_ManagementStvols As c_ManagementStvols '���������� � ������� ������� ������ �� c_ManagementStvols
Private c_ManagementGDZS As c_ManagementGDZS '���������� � ������� ������� ������ �� c_ManagementGDZS
Private c_ManagementTL As c_ManagementTimeLine '���������� � ������� ������� ������ �� c_ManagementTimeLine



'-----------------------------------------������� ��������----------------------------------------------
'Public Function WindowCheck(ByRef a_WinCaption As String) As Boolean
'Dim wnd As Window
'    On Error GoTo Exc
'
'    Set wnd = Application.ActiveWindow.Windows.ItemEx("������� ������")
'    WindowCheck = True
'    Set wnd = Nothing
'Exit Function
'Exc:
'    WindowCheck = False
'End Function

'------------------------------------------��������� ������ � ������� �����������-------------------------
Public Sub MngmnWndwShow(ShpObj As Visio.Shape)
'��������� ���������� ����� ManagementTechnics
    If c_ManagementTech Is Nothing Then
        Set c_ManagementTech = New c_ManagementTechnics
    Else
        c_ManagementTech.PS_ShowWindow
    End If
    ShpObj.Delete
End Sub
Public Sub MngmnStvolsWndwShow(ShpObj As Visio.Shape)
'��������� ���������� ����� ManagementStvols
    If c_ManagementStvols Is Nothing Then
        Set c_ManagementStvols = New c_ManagementStvols
    Else
        c_ManagementStvols.PS_ShowWindow
    End If
    ShpObj.Delete
End Sub
Public Sub MngmnGDZSWndwShow(ShpObj As Visio.Shape)
'��������� ���������� ����� ManagementGDZS
    If c_ManagementGDZS Is Nothing Then
        Set c_ManagementGDZS = New c_ManagementGDZS
    Else
        c_ManagementGDZS.PS_ShowWindow
    End If
    ShpObj.Delete
End Sub
Public Sub MngmnTimeLineWndwShow(ShpObj As Visio.Shape)
'��������� ���������� ����� ManagementTimeLine
    If c_ManagementTL Is Nothing Then
        Set c_ManagementTL = New c_ManagementTimeLine
    Else
        c_ManagementTL.PS_ShowWindow
    End If
    ShpObj.Delete
End Sub

Public Sub MngmnWndwHide()
'��������� �������� ����� ManagementTechnics
    Set c_ManagementTech = Nothing
End Sub
Public Sub MngmnStvolsWndwHide()
'��������� �������� ����� ManagementStvols
    Set c_ManagementStvols = Nothing
End Sub
Public Sub MngmnGDZSWndwHide()
'��������� �������� ����� ManagementGDZS
    Set c_ManagementGDZS = Nothing
End Sub
Public Sub MngmnTimeLineWndwHide()
'��������� �������� ����� ManagementGDZS
    Set c_ManagementTimeLine = Nothing
End Sub
