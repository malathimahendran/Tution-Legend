import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutionmaster/model/Watched_video.dart';

class SqliteLocalDatabase extends ChangeNotifier {
  List<Watchedvideos> wathedvideolist = [];
  static Database? _database;
  List<String> sqlemailget=[];
  Future<Database> initializedatabase() async {
    final videolistdatabase = await openDatabase(
      join(await getDatabasesPath(), 'videolist_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE videolist( videoid INT PRIMARY KEY, duration INT)',
        );
        await db.execute(
          'CREATE TABLE startscreen( loginemail TEXT PRIMARY KEY, )',
        );
      },
      version: 1,
    );
    return videolistdatabase;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializedatabase();
    }
    return _database;
  }

  Future<void> insertvideolist(Watchedvideos videoitem) async {
    final db = await database;
    await db!.insert(
      'videolist',
      videoitem.toMap(),
    );
  }
  Future<void> insertuseremail(String usemail) async {
    final db = await database;
    Map<String, dynamic> getuseremail={
      'useremail':usemail
    };
    await db!.insert(
      'startscreen',
      getuseremail,
    );
  }
  Future<void> getregisteredemail() async {
    List<String> sqlemail=[];
    final db = await database;
    final List<Map<String, dynamic>> userem = await db!.query('startscreen');
    for (int i = 0; i < userem.length; i++) {
      sqlemail.add(userem[i]['useremail']);
    }
    sqlemailget=sqlemail;
    notifyListeners();
  }
  Future<void> getvideolist() async {
    List<Watchedvideos> videolistitem = [];
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('videolist');
    for (int i = 0; i < maps.length; i++) {
      videolistitem.add( Watchedvideos(
        videoid: maps[i]['videoid'],
        duration: maps[i]['duration'],

      ));
    }
    wathedvideolist = videolistitem.reversed.toList();
    notifyListeners();
  }

  // Future<void> deleteDog(int image) async {
  //   final db = await database;
  //   await db!.delete(
  //     'cartlist',
  //     where: 'image = ?',
  //     whereArgs: [image],
  //   );
  // }
}