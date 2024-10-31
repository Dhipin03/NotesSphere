import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class NoteScreenController with ChangeNotifier {
  static Database? mydatabase;
  List<Map<String, dynamic>>? notelist;

  static Future<void> initdb() async {
    mydatabase = await openDatabase(
      'notesphere.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, notecontent TEXT)',
        );
      },
    );
  }

  Future<void> addnotes(String notetitle, String notecontent) async {
    try {
      await mydatabase?.rawInsert(
        'INSERT INTO notes(title, notecontent) VALUES(?, ?)',
        [notetitle, notecontent],
      );

      await getnotes();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Get notes
  Future<void> getnotes() async {
    try {
      notelist = await mydatabase?.rawQuery('SELECT * FROM notes');
      notifyListeners();
    } catch (e) {
      print('Error fetching notes: $e');
      notelist = [];
    }
  }

  Future<void> deletenote(int id) async {
    await mydatabase?.rawDelete('DELETE FROM notes WHERE id = ?', [id]);
    await getnotes();
    notifyListeners();
  }

  Future<void> updatenote(int id, String title, String content) async {
    await mydatabase?.rawUpdate(
      'UPDATE notes SET title = ?, notecontent = ? WHERE id = ?',
      [title, content, id],
    );
    await getnotes();
    notifyListeners();
  }
}
