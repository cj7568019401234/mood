import 'dart:async';
import 'package:flutter/material.dart';
import '../data.dart';

class MyHeader extends StatefulWidget {
  const MyHeader({Key? key}) : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    // 开启动画
    Timer(const Duration(milliseconds: 50), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  int getAverageScore() {
    int sum = 0;
    int count = 0;
    for (int i = 0; i < moodDataList.length; i++) {
      if (moodDataList[i].value > 0) {
        sum += moodDataList[i].value;
        count++;
      }
    }
    return count == 0 ? 0 : (sum / count).round();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 800),
        child: Container(
            margin: const EdgeInsets.only(top: 18.0, left: 12, right: 12), //内边距
            padding: const EdgeInsets.only(top: 44.0, bottom: 34),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.only(right: 10.0), //内边距
                  height: 36,
                  width: 36,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/avatar.jpeg'),
                      )),
                ),
                const Text(
                  '彩君',
                  style: TextStyle(
                    color: Color.fromRGBO(45, 47, 51, 1),
                    fontSize: 20,
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(getAverageScore().toString(),
                      style: const TextStyle(
                        color: Color.fromRGBO(45, 47, 51, 1),
                        fontSize: 72,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('周平均心情指数',
                      style: TextStyle(
                        color: Color.fromRGBO(146, 146, 146, 1),
                        fontSize: 18,
                      )),
                ],
              ),
            ]),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, -6.0),
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      blurRadius: 16, //阴影模糊程度
                      spreadRadius: -6 //阴影扩散程度
                      )
                ]
            )
        )
    );
  }
}
