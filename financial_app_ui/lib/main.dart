import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(google) or CupertinoApp(ios) widget
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello flutter!'),
          backgroundColor: const Color.fromRGBO(200, 0, 000, 0.4),
          shadowColor: const Color.fromRGBO(0, 0, 0, 0.5),
          elevation: 10,
        ),
        body: const Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}
