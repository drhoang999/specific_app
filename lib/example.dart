import 'controller.dart';

var LIST_EXAMPLE = [
  ExampleItem(
    name: "Tìm số lớn hơn",
    text: '''TimSoLonHon(a:R,b:R)c:R
pre
post ((c=a)&&(a>=b))||((c=b)&&(b>a))'''
  ),

  ExampleItem(
      name: "Kiểm tra năm nhuận",
      text: '''KiemTraNamNhuan   (nam : Z) kq : B    
pre   (nam>0)
post 
( 
   (kq = FALSE) && (nam%4 !=0)
) 
||
( 
   (kq = FALSE) && (nam%400 != 0) 
   && (nam%100=0) 
) ||
( 
   (kq = TRUE) 
   && (nam%4 = 0) 
   && (nam%100!=0)
) 
||
( (kq = TRUE) && (nam%400=0))'''
  ),

  ExampleItem(
      name: "Xếp loại học sinh",
      text: '''XepLoaiHS  (diem: R) xl: char*
pre ( (diem>=0) && (diem <=10))
post 
((xl="XS") && (diem>=9)) || ((xl="GIOI") &&  (diem>=8) &&  (diem<9))
|| ((xl="KHA") && (diem>=6.5) &&  (diem<8)) || ((xl="TB") &&  (diem>=5) &&  (diem<6.5))
|| ((xl="YEU") && (diem>=3.5) &&  (diem<5)) || ((xl="KEM") &&  (diem<3.5))'''
  ),

  ExampleItem(
      name: "Ngày của tháng trong năm",
      text: '''Ngay_cua_thang_trong_nam_nhuan (t: N) sn: N
pre (t > 0) && (t < 12)
post ((t = 2) && (sn = 29)) || ((t = 4) || (t = 6) || (t = 9) || (t = 11) && (sn = 30)) 
|| ((t = 1) || (t = 3) || (t = 5) || (t = 7) || (t = 8) || (t = 10) || (t = 12) && (sn = 31))'''
  ),
];