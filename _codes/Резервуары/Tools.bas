Attribute VB_Name = "Tools"



'-----------------------------------------��������� ������ � ��������----------------------------------------------
Public Sub SetCheckForAll(ShpObj As Visio.Shape, aS_CellName As String, aB_Value As Boolean)
'��������� ������������� ����� �������� ��� ���� ��������� ����� ������ ����
Dim shp As Visio.Shape
    
    '���������� ��� ������ � ��������� � ���� ��������� ������ ����� ����� �� ������ - ����������� �� ����� ��������
    For Each shp In Application.ActiveWindow.Selection
        If shp.CellExists(aS_CellName, 0) = True Then
            shp.Cells(aS_CellName).Formula = aB_Value
        End If
    Next shp
    
End Sub
