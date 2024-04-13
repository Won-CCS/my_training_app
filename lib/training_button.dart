import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'db_controller.dart';
import 'package:image_picker/image_picker.dart';

class TrainingButton extends StatefulWidget {
  const TrainingButton({Key? key, required this.imageName}) : super(key: key);
  final String imageName;

  @override
  _TrainingButtonState createState() => _TrainingButtonState();
}

class _TrainingButtonState extends State<TrainingButton> {
  Uint8List? imageData;
  bool selected = false;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // 枠線
            border: Border.all(color: Colors.blue, width: 2),
            // 角丸
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  _insertImage(widget.imageName);
                },
                //画像を表示するウィジェットを追加する。
                child: imageData != null
                ? Image.memory(
                    imageData!,
                    width: 70,
                    height: 70,
                  ): Image.asset(
                    'assets/images/no_image_square.jpg',
                    width: 70,
                    height: 70,
                  ),
              ),
              const SizedBox(width: 70,),
              Text(
                widget.imageName,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: (){
                  setState(() {
                    selected = !selected;
                    // (selected) ? : ;
                  });
                },
                icon: Icon(Icons.add),
                isSelected: selected,
                selectedIcon: const Icon(Icons.remove),
                style: ButtonStyle(
                  backgroundColor: (selected) ? 
                    MaterialStateProperty.all(Colors.red): 
                    MaterialStateProperty.all(Colors.green)
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _fetchImage() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<Map<String, dynamic>> queryRows = await helper.queryImageByName(widget.imageName);
    if (queryRows.isNotEmpty) {
      setState(() {
        imageData = queryRows.first[DatabaseHelper.columnImage];
      });
    }
  }

  // 画像をデータベースに挿入
Future<void> _insertImage(String imageName) async {
  DatabaseHelper helper = DatabaseHelper.instance;
  final image = await ImagePicker().pickImage(
    // 画像を取得する
    source: ImageSource.gallery,
  );
  if (image != null) {
    Uint8List imageBytes = await image.readAsBytes(); // 画像のバイト配列を取得するメソッド（例：ImagePickerなど）
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: imageName,
      DatabaseHelper.columnImage: imageBytes,
    };
    int id = await helper.insertImage(row);
    // print('Inserted image id: $id');
    _fetchImage();
  }
}
}

class TrainingRecordWidget extends StatefulWidget {
  const TrainingRecordWidget({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  _TrainingWidgetState createState() => _TrainingWidgetState();
}

//重量、回数、セット数を入力可
//デフォルトのセット数は3
//前回の記録が各セットの下に表示される
class _TrainingWidgetState extends State<TrainingRecordWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // 枠線
        border: Border.all(color: Colors.blue, width: 2),
        // 角丸
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(widget.name),
          Row(
            children: [
              const Text('重量'),
              const SizedBox(width: 10,),
              Container(
                width: 100,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '重量',
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              const Text('kg'),
            ],
          ),
          Row(
            children: [
              const Text('回数'),
              const SizedBox(width: 10,),
              Container(
                width: 100,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '回数',
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              const Text('回'),
            ],
          ),
          Row(
            children: [
              const Text('セット数'),
              const SizedBox(width: 10,),
              Container(
                width: 100,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'セット数',
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              const Text('セット'),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Text('前回の記録'),
              const SizedBox(width: 10,),
              const Text('重量: 100kg, 回数: 10回'),
            ],
          ),
        ],
      ), 
    );
  }
 
}