VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_��_�������������������������"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database

Private Sub Form_BeforeUpdate(Cancel As Integer)
    TB_LastChangedTime.Value = Now()
End Sub

Private Sub ������������������_����_AfterUpdate()

    PodRefresh

End Sub

Private Sub ������_AfterUpdate()

    If Form_��_������������.���_�����.Column(1) = "������" Then
        Me.������������������_���� = Me.������.Value * Form_�������������.�_���������.Value
        PodRefresh
    Else
        Me.������������������_���� = ""
        PodRefresh
    End If

End Sub

Private Sub PodRefresh()
    If ������������������_����.Value <> "" Then
        Me.������_����_1.Value = ������.Value * 0.94
        Me.������_����_2.Value = ������.Value * 0.96
        Me.������_��_1.Value = ������.Value * 0.06
        Me.������_��_2.Value = ������.Value * 0.04
    Else
        Me.������_����_1.Value = ""
        Me.������_����_2.Value = ""
        Me.������_��_1.Value = ""
        Me.������_��_2.Value = ""
    End If
End Sub
