Attribute VB_Name = "m_FireShapeInsert"
Option Explicit
'--------------------------------------������ ������������������ ������� �� ��������� ������----------------------
'Public pcm_ShapeForm As F_InsertFire


Public Sub Sm_ShapeFormShow(ShpObj As Visio.Shape)
'��������� ��������� ����� ���������� �������� ������� � ������������ � ��������� ������������

    On Error GoTo EX
'---���������� ��������� �������� �����
'    F_InsertFire.TB_Time.Value = ShpObj.Cells("Prop.FireTime").ResultStr(visDate)
    F_InsertFire.TB_Time.value = ActiveDocument.DocumentSheet.Cells("User.CurrentTime").ResultStr(0)
    F_InsertFire.TB_Duration.value = DateDiff("n", ActiveDocument.DocumentSheet.Cells("User.FireTime").Result(visDate), _
                                        ActiveDocument.DocumentSheet.Cells("User.CurrentTime").Result(visDate))
    F_InsertFire.TB_Radius.value = Round(ShpObj.Shapes.item(4).Cells("Width").Result(visMeters), 2)

'---��������� ������� �����, � ����� ID ������  ��� ������
    F_InsertFire.Vfl_TargetShapeID = ShpObj.ID

'---��������� ������� �����, ��������� ����
    F_InsertFire.VmD_TimeStart = ActiveDocument.DocumentSheet.Cells("User.FireTime").Result(visDate)
    F_InsertFire.FireTime.Caption = "������ ������: " & ActiveDocument.DocumentSheet.Cells("User.FireTime").ResultStr(0)

'---���������� �����
    F_InsertFire.Show

Exit Sub
EX:
    MsgBox "� ���� ���������� ��������� ��������� ������! ���� ��� ����� ����������� - ���������� � ������������."
    SaveLog Err, "Sm_ShapeFormShow"
End Sub
