VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisDocument"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True

Private ButEvent As c_Buttons

Private Sub Document_DocumentOpened(ByVal doc As IVDocument)
    OpenDoc
End Sub


Private Sub Document_BeforeDocumentClose(ByVal doc As IVDocument)
    CloseDoc
End Sub


Private Sub OpenDoc()
'---���������� ���� �������
    Application.ActiveWindow.Windows.ItemFromID(visWinIDCustProp).Visible = True
    
'---����������� �������
    sp_MastersImport
    
'---������� ������ ���������� "�����������" � ��������� �� ��� ������
    AddTB_Constructions
    AddButtons
    
'---���������� ������ ������������ ������� ������
    Set ButEvent = New c_Buttons
    
'---��������� ������� ����������
    fmsgCheckNewVersion.CheckUpdates
End Sub

Private Sub CloseDoc()
'������������ �������� ���������

'---������������ ������ ������������ ������� ������
    Set ButEvent = Nothing
    
'---������� ������ ���������� "�����������"
    RemoveTB_Constructions
End Sub


Private Sub sp_MastersImport()
'---����������� �������

'---������� 1:200
    MasterImportSub "�����������.vss", "�����"
    MasterImportSub "�����������.vss", "�����2"
    MasterImportSub "�����������.vss", "�����3"
    MasterImportSub "�����������.vss", "�����4"
    MasterImportSub "�����������.vss", "���������"
    MasterImportSub "�����������.vss", "���������2"
    MasterImportSub "�����������.vss", "�����"
    MasterImportSub "�����������.vss", "���"
    MasterImportSub "�����������.vss", "������"
    MasterImportSub "�����������.vss", "��������������"
'---������� 1:1000
    MasterImportSub "�����������.vss", "�����_1000"
    MasterImportSub "�����������.vss", "�����2_1000"
    MasterImportSub "�����������.vss", "�����3_1000"
    MasterImportSub "�����������.vss", "�����4_1000"
    MasterImportSub "�����������.vss", "���������_1000"
    MasterImportSub "�����������.vss", "���������2_1000"
    
End Sub




'Public Sub TestOpen()
'    OpenDoc
'End Sub
'
'Public Sub TestClose()
'    CloseDoc
'End Sub
