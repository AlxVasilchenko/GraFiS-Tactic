Attribute VB_Name = "m_grid"
Option Explicit

'------------------------������ ��� �������� �������� ��������� ������� �����-------------------

Public Sub DropGridMain(ShpObj As Visio.Shape)
'��������� ���������� ������������ �����
On Error GoTo EX

    InsertGridForm.TB_X.Text = ShpObj.Cells("PinX").Result(visMillimeters)
    InsertGridForm.TB_Y.Text = ShpObj.Cells("PinY").Result(visMillimeters)
    InsertGridForm.Show

EX:
    ShpObj.Delete
End Sub

