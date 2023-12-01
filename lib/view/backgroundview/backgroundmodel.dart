import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';

class CurvedShape extends StatelessWidget {
  const CurvedShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CURVE_HEIGHTI = 160.0;
    return Container(
      width: double.infinity,
      height: CURVE_HEIGHTI,
      child: CustomPaint(painter: myPainter()),
    );
  }
}


class myPainter extends CustomPainter {
   var CURVE_HEIGHT = 160.0;
   var AVATAR_RADIUS = 160.0 * 0.28;
   var AVATAR_DIAMETER = 160.0 * 0.28 * 2;
  @override
  void paint(Canvas canvas, size) {
    Paint paint = new Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = Color(0xff82A8F4);
    Offset circleCenter = Offset(size.width / 2, size.height - 160 * 0.28);

    Offset topLeft = Offset(0, 0);
    Offset bottomLeft = Offset(0, 120*0.30);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, 130*1.30);

    Offset leftCurveControlPoint =
        Offset(circleCenter.dx * 0.5, size.height - AVATAR_RADIUS * 1.5);
    Offset rightCurveControlPoint =
        Offset(circleCenter.dx * 1.6, size.height - AVATAR_RADIUS);

    final arcStartAngle = 200 / 180 * pi;
    final avatarLeftPointX =
        circleCenter.dx + AVATAR_RADIUS * cos(arcStartAngle);
    final avatarLeftPointY =
        circleCenter.dy + AVATAR_RADIUS * sin(arcStartAngle);
    Offset avatarLeftPoint =
        Offset(avatarLeftPointX, avatarLeftPointY); // the left point of the arc

    final arcEndAngle = -5 / 180 * pi;
   
    Path path = Path()
      ..moveTo(topLeft.dx,
          topLeft.dy) // this move isn't required since the start point is (0,0)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(leftCurveControlPoint.dx, leftCurveControlPoint.dy,
          avatarLeftPoint.dx, avatarLeftPoint.dy)
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
  
}
