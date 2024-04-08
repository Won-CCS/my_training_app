import 'package:flutter/material.dart';
import 'calendar_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'training_button.dart';


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
      home: const EntryPage(),
    );
  }
}

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マイトレ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Calendar(date: DateTime.now()),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              child: const Text('トレーニング開始'),
            )
          ],
        ),
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(title: const Text('トレーニング設定')),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            backgroundColor: Colors.blue,
            closeManually: true,
            children: [
              SpeedDialChild(
                child: Icon(Icons.add),
                label: 'ルーティーン一覧から追加',
                backgroundColor: Colors.blue,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => RoutineListPage()),
                  // );
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 500,
                        child: Center(
                          child: Text('ここにメニュー項目が入ります'),
                        ),
                      );
                    }
                  );
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                label: 'トレーニング一覧から追加',
                backgroundColor: Colors.blue,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TrainingListPage()),
                  // );
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 500,
                        margin: EdgeInsets.all(20),
                        child: ListView.builder(
                          itemCount: 4, // リストアイテムの数
                          itemBuilder: (BuildContext context, int index) {
                            // 各リストアイテムのビルド
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0), // 垂直方向の余白を指定
                              child: Column( 
                                children: [
                                TrainingButton(name: "スクワット"),
                                TrainingButton(name: "背筋"),
                                TrainingButton(name: "腕立て"),
                                TrainingButton(name: "腹筋")
                                ],
                              ),
                            );
                          },
                        )
                      );
                    }
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                
              ],
            ),
          ),
        );
      },
    );
  }
}

class TrainingListPage extends StatelessWidget {
  const TrainingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('トレーニング一覧')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

class RoutineListPage extends StatelessWidget {
  const RoutineListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ルーティーン一覧')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RoutineDetailPage()),
                // );
              },
              child: const Text('朝のルーティーン'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => RoutineDetailPage()),
                // );
              },
              child: const Text('夜のルーティーン'),
            ),
          ],
        ),
      ),
    );
  }
}