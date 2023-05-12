import 'dart:math';
import 'package:flutter/material.dart';


class FlowDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();

}


class _State<FlowDemo> extends State with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  double rad = 0.0;

  @override
  void initState() {
    _controller =
    AnimationController(duration: Duration(milliseconds: 3000), vsync: this)
      ..addListener(() => setState(() =>
      rad = _controller.value*pi*2));
    // _controller.forward();
    _controller.repeat();



    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(delegate: _CircleFlowDelegate(rad),
      children: [
        _buildItem('A'),
        _buildItem('B' , f: (){
          print('b');
        }),
        _buildItem('C'),
        _buildItem('D'),
        _buildItem('E'),
        _buildItem('F'),
      ],
    );
  }
  _buildItem(String t , {VoidCallback? f}) {
    return GestureDetector(
      onTap: f,
      child: SizedBox(
        width: 30,
        height: 30,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
          ),
          child: Text(t , style: TextStyle(color: Colors.white),),
        ),
      ),
    );
    return SizedBox(
      width: 30,
      height: 30,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
        ),
        child: Text(t , style: TextStyle(color: Colors.white),),
      ),
    );
  }

}



class CircleFlow extends StatelessWidget {
  final List<Widget> children;

  CircleFlow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(2),
      children: children,
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {

  final double rad;
  _CircleFlowDelegate(this.rad);

  @override //绘制孩子的方法
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    var count = context.childCount;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      print(i);
      var cSizeX = context.getChildSize(i)?.width ?? 0 / 2;
      var cSizeY = context.getChildSize(i)?.height ?? 0 / 2;

      var offsetX = (radius - cSizeX) * cos(i * perRad + rad) + radius;
      var offsetY = (radius - cSizeY) * sin(i * perRad + rad) + radius;
      context.paintChild(i,
          transform: Matrix4.translationValues(
              offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
  }
  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return false;
  }
}