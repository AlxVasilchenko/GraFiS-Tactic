Attribute VB_Name = "Exchange"
'------------------------������ ��� �������� ������� ���-------------------
'-----------------------------------����������� ����-------------------------------------------------
Public Sub GetTTH(ShpIndex As Long)
'����������� ��������� ������� ��� �����������
'---��������� ����������
Dim shp As Visio.Shape
Dim IndexPers As Integer

'---��������� � ����� ������ ������ ��������� ������ ������
    Set shp = Application.ActivePage.Shapes.ItemFromID(ShpIndex)
    IndexPers = shp.Cells("User.IndexPers")
    
'---��������� ��������� ��������� �������������� ������ ������(�����) ��� ������� ������
Select Case IndexPers
    Case Is = 1
        GetValuesOfCellsFromTable ShpIndex, "�_������������"
    Case Is = 2
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 3
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 4
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 5
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 6
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 7
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 8
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 9
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 10
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 11
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 12
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 13
        GetValuesOfCellsFromTable ShpIndex, "�_����"
    Case Is = 14
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 15
        GetValuesOfCellsFromTable ShpIndex, "�_�����"
    Case Is = 16
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 17
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 18
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 19
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 20
        GetValuesOfCellsFromTable ShpIndex, "�_��"
    Case Is = 161
        GetValuesOfCellsFromTable ShpIndex, "�_���"
    Case Is = 162
        GetValuesOfCellsFromTable ShpIndex, "�_����"
    Case Is = 163
        GetValuesOfCellsFromTable ShpIndex, "�_���"
        
        
        
End Select



End Sub


