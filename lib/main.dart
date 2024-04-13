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

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();  
}

class _SettingPageState extends State<SettingPage> {
  List<String> trainingMenuNames = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(title: const Text('トレーニング設定')),
          //右下のボタン
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
                  // ボトムシートを表示
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
                  // ボトムシートを表示
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return MyBottomSheetContent(
                        trainingMenuNames: trainingMenuNames,
                      );
                    }
                  );
                },
              ),
            ],
          ),
          //トレーニングリストを表示
          body: ListView.builder(
            itemCount: trainingMenuNames.length,
            itemBuilder: (context, index) {
              return TrainingRecordWidget(name: trainingMenuNames[index]);
            },
          ),
        );
      },
    );
  }
}


class MyBottomSheetContent extends StatefulWidget {
  const MyBottomSheetContent({Key? key, required this.trainingMenuNames}) : super(key: key);
  final List<String> trainingMenuNames;

  @override
  _MyBottomSheetContentState createState() => _MyBottomSheetContentState();
}

class _MyBottomSheetContentState extends State<MyBottomSheetContent> {
  // ここに状態を保持する変数やメソッドを追加

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: widget.trainingMenuNames.length,
        itemBuilder: (context, index) {
          return TrainingButton(imageName: widget.trainingMenuNames[index]);
        },
      ),
    );
  }
}
