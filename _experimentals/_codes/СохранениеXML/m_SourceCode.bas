Attribute VB_Name = "m_SourceCode"
'--------------������ ������� ��������� ��� �������� ���� VBA � ��������� ����� �� ������� ������-------------
'------------------����� ����� ���� ����������� ��������� ��� ����� ������------------------
Public Sub SaveSourceCode()

Dim targetPath As String
    
    targetPath = GetCodePath
    ExportVBA targetPath
    ExportDocState targetPath
    MsgBox "�������� ��� �������������"

End Sub

Public Sub ExportVBA(ByVal sDestinationFolder As String)
'���������� ������� ����
    Dim oVBComponent As Object
    Dim fullName As String

    For Each oVBComponent In Application.ActiveDocument.VBProject.VBComponents
        If oVBComponent.Type = 1 Then
            ' Standard Module
            fullName = sDestinationFolder & oVBComponent.Name & ".bas"
            oVBComponent.Export fullName
        ElseIf oVBComponent.Type = 2 Then
            ' Class
            fullName = sDestinationFolder & oVBComponent.Name & ".cls"
            oVBComponent.Export fullName
        ElseIf oVBComponent.Type = 3 Then
            ' Form
            fullName = sDestinationFolder & oVBComponent.Name & ".frm"
            oVBComponent.Export fullName
        ElseIf oVBComponent.Type = 100 Then
            ' Document
            fullName = sDestinationFolder & oVBComponent.Name & ".bas"
            oVBComponent.Export fullName
        Else
            ' UNHANDLED/UNKNOWN COMPONENT TYPE
        End If
        Debug.Print "�������� " & fullName
    Next oVBComponent

End Sub

Private Function GetCodePath() As String
'���������� ���� � ����� � ��������� ������
Dim path As String
Dim docNameWODot As String
    
    '---���� � ������� �����
    path = Application.ActiveDocument.path
    '---��������� �������� ����� � ������
    path = GetDirPath(path & "_codes")
        
    '---��������� ���� � ����� � ������ ������� ���������
    docNameWODot = Split(Application.ActiveDocument.Name, ".")(0)
    path = GetDirPath(path & "\" & docNameWODot)
    
    GetCodePath = path & "\"
End Function

Private Function GetDirPath(ByVal path As String) As String
'���������� ���� � ����� � ��������� ������, ���� ����� ����� ���, �������������� ������� ��
    '---��������� ���� �� ����� �����, ���� ��� - �������
    If Dir(path, vbDirectory) = "" Then
        MkDir path
    End If
    GetDirPath = path
End Function



'--------------------������ � ���������� ��������� (��������, ������, �������, ����� � �.�.)---------
Private Sub ExportDocState(ByVal sDestinationFolder As String)
'��������� ��������� ��������� � ��������� ����
Dim doc As Visio.Document
Dim docFullName As String

Dim pg As Visio.Page
Dim shp As Visio.Shape
Dim mstr As Visio.Master

'---�������� ������ �� �������� � ������ ���� � ����
    Set doc = Application.ActiveDocument
    docFullName = sDestinationFolder & Replace(doc.Name, ".", "-") & ".txt"
    
'---������� ����, ���� �� ��� ����
    With CreateObject("Scripting.FileSystemObject")
        .CreateTextFile docFullName, True
    End With
    
'---��������� ��������� ���� ����� �������� � ���������
    '---��������
    WriteSheetData doc.DocumentSheet, docFullName, "��������"
    '---��������
    For Each pg In doc.Pages
        WriteSheetData pg.PageSheet, docFullName, pg.Name
        '������
        For Each shp In pg.Shapes
            WriteSheetData shp, docFullName, shp.Name
        Next shp
    Next pg

    '---�������
    For Each mstr In doc.Masters
        WriteSheetData mstr.PageSheet, docFullName, mstr.Name
        For Each shp In mstr.Shapes
            WriteSheetData shp, docFullName, shp.Name
        Next shp
    Next mstr
    
    '---�����
    
    
    '---����� �������
    
    
    '---������� �����
    
    
    '---����� �����
    
    
    Debug.Print "�������� " & docFullName
End Sub

Public Sub WriteSheetData(ByRef sheet As Visio.Shape, ByVal docFullName As String, ByVal printingName As String)
'��������� � ���� �� ������ docFullName ������� ��������� ����� ���������, �������� ��� ������ (�������)
Dim shp As Visio.Shape

'---��������� ���� ��������� ���������
    Open docFullName For Append As #1
    '---���������� ��� �������
    Print #1, ""
    Print #1, "=>sheet: " & printingName
    '---��������� ���� ��������� ���������
    Close #1
    
'---������������ ������ �� ���� ����������������
    '---�����
    SaveSectionState sheet, visSectionAction, docFullName
    SaveSectionState sheet, visSectionAnnotation, docFullName
    SaveSectionState sheet, visSectionCharacter, docFullName
    SaveSectionState sheet, visSectionConnectionPts, docFullName
    SaveSectionState sheet, visSectionControls, docFullName
    SaveSectionState sheet, visSectionFirst, docFullName
    SaveSectionState sheet, visSectionFirstComponent, docFullName
    SaveSectionState sheet, visSectionHyperlink, docFullName
    SaveSectionState sheet, visSectionInval, docFullName
    SaveSectionState sheet, visSectionLast, docFullName
    SaveSectionState sheet, visSectionLastComponent, docFullName
    SaveSectionState sheet, visSectionLayer, docFullName
    SaveSectionState sheet, visSectionNone, docFullName
    SaveSectionState sheet, visSectionParagraph, docFullName
    SaveSectionState sheet, visSectionProp, docFullName
    SaveSectionState sheet, visSectionReviewer, docFullName
    SaveSectionState sheet, visSectionScratch, docFullName
    SaveSectionState sheet, visSectionSmartTag, docFullName
    SaveSectionState sheet, visSectionTab, docFullName
    SaveSectionState sheet, visSectionTextField, docFullName
    SaveSectionState sheet, visSectionUser, docFullName
    '---������ ������
    SaveSectionObjectState sheet, visRowAlign, docFullName
    SaveSectionObjectState sheet, visRowEvent, docFullName
    SaveSectionObjectState sheet, visRowDoc, docFullName
    SaveSectionObjectState sheet, visRowFill, docFullName
    SaveSectionObjectState sheet, visRowForeign, docFullName
    SaveSectionObjectState sheet, visRowGroup, docFullName
    SaveSectionObjectState sheet, visRowHelpCopyright, docFullName
    SaveSectionObjectState sheet, visRowImage, docFullName
    SaveSectionObjectState sheet, visRowLayerMem, docFullName
    SaveSectionObjectState sheet, visRowLine, docFullName
    SaveSectionObjectState sheet, visRowLock, docFullName
    SaveSectionObjectState sheet, visRowMisc, docFullName
    SaveSectionObjectState sheet, visRowPageLayout, docFullName
    SaveSectionObjectState sheet, visRowPage, docFullName
    SaveSectionObjectState sheet, visRowPrintProperties, docFullName
    SaveSectionObjectState sheet, visRowShapeLayout, docFullName
    SaveSectionObjectState sheet, visRowStyle, docFullName
    SaveSectionObjectState sheet, visRowTextXForm, docFullName
    SaveSectionObjectState sheet, visRowText, docFullName
    SaveSectionObjectState sheet, visRowXForm1D, docFullName
    SaveSectionObjectState sheet, visRowXFormOut, docFullName
    
    
    '���� ��������� ������ ����� �������� ������ - ��������� ��������� ���������� � ��� ��� (��������� ������ ��� �����)
    On Error GoTo EX
    If sheet.Shapes.Count > 0 Then
        For Each shp In pg.Shapes
            WriteSheetData shp, docFullName, shp.Name
        Next shp
    End If
    
EX:

End Sub



Private Sub SaveSectionState(ByRef shp As Visio.Shape, ByVal sectID As VisSectionIndices, ByVal docFullName As String)
'��������� � ���� �� ������ docFullName ������� ��������� ��������� ������ ����� ���������, �������� ��� ������ (�������)
'�����
Dim sect As Visio.Section
Dim rwI As Integer
Dim rw As Visio.Row
Dim cllI As Integer
Dim cll As Visio.Cell
Dim str As String
    
    If shp.SectionExists(sectID, 0) = 0 Then Exit Sub
    Set sect = shp.Section(sectID)
    
    '---��������� ���� ��������� ���������
    Open docFullName For Append As #1
    '---���������� ������ ������
    Print #1, "  Section: " & sectID & ">>>"
    
    '---���������� ��� row ������ � ��� ������ �� row ��������� ������ ����������� ���� ���-������� ���� �����. ��� �������, ��� ������ �� ������
    For rwI = 0 To sect.Count - 1
        Set rw = sect.Row(rwI)
        str = "    "
        For cllI = 0 To rw.Count - 1
            Set cll = rw.Cell(cllI)
            If cll.Formula <> "" Then
                str = str & cll.Name & ": " & cll.Formula & "; "
            End If
        Next cllI
        '��������� ������ � ����
        Print #1, str
    Next rwI
    
    '---��������� ���� ��������� ���������
    Close #1
    
Exit Sub
EX:
    Debug.Print "Section ERROR: " & sectID
End Sub

Private Sub SaveSectionObjectState(ByRef shp As Visio.Shape, ByVal rowID As VisRowIndices, ByVal docFullName As String)
'��������� � ���� �� ������ docFullName ������� ��������� ����� ���������, �������� ��� ������ (�������)
'!!!��� ������ ������!!!
Dim sect As Visio.Section
Dim rw As Visio.Row
Dim cllI As Integer
Dim cll As Visio.Cell
Dim str As String
    
    If shp.RowExists(visSectionObject, rowID, 0) = 0 Then Exit Sub
    Set sect = shp.Section(visSectionObject)
    
    '---��������� ���� ��������� ���������
    Open docFullName For Append As #1
    '---���������� ������ ������
    Print #1, "  ObjectRow: " & rowID & ">>>"
    
    '---���������� ��� row ������ � ��� ������ �� row ��������� ������ ����������� ���� ���-������� ���� �����. ��� �������, ��� ������ �� ������
    Set rw = sect.Row(rowID)
    If rw.Count > 0 Then
        str = "    "
        For cllI = 0 To rw.Count - 1
            Set cll = rw.Cell(cllI)
            If cll.Formula <> "" Then
                str = str & cll.Name & ": " & cll.Formula & "; "
            End If
        Next cllI
        '��������� ������ � ����
        Print #1, str
    End If
    
    '---��������� ���� ��������� ���������
    Close #1
    
Exit Sub
EX:
    Debug.Print "Section Oject ERROR: " & sectID & ", rowID: " & rowID
End Sub
