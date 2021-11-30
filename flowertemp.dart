
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:maddunoor/Utils/GetLocation.dart';

import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';




void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation> listAnimation=[];
  @override
  void initState() {

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller.addListener(
          () async {
        if (_controller.status == AnimationStatus.completed) {

          await _controller
              .reverse();

          _playAnimation();
        }
      },
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) => _playAnimation());
    super.initState();
  }


  Future<void> _playAnimation() async {
    try {
      await _controller
          .forward()
          .orCancel;

    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of

    }
  }
  List<Widget> stackScreen(double maxwidth,double maxheight) {
    List<Widget> layout = <Widget>[];

    for (int i = 0; i < 8; i++) {
      bool b=false;
      listAnimation.add( Tween(begin: (min(maxwidth,maxheight)/2.2), end: (min(maxwidth,maxheight))/2).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(max(0, (0.09)*(i-1)), (0.11)*i, curve: Curves.easeOutCirc))));

      print("i= ${i} min: ${max(0, (0.11)*(i-1))} , max: ${ (0.11)*i}");
      print("i= ${i} begin: ${(min(maxwidth,maxheight)/2.2)} , end: ${min(maxwidth,maxheight)/2 }");
      final cover =

      AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {

          return
            Positioned(
              right: 0,
              left: listAnimation[i].value-20, //width+offset/4
              child: Transform.rotate(alignment: Alignment.center, angle:i*150, origin: Offset(-60,0), transformHitTests:true, child:
              Container(width:listAnimation[i].value,height: listAnimation[i].value,decoration: BoxDecoration(color:b? Colors.red:Color(0x483BC1BD),
                  shape: BoxShape.circle),child: InkWell(onTap: (){print("clicked= $i");
             },
               ),)),
            );

        },
      );


      layout.add(cover);
    }
    layout.add(Center(child:Container(width:10,height: 20,decoration: BoxDecoration(color: Colors.red,shape: BoxShape.circle),)));


    return layout;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

          child: Center(
            child: Column(
              children: [
                Expanded(child: Container(color: Colors.pink,child:
                new LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints)
                    {
                      return

                        Stack(
                            alignment: Alignment.center,
                            children: stackScreen(constraints.maxWidth,constraints.maxHeight));
                    }
                ), ),flex: 1,


                ),
                Expanded(child:
                Container(color: Colors.black12,alignment:Alignment.center,height:200,child:
                new LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints)
                    {
                      return

                        Stack(
                            alignment: Alignment.center,
                            children: stackScreen(constraints.maxWidth,constraints.maxHeight));
                    }
                )

                )
                  ,flex: 1,),

                Expanded(child: Container(color: Colors.pink,child:
                new LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints)
                    {
                      return

                        Stack(
                            alignment: Alignment.center,
                            children: stackScreen(constraints.maxWidth,constraints.maxHeight));
                    }
                ), ),flex: 1,


                ),
              ],


            ),
          )),floatingActionButton: FloatingActionButton(
      onPressed: () {
        _playAnimation();
      },
      child: const Icon(Icons.add,color: Colors.red,),
      backgroundColor: Colors.white,
    ),);


  }


  double degreeToRadian(double degree) {
    return degree * (pi / 180);
  }


}

