import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreenController with ChangeNotifier {
  static Database? mydatabase1;
  List<Map<String, dynamic>>? notelist;
  List<Map<String, dynamic>>? todolist;
  List<Map<String, dynamic>>? pendingTasks;
  List<Map<String, dynamic>>? completedTasks;
  bool isChecked = false;
  num percent = 0;
  int result = 0;
  bool isLogined = false;
  int completedTaskCount = 0;
  int pendingTaskCount = 0;
  final todaysdate = DateFormat('dd-MM-YYYY').format(DateTime.now());
  static Future<void> initdb() async {
    mydatabase1 = await openDatabase(
      'notesphere1.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, notecontent TEXT)',
        );
        await db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, task TEXT, date TEXT, isCompleted INTEGER DEFAULT 0)',
        );
      },
    );
  }

  Future<void> addnotes(String notetitle, String notecontent) async {
    try {
      await mydatabase1?.rawInsert(
        'INSERT INTO notes(title, notecontent) VALUES(?, ?)',
        [notetitle, notecontent],
      );
      await getnotes();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getnotes() async {
    isLogined = true;
    notifyListeners();
    try {
      notelist = await mydatabase1?.rawQuery('SELECT * FROM notes');
      notifyListeners();
    } catch (e) {
      print('Error fetching notes: $e');
      notelist = [];
    }
    isLogined = false;
    notifyListeners();
  }

  Future<void> deletenote(int id) async {
    await mydatabase1?.rawDelete('DELETE FROM notes WHERE id = ?', [id]);
    await getnotes();
    notifyListeners();
  }

  Future<void> updatenote(int id, String title, String content) async {
    await mydatabase1?.rawUpdate(
      'UPDATE notes SET title = ?, notecontent = ? WHERE id = ?',
      [title, content, id],
    );
    await getnotes();
    notifyListeners();
  }

  Future<void> addtask(String task, String date) async {
    try {
      await mydatabase1?.rawInsert(
        'INSERT INTO tasks(task, date, isCompleted) VALUES(?, ?, 0)',
        [task, date],
      );
      await getPendingTasks();
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding task: $e');
    }
  }

  Future<void> completeTask(int id) async {
    try {
      await mydatabase1?.rawUpdate(
        'UPDATE tasks SET isCompleted = 1 WHERE id = ?',
        [id],
      );
      await getPendingTasks();
      await getCompletedTasks();
      notifyListeners();
    } catch (e) {
      debugPrint('Error completing task: $e');
    }
  }

  Future<void> getPendingTasks() async {
    try {
      pendingTasks = await mydatabase1?.rawQuery(
        'SELECT * FROM tasks WHERE isCompleted = 0 ORDER BY id DESC',
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching pending tasks: $e');
      pendingTasks = [];
    }
  }

  Future<void> getCompletedTasks() async {
    try {
      completedTasks = await mydatabase1?.rawQuery(
        'SELECT * FROM tasks WHERE isCompleted = 1 ORDER BY id DESC',
      );
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching completed tasks: $e');
      completedTasks = [];
    }
  }

  calculatetaskpercent() {
    completedTaskCount = completedTasks?.length ?? 0;
    pendingTaskCount = pendingTasks?.length ?? 0;
    int totalTasks = completedTaskCount + pendingTaskCount;
    if (totalTasks == 0) {
      percent = 0;
      result = 0;
    } else {
      percent = (completedTaskCount / totalTasks) * 100;
      result = percent.toInt();
    }
    notifyListeners();
  }
}
