import 'package:flutter/material.dart';
import 'calendar_widget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const _CalendarSample(),
    );
  }
}

class _CalendarSample extends StatelessWidget {
  const _CalendarSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CalendarSample')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Calendar(date: DateTime.now()),
            TextButton(onPressed: () { /* ボタンがタップされた時の処理 */ },
                      child: Text('トレーニング開始'),
            )
          ],
        ),
      ),
    );
  }
}