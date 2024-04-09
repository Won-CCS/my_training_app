import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

class Thumbnail {
    late int? id = 0;
    late String? thumbnailName = "";
    Thumbnail(int i, String imgString){
      this.thumbnailName = imgString;
    }
    Map <String, dynamic> toMap(){
      var map = <String, dynamic>{
        'id': id,
        'thumbnailName': thumbnailName,
      };
      return map;
    }
    Thumbnail.fromMap(Map<String, dynamic>map){
      id = map['id'];
      thumbnailName = map ['thumbnailName'];
    }
}


class DBHelper{
    static Database? _db;
    static const String ID ='id';
    static const String NAME = 'thumbnailName';
    static const String TABLE = 'thumbnailsTable';
    static const String DB_Name = 'thumbnails.db';
    Future<Database?> get db async {
        if (null != _db){
            return _db;
        }
        _db = await initDB();
        return _db;
    }
    initDB() async{
        Directory documentsDirectory = await getApplicationDocumentsDirectory();
        String path = join(documentsDirectory.path, DB_Name);
        var db = await openDatabase(path, version: 1, onCreate: _onCreate);
        return db;
    }
    _onCreate(Database db, int version) async{
        await db.execute('CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT)');
    }

    Future<Thumbnail> save(Thumbnail thumbnail) async {
        var dbClient = await db;
        print(thumbnail.thumbnailName);
        thumbnail.id = await dbClient!.insert(TABLE, thumbnail.toMap());
        print(thumbnail.id);
        return thumbnail;
    }
    Future<List<Thumbnail>> getThumbnails() async {
        var dbClient = await db;
        List<Map> maps = await dbClient!.query(TABLE, columns: [ID, NAME]);
        List<Thumbnail> thumbnails = [];
        if(maps.isNotEmpty){
            for(int i = 0; i < maps.length; i++){
                thumbnails.add(Thumbnail.fromMap(Map<String, dynamic>.from(maps[i])));
            }
        }
        print("thumbnails {{$thumbnails}}");
        return thumbnails;
    }
    Future close() async {
        var dbClient = await db;
        dbClient!.close();
    }
}