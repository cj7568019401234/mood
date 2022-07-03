import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../data.dart';

class MyTable extends StatefulWidget {
  const MyTable({Key? key}) : super(key: key);

  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  int weekdayIdx = -1; // 当前是周几所在 id
  int selectedIdx = -1; // 用户手动选中的 id
  int appearAnimationIdx = -1; // 当前正在展示出场动画的 id

  @override
  void initState() {
    super.initState();
    setState(() {
      final weekday = DateTime.now().weekday;
      weekdayIdx = weekday >= 6 ? weekday % 6 : weekday + 1;
    });
    // 开启动画
    Timer.periodic(const Duration(milliseconds: 170), (timer) {
      setState(() {
        appearAnimationIdx++;
      });
      if (appearAnimationIdx >= moodDataList.length) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 20, 7, 0),
      child: SizedBox(
        height: 320,
        child: Row(
            children: moodDataList.asMap()
                .entries.map((item) => Expanded(
                  child: TableRow(
                    dataItem: item.value,
                    onTap: () {
                      setState(() {
                        selectedIdx = item.value.isValid() ? item.key : -1;
                      });
                    },
                    isActive: weekdayIdx == item.key,
                    isSelected: selectedIdx == item.key,
                    isVisible: appearAnimationIdx >= item.key,
                  ))
            ).toList()),
      ),
    );
  }
}

class TableRow extends StatefulWidget {
  Function onTap;
  MoodData dataItem;
  bool isActive = false;
  bool isSelected = false;
  bool isVisible = false;
  TableRow({Key? key,
    required this.onTap,
    required this.dataItem,
    required this.isActive,
    required this.isSelected,
    required this.isVisible
  }) : super(key: key);
  @override
  _TableRowState createState() => _TableRowState();
}

class _TableRowState extends State<TableRow> {
  final double minHeight = 87;
  final double maxHeight = 280;
  int animationStep = -1;

  double getHeight() {
    return max(widget.dataItem.value * maxHeight * 0.01, minHeight);
  }

  String getImagePath() {
    if (widget.dataItem.value >= 90) {
      return widget.isSelected ? 'assets/selectedYellow.png' : 'assets/yellow.png';
    }
    if (widget.dataItem.value >= 80) {
      return widget.isSelected ? 'assets/selectedGreen.png' : 'assets/green.png';
    }
    return 'assets/grey.png';
  }

  Color getColor() {
    if (widget.dataItem.value >= 90) {
      return const Color.fromRGBO(255, 130, 60, 1);
    }
    if (widget.dataItem.value >= 80) {
      return const Color.fromRGBO(82, 200, 115, 1);
    }
    return const Color.fromRGBO(207, 207, 207, 1);
  }

  Color getBorderColor() {
    if (widget.dataItem.value >= 90) {
      return const Color.fromRGBO(255, 233, 212, 1);
    }
    if (widget.dataItem.value >= 80) {
      return const Color.fromRGBO(220, 255, 214, 1);
    }
    return const Color.fromRGBO(207, 207, 207, 1);
  }

  List<Color> getSelectedColor() {
    if (widget.dataItem.value >= 90) {
      return const [
        Color.fromRGBO(255, 161, 74, 1),
        Color.fromRGBO(255, 204, 74, 1),
        Color.fromRGBO(255, 233, 212, 1)
      ];
    }
    if (widget.dataItem.value >= 80) {
      return const [
        Color.fromRGBO(66, 243, 115, 1),
        Color.fromRGBO(161, 253, 68, 1),
        Color.fromRGBO(220, 255, 214, 1),
      ];
    }
    return const [];
  }

  // 日期展示
  Widget buildDayLabel() {
    return AnimatedOpacity(
        opacity: animationStep >= 0 ? 1.0 : 0.0, // 动画第二步：渐现日期
        duration: const Duration(milliseconds: 500),
        child: Container(
            height: 36,
            width: 36,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: widget.isSelected
                    ? const [
                      BoxShadow(
                        offset: Offset(2, 4),
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 8,
                        spreadRadius: 0
                      )
                    ]
                    : null,
                color: widget.isActive
                    ? const Color.fromRGBO(45, 47, 51, 1)
                    : Colors.white
            ),
            child: Text(widget.dataItem.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: widget.isActive
                        ? Colors.white
                        : const Color.fromRGBO(45, 47, 51, 1)
                )
            )
        )
    );
  }

  // 指数高度柱形文案
  Widget buildHistogram() {
    return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
              top: 12,
              child: AnimatedOpacity(
                  opacity: animationStep >= 1 ? 1.0 : 0.0, // 动画第三步：渐现指数
                  duration: const Duration(milliseconds: 200),
                  onEnd: () {
                    setState(() {
                      animationStep = 2;
                    });
                  },
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize:  widget.isSelected ? 24: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    child: Text(widget.dataItem.getDisplayValue()),
                  ),
              )
          ),
          Positioned(
              bottom: 4,
              child: Container(
                height: 34,
                width: 34,
                alignment: Alignment.center,
                child: AnimatedContainer(
                    height: widget.isVisible ? 34 : 0, // 动画第一步：圆脸动画
                    width:  widget.isVisible ? 34 : 0,
                    duration: const Duration(milliseconds: 400),
                    child: Image(image: AssetImage(getImagePath()))
                ),
              )
          )
        ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => widget.onTap(),
        highlightColor: Colors.transparent, // 透明⾊
        splashColor: Colors.transparent, // 透明⾊
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedOpacity(
                  opacity: widget.isVisible ? 1.0 : 0.0,// 动画第一步：渐现动画
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    setState(() {
                      animationStep = 0;
                    });
                  },
                  child: AnimatedContainer(
                    height: animationStep >= 0 ? getHeight() : 42,// 动画第二步：高度动画
                    width: widget.isSelected ? 58 : 52,
                    onEnd: () {
                      setState(() {
                        if (animationStep >= 2) return;
                        animationStep = 1;
                      });
                    },
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      margin: widget.isSelected ? const EdgeInsets.fromLTRB(4, 0, 4, 0)
                          : const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: widget.isSelected ? Border.all(
                              color: getBorderColor(),
                              width: 2,
                              style: BorderStyle.solid
                          ) : null,
                          borderRadius: BorderRadius.circular(30),
                          gradient: widget.isSelected
                              ? LinearGradient(
                            colors: getSelectedColor(),
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                              : null,
                          color: widget.isSelected ? null : getColor(),
                          boxShadow: widget.isSelected ? [
                            const BoxShadow(
                                offset: Offset(0.0, 4.0),
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                blurRadius: 10,
                                spreadRadius: 0
                            )
                          ] : null
                      ),
                      child: buildHistogram()
                    ),
                  )),
              buildDayLabel(),
            ]
        )
    );
  }
}