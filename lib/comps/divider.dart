import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 12.0, right: 12.0),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Color.fromRGBO(242, 242, 242, 1),
            width: 2,
          ))),
        ),
        Container(
          margin: const EdgeInsets.only(top: 144.0, left: 12.0, right: 12.0),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Color.fromRGBO(242, 242, 242, 1),
            width: 2,
          ))),
        ),
      ],
    );
  }
}
