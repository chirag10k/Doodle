import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: new HomePage(),
));
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return new Scaffold(
      body: new Container(
        color: Colors.black,
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details){
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition =
                object.localToGlobal(details.localPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: new CustomPaint(
            painter: new Signature(
              points: _points,
            ),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.clear),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () => _points.clear(),
      ),
    );
  }
}

class Signature extends CustomPainter {

  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = new Paint()
    ..color = Colors.lightGreenAccent
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;

    for(int i = 0; i < points.length - 1; i++){
      if(points[i] != null && points[i+1] != null){
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }

  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;



}