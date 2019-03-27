Attribute VB_Name = "m_dataImport"
Option Compare Database

Public Sub BaseDataImport()
'��������� ����� �������
Dim aStr_Path As String
Dim vObj_FD  'As Application.FileDialog

'---��������� ���������� ������������� ����
    Set vObj_FD = Application.FileDialog(1)
    With vObj_FD
        .Filters.Clear
        .AllowMultiSelect = False
        .Filters.Add "���� ������ ������", "*.fdb"
        .Show
        If .SelectedItems.Count = 0 Then Exit Sub
        aStr_Path = .SelectedItems(1)
    End With

    MainImportProc aStr_Path
    
End Sub

Private Sub MainImportProc(ByVal outerDBPath As String)
'������� ����� ������� ������
Dim thisDB As Database
Dim outerDB As Database
    
    '��������� ��������
'    Exit Sub

    
    Set thisDB = CurrentDb
    Set outerDB = DBEngine.OpenDatabase(outerDBPath)
    
    '������ �������
    ImportDataLists thisDB, outerDB, "������", "�����"
    ImportDataLists thisDB, outerDB, "���� ����������", "���������"
    ImportDataLists thisDB, outerDB, "���� �������", "�����"
    ImportDataLists thisDB, outerDB, "���� �����", "�����"
    ImportDataLists thisDB, outerDB, "�������", "�����������"
    
    '������ �������
    ImportDataTechnics thisDB, outerDB, "������������", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "����", "������"
    ImportDataTechnics thisDB, outerDB, "�����", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "����", "������"
    ImportDataTechnics thisDB, outerDB, "����", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "��", "������"
    ImportDataTechnics thisDB, outerDB, "���������", "������"
    ImportDataTechnics thisDB, outerDB, "���������� ������", "������"
    ImportDataTechnics thisDB, outerDB, "���������", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "���", "������"
    ImportDataTechnics thisDB, outerDB, "������", "���������"
    ImportDataTechnics thisDB, outerDB, "��������", "������"
    ImportDataTechnics thisDB, outerDB, "����", "������"
    
    '����
    ImportDataCommon thisDB, outerDB, "����", "������"
    ImportDataCommon thisDB, outerDB, "����", "������"
    
    '��������
    ImportDataCommon thisDB, outerDB, "��������", "������"
    
    '������
    ImportDataHoses thisDB, outerDB, "������", "��������", "�������"
    
    '����������
'    ImportDataWater thisDB, outerDB, "�������� ���������", "������� ��������", "�����������"
'    ImportDataWater thisDB, outerDB, "����������", "����� � ����", "�����������"
    
    '������
'    ImportDataCommon thisDB, outerDB, "�������������", "������ ������"
'    ImportDataNozzle thisDB, outerDB, "������", "��������", "�������"
    
    
    
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
'    ImportDataTechnics thisDB, outerDB, "", "������"
    

    MsgBox "������ ������� �������������!"



End Sub

Private Sub ImportDataTechnics(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "='" & rstOuter.Fields(keyFieldName1) & "' And " & _
            "[�����] =" & GetKeyFieldValue(dbThis, dbOuter, "������", "���������", "�����", rstOuter.Fields("�����").Value)
        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "�����" Then
                    fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "������", "���������", "�����", fldOuter.Value)
                ElseIf fldOuter.Name = "�����" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "���� �������", "���������", "�����", fldOuter.Value)
                    End If
                ElseIf fldOuter.Name = "�����" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "���� �����", "��������", "�����", fldOuter.Value)
                    End If
                ElseIf fldOuter.Name = "���������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "���� ����������", "������������", "���������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub

Private Sub ImportDataHoses(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String, ByVal keyFieldName2 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "=" & rstOuter.Fields(keyFieldName1) & " And " & _
            "[" & keyFieldName2 & "] =" & rstOuter.Fields(keyFieldName2)
        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "�������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "�������� �������", "�����������", "������� �������", fldOuter.Value)
                    End If
                ElseIf fldOuter.Name = "��������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "��������� �������", "�������������������", "�������� ������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub

Private Sub ImportDataWater(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String, ByVal keyFieldName2 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "=" & rstOuter.Fields(keyFieldName1) & " And " & _
            "[" & keyFieldName2 & "] =" & rstOuter.Fields(keyFieldName2)
        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "�������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "�������� �������", "�����������", "������� �������", fldOuter.Value)
                    End If
                ElseIf fldOuter.Name = "��������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "��������� �������", "�������������������", "�������� ������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub

Private Sub ImportDataNozzleVariants(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String, ByVal keyFieldName2 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "='" & rstOuter.Fields(keyFieldName1) & "' And " & _
            "[���������������] =" & GetKeyFieldValue(dbThis, dbOuter, "�������������", "���������������", "������ ������", rstOuter.Fields("���������������").Value)

        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "���������������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "�������������", "���������������", "������ ������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub

Private Sub ImportDataNozzleStrui(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String, ByVal keyFieldName2 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "='" & rstOuter.Fields(keyFieldName1) & "' And " & _
            "[�����������������] =" & GetKeyFieldValue(dbThis, dbOuter, "���������������", "�����������������", "������� ������", rstOuter.Fields("�����������������").Value)

        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "�����������������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "���������������", "�����������������", "������� ������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub

Private Sub ImportDataNozzlePodOuts(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String, ByVal keyFieldName2 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "='" & rstOuter.Fields(keyFieldName1) & "' And " & _
            "[��������] =" & GetKeyFieldValue(dbThis, dbOuter, "���������", "��������", "��� �����", rstOuter.Fields("��������").Value)

        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "��������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "���������", "��������", "�����������������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub

Private Sub ImportDataCommon(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String)
'����� ������� ������ ��� ��������� ������������ �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ �� ���������� ��
        criteria = keyFieldName1 & "='" & rstOuter.Fields(keyFieldName1) & "'"
        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                
                If fldOuter.Name = "������" Then
                    If Not IsNull(fldOuter.Value) Then
                        fldThis.Value = GetKeyFieldValue(dbThis, dbOuter, "�������", "����������", "�����������", fldOuter.Value)
                    End If
                Else
                    fldThis.Value = fldOuter.Value
                End If
            Next i
            rstThis.Update
        End If
        
        
        rstOuter.MoveNext
    Loop

    
    
End Sub


Private Sub ImportDataLists(ByRef dbThis As Database, ByRef dbOuter As Database, _
        ByVal tableName As String, ByVal keyFieldName1 As String)
'����� ������� ������ ��� ��������� ������������� �������
Dim rstThis As Recordset
Dim rstOuter As Recordset
Dim fldThis As Field
Dim fldOuter As Field
Dim i As Integer
Dim criteria As String
Dim needUpdate As Boolean
    
    Set rstThis = dbThis.OpenRecordset(tableName, dbOpenDynaset)
    Set rstOuter = dbOuter.OpenRecordset(tableName, dbOpenDynaset)
    
    rstOuter.MoveFirst
    Do Until rstOuter.EOF
        '�������� ������� �� �������������� ������ � ����������� ��
        criteria = keyFieldName1 & "='" & rstOuter.Fields(keyFieldName1) & "'"
        rstThis.FindFirst criteria
        If rstThis.NoMatch Then
            '���� ��� - �������
            rstThis.AddNew
            needUpdate = True
        Else
            '���� �� - ��������� ���������� �� ��������� ������ � ���� ��, ���������
            needUpdate = NeedToUpdate(rstThis, rstOuter)
            rstThis.Edit
        End If
        
        '���� ������ ����� ���������, ��� ������� �����������, ����������� ������
        If needUpdate Then
            For i = 1 To rstOuter.Fields.Count - 1
                Set fldOuter = rstOuter.Fields(i)
                Set fldThis = rstThis.Fields(fldOuter.Name)
                    fldThis.Value = fldOuter.Value
            Next i
            rstThis.Update
        End If
        
        rstOuter.MoveNext
    Loop


End Sub



Private Function NeedToUpdate(ByRef rstThis As Recordset, ByRef rstOuter As Recordset) As Boolean
'������� ���������� ������, ���� ����� ���������, � ����, ���� ���
Dim fldChangedThis As Field
Dim fldChangedOuter As Field

    On Error GoTo EX

    Set fldChangedThis = rstThis.Fields("��������")
    Set fldChangedOuter = rstOuter.Fields("��������")
    
    If fldChangedThis.Value < fldChangedOuter.Value Then
        NeedToUpdate = True
    Else
        NeedToUpdate = False
    End If
    
Exit Function
EX:
    NeedToUpdate = False
End Function

Private Function GetKeyFieldValue(ByRef dbThis As Database, ByRef dbOuter As Database, _
                    ByRef keyTableName As String, ByVal keyFieldName As String, _
                    ByVal textFieldName As String, ByVal textFieldValue As String) As Integer
'������� ���������� �������� �������� ����� ��� ��������� ������� � ���������� ���������� ��������
Dim rstTable As Recordset
Dim rstOuterTable As Recordset
Dim textValue As String
    
'    If textFieldValue = "" Then
'        Exit Function
'    End If
    
    Set rstOuterTable = dbOuter.OpenRecordset(keyTableName, dbOpenDynaset)
    rstOuterTable.FindFirst "[" & keyFieldName & "]=" & textFieldValue
    textValue = rstOuterTable.Fields(textFieldName).Value
    
    Set rstTable = dbThis.OpenRecordset(keyTableName, dbOpenDynaset)
    
    rstTable.FindFirst "[" & textFieldName & "]='" & textValue & "'"
'    If rstTable.NoMatch Then
'        rstTable.AddNew
'        rstTable.Fields(textFieldName).Value = textValue
'        rstTable.Update
'    End If
    
    GetKeyFieldValue = rstTable.Fields(keyFieldName).Value
    
Set rstTable = Nothing
End Function
