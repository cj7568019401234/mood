import 'package:flutter/material.dart';
import '../comps/header.dart';
import '../comps/divider.dart';
import '../comps/table.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '历史心情指数',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: '返回',
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text("历史心情指数"),
          elevation: 0,
          centerTitle: true,
          foregroundColor: const Color.fromRGBO(45, 47, 51, 1),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const MyHeader(),
            Stack(children: const [
              MyDivider(),
              MyTable(),
            ])
          ],
        ),
      ),
    );
  }
}
