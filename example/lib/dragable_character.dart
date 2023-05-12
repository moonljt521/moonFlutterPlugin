import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Drag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> with SingleTickerProviderStateMixin {


  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // print('screenHeight = $screenHeight');

    _left = _left.clamp(0, screenWidth - 30);
    _top = _top.clamp(0, screenHeight - 30);

    return Stack(
      children: <Widget>[
        Positioned(
          width: 30,
          height: 30,
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建

              // if(_left <=0) return;

              setState(() {
                _left += e.delta.dx;

                // if(_left <0){
                //   _left = 0;
                // }
                // if(_left > screenWidth - 30){
                //   _left = screenWidth - 30;
                // }

                _top += e.delta.dy;

                // if(_top <0){
                //   _top = 0;
                // }
                // if(_top > screenHeight - 30){
                //   _top = screenHeight - 30;
                // }


              });
            },
            onPanEnd: (DragEndDetails e){
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        )
      ],
    );
  }
}