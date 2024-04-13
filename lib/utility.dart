import 'dart:typed_data';
import 'db_controller.dart';
import 'package:image_picker/image_picker.dart';

// 画像をデータベースに挿入
Future<void> insertImage(String imageName) async {
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
  }
}

// すべての画像をデータベースから取得
Future<void> queryAllImages() async {
  DatabaseHelper helper = DatabaseHelper.instance;
  List<Map<String, dynamic>> queryRows = await helper.queryAllImages();
  queryRows.forEach((row) {
    Uint8List bytes = row[DatabaseHelper.columnImage];
    // bytes を画像として扱う処理
  });
}