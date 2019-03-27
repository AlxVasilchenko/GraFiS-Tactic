Attribute VB_Name = "LinksRefresh"
Option Compare Database

Private Sub s_TableLinksRefresh(ass_BaseName As String)
'��������� ������������ ���� ������

'---��������� ����������
Dim db As DAO.Database
Dim td As DAO.TableDef
Dim vss_CurPath As String
Dim vss_ConnectionString As String
Dim vss_ConnectionStringAlter As String
Dim vsO_tdfsCur As DAO.TableDefs

'---����������� ����������� ��� ������ ����������
vss_CurPath = Application.CurrentProject.path & "\" & "Signs.fdb"
vss_ConnectionString = ";DATABASE=" & vss_CurPath
Set db = CurrentDb
Set vsO_tdfsCur = db.TableDefs

''---������������� �������������� ������ ����������� ��� �� SRVC.mdb - ����� ��� ������� �������������
'vss_CurPath = Application.CurrentProject.Path & "\" & "Srvc.mdb"
'vss_ConnectionStringAlter = ";DATABASE=" & vss_CurPath

'---��������� ���� �����������
For Each td In db.TableDefs
    If td.Attributes = dbAttachedTable Then
        td.Connect = vss_ConnectionString '�������������� � ������ ��������������
        td.RefreshLink
    End If
Next td

'---��������� ���������� � ����� ������
vsO_tdfsCur.Refresh
db.Close
End Sub


Public Function PF_LinkCheck()
'������� �������� ����������������� ������� ����������� ������ ��

'---��������� ����������
Dim vo_db_CurrentDataBase As DAO.Database
Dim vs_NeededLink As String

'---����������� ���������� ����������� ��� ������
Set vo_db_CurrentDataBase = CurrentDb
vs_NeededLink = ";DATABASE=" & Application.CurrentProject.path & "\Signs.fdb"

'---��������� ������������� �� ������ ����������� ������� "��" �������� ������������� ��������� ���� ������ (SignsNew.mdb)
If Not vs_NeededLink = vo_db_CurrentDataBase.TableDefs("��").Connect Then
    s_TableLinksRefresh ("SignsNew.mdb") '���� �� �������������, �� ���������������� ��� ���������������� �������
End If

'---��������� ����� � ����� ������
vo_db_CurrentDataBase.Close
End Function



