import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutionmaster/model/Watched_video.dart';

class SqliteLocalDatabase extends ChangeNotifier {
  final l = Logger();
  List<Watchedvideos> wathedvideolist = [];
  static Database? _database;
  List<String> sqlemailget = [];
  Future<Database> initializedatabase() async {
    final videolistdatabase = await openDatabase(
      join(await getDatabasesPath(), 'videolist_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE videolist( videoid INT PRIMARY KEY, duration INT)',
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
    List<Watchedvideos> listOfVideos = [];
    List onlyIds = [];
    final db = await database;

    final List<Map<String, dynamic>> ds = await db!.query('videolist');
    for (var i in ds)
      listOfVideos
          .add(Watchedvideos(videoid: i['videoid'], duration: i['duration']));
    l.w(ds);
    l.w("${videoitem.videoid},${videoitem.duration}, line 42");
    var a = await db.insert('videolist', videoitem.toMap());
    l.v(a);
    // for (var i in listOfVideos) onlyIds.add(i.videoid);

    // bool k = onlyIds.contains(videoitem.videoid);
    // l.w(k);
    // l.w(videoitem);

    // if (k) {
    //   l.w('inside if');
    //   var z = await db.update('videolist', videoitem.toMap(),
    //       where: 'videoid = ?', whereArgs: [videoitem.videoid]);

    //   l.w(z);
    //   var y = await db.query('videolist');
    //   l.w(y);
    //   wathedvideolist = listOfVideos.reversed.toList();
    //   notifyListeners();
    // } else {
    //   l.w('inside else');

    //   var a = await db.insert('videolist', videoitem.toMap());
    //   l.v(a);
    //   var y = await db.query('videolist');
    //   l.w(y);
    //   // notifyListeners();
    // }
  }

  changing() async {
    List<Watchedvideos> listOfVideos = [];
    // wathedvideolist = videos.reversed.toList();
    final db = await database;
    List k = await db!.query('videolist');
    for (var i in k) {
      print("line no 71 in changing${i.duration}");
      listOfVideos
          .add(Watchedvideos(videoid: i['videoid'], duration: i['duration']));
    }
    wathedvideolist = listOfVideos.reversed.toList();
    notifyListeners();
  }

  Future<void> getvideolist() async {
    List<Watchedvideos> videolistitem = [];
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('videolist');
    l.d(maps);
    for (int i = 0; i < maps.length; i++) {
      videolistitem.add(Watchedvideos(
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
