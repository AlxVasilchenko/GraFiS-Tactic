VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Form_���������"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Compare Database


Private Sub Form_Load()
    s_CheckColor (1)
End Sub

Private Sub �������������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'��������� ��������� ������������� �������� ���� ��� ���������� ������� ��� �������� ������
    If �_��_��.FontUnderline = True Then �_��_��.FontUnderline = False
    If �_��_���.FontUnderline = True Then �_��_���.FontUnderline = False
    If �_��_�������������.FontUnderline = True Then �_��_�������������.FontUnderline = False
    If �_��_����������.FontUnderline = True Then �_��_����������.FontUnderline = False
    If �_��_���.FontUnderline = True Then �_��_���.FontUnderline = False
    If �_��_����.FontUnderline = True Then �_��_����.FontUnderline = False
    If �_��_�������������.FontUnderline = True Then �_��_�������������.FontUnderline = False
    If �_��_��������.FontUnderline = True Then �_��_��������.FontUnderline = False
    If �_��_���������.FontUnderline = True Then �_��_���������.FontUnderline = False
    If �_��_��������.FontUnderline = True Then �_��_��������.FontUnderline = False
    
End Sub

'-------------------------����������� ����----------------------------------------------
'-------------------------����������� ���������-----------------------------------------
Private Sub �_��_�������������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_�������������.FontUnderline = False Then �_��_�������������.FontUnderline = True
End Sub

Private Sub �_��_��������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_��������.FontUnderline = False Then �_��_��������.FontUnderline = True
End Sub

Private Sub �_��_����_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_����.FontUnderline = False Then �_��_����.FontUnderline = True
End Sub

Private Sub �_��_����������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_����������.FontUnderline = False Then �_��_����������.FontUnderline = True
End Sub

Private Sub �_��_��_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_��.FontUnderline = False Then �_��_��.FontUnderline = True
End Sub

Private Sub �_��_���������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_���������.FontUnderline = False Then �_��_���������.FontUnderline = True
End Sub

Private Sub �_��_�������������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_�������������.FontUnderline = False Then �_��_�������������.FontUnderline = True
End Sub

Private Sub �_��_���_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_���.FontUnderline = False Then �_��_���.FontUnderline = True
End Sub

Private Sub �_��_��������_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_��������.FontUnderline = False Then �_��_��������.FontUnderline = True
End Sub

Private Sub �_��_���_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If �_��_���.FontUnderline = False Then �_��_���.FontUnderline = True
End Sub

'-------------------------������--------------------------------------------------------
Private Sub �_��_�������������_Click()
    �_�������������.SetFocus
    s_CheckColor (7)
End Sub

Private Sub �_��_��������_Click()
    �_��������.SetFocus
    s_CheckColor (10)
End Sub

Private Sub �_��_����_Click()
    �_����.SetFocus
    s_CheckColor (6)
End Sub

Private Sub �_��_����������_Click()
    �_����������.SetFocus
    s_CheckColor (4)
End Sub

Private Sub �_��_��_Click()
    �_��.SetFocus
    s_CheckColor (1)
End Sub

Private Sub �_��_���������_Click()
    �_���������.SetFocus
    s_CheckColor (9)
End Sub

Private Sub �_��_�������������_Click()
    �_�������������.SetFocus
    s_CheckColor (3)
End Sub

Private Sub �_��_���_Click()
    �_���.SetFocus
    s_CheckColor (5)
End Sub

Private Sub �_��_��������_Click()
    �_��������.SetFocus
    s_CheckColor (8)
End Sub

Private Sub �_��_���_Click()
    �_�������������.SetFocus
    s_CheckColor (2)
End Sub


'-------------------------����������� �� ���������---------------------------------------
'-------------------------������>>---------------------------------------
Private Sub �_��_��������������_Click()
    �_�������������.SetFocus
    s_CheckColor (3)
End Sub

Private Sub �_��_��������������_Click()
    �_�������������.SetFocus
    s_CheckColor (2)
End Sub

Private Sub �_��_������������_Click()
    �_����������.SetFocus
    s_CheckColor (4)
End Sub

Private Sub �_��_����_Click()
    �_���.SetFocus
    s_CheckColor (5)
End Sub

Private Sub �_��_�����_Click()
    �_����.SetFocus
    s_CheckColor (6)
End Sub

Private Sub �_��_��������������_Click()
    �_�������������.SetFocus
    s_CheckColor (7)
End Sub

Private Sub �_��_���������_Click()
    �_��������.SetFocus
    s_CheckColor (8)
End Sub

Private Sub �_��_����������_Click()
    �_���������.SetFocus
    s_CheckColor (9)
End Sub

Private Sub �_��_���������_Click()
    �_��������.SetFocus
    s_CheckColor (10)
End Sub

'-------------------------<<�����---------------------------------------
Private Sub �_��_��������_Click()
    �_��.SetFocus
    s_CheckColor (1)
End Sub

Private Sub �_��_��������������_Click()
    �_�������������.SetFocus
    s_CheckColor (2)
End Sub

Private Sub �_��_�������_Click()
    �_�������������.SetFocus
    s_CheckColor (3)
End Sub

Private Sub �_��_�����������_Click()
    �_����������.SetFocus
    s_CheckColor (4)
End Sub

Private Sub �_��_����_Click()
    �_���.SetFocus
    s_CheckColor (5)
End Sub

Private Sub �_��_�����_Click()
    �_����.SetFocus
    s_CheckColor (6)
End Sub

Private Sub �_��_��������������_Click()
    �_�������������.SetFocus
    s_CheckColor (7)
End Sub

Private Sub �_��_���_Click()
    �_��������.SetFocus
    s_CheckColor (8)
End Sub

Private Sub �_��_����������_Click()
    �_���������.SetFocus
    s_CheckColor (9)
End Sub



Private Sub �������������23_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'��������� ��������� ������������� �������� ���� ��� ���������� ������� ��� ���������������23
    If �_��_��.FontUnderline = True Then �_��_��.FontUnderline = False
    If �_��_���.FontUnderline = True Then �_��_���.FontUnderline = False
    If �_��_�������������.FontUnderline = True Then �_��_�������������.FontUnderline = False
    If �_��_����������.FontUnderline = True Then �_��_����������.FontUnderline = False
    If �_��_���.FontUnderline = True Then �_��_���.FontUnderline = False
    If �_��_����.FontUnderline = True Then �_��_����.FontUnderline = False
    If �_��_�������������.FontUnderline = True Then �_��_�������������.FontUnderline = False
    If �_��_��������.FontUnderline = True Then �_��_��������.FontUnderline = False
    If �_��_���������.FontUnderline = True Then �_��_���������.FontUnderline = False
    If �_��_��������.FontUnderline = True Then �_��_��������.FontUnderline = False
    
End Sub

Private Sub s_CheckColor(as_Objectnumber As Integer)
'��������� ��������� �������� ������� �� �������� ������������� �����������
    If as_Objectnumber = 1 Then �_��_��.BackStyle = 1 Else �_��_��.BackStyle = 0
    If as_Objectnumber = 2 Then �_��_���.BackStyle = 1 Else �_��_���.BackStyle = 0
    If as_Objectnumber = 3 Then �_��_�������������.BackStyle = 1 Else �_��_�������������.BackStyle = 0
    If as_Objectnumber = 4 Then �_��_����������.BackStyle = 1 Else �_��_����������.BackStyle = 0
    If as_Objectnumber = 5 Then �_��_���.BackStyle = 1 Else �_��_���.BackStyle = 0
    If as_Objectnumber = 6 Then �_��_����.BackStyle = 1 Else �_��_����.BackStyle = 0
    If as_Objectnumber = 7 Then �_��_�������������.BackStyle = 1 Else �_��_�������������.BackStyle = 0
    If as_Objectnumber = 8 Then �_��_��������.BackStyle = 1 Else �_��_��������.BackStyle = 0
    If as_Objectnumber = 9 Then �_��_���������.BackStyle = 1 Else �_��_���������.BackStyle = 0
    If as_Objectnumber = 10 Then �_��_��������.BackStyle = 1 Else �_��_��������.BackStyle = 0
    
    
    
End Sub



