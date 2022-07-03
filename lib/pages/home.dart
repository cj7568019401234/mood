import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '首页',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("首页"),
          elevation: 0,
          centerTitle: true,
          foregroundColor: const Color.fromRGBO(45, 47, 51, 1),
          backgroundColor: Colors.white,
        ),
        body: Center(child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/mood');
            },
            child: const Text('点击跳转到历史心情指数页面')))
      ),
    );
  }
}
