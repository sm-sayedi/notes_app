import 'package:flutter/material.dart';

import '../constant.dart';
import '../models/models.dart';
import '../services/services.dart';

enum LoadingStatus { loading, done }

class NotesProvider extends ChangeNotifier {
  final List<Note> notes = [];

  LoadingStatus _loadingStatus = LoadingStatus.loading;

  LoadingStatus get loadingStatus => _loadingStatus;

  set loadingStatus(LoadingStatus loadingStatus) {
    _loadingStatus = loadingStatus;
    notifyListeners();
  }

  init() async {
    final List<Note> cachedNotes = await NoteDBHelper.query();
    notes.addAll(cachedNotes);
    loadingStatus = LoadingStatus.done;
    notifyListeners();
  }

  int _noteColor = Constant.colors.first.value;

  int get noteColor => _noteColor;

  set noteColor(int color) {
    _noteColor = color;
    notifyListeners();
  }

  void addNote(Note note) {
    notes.insert(0, note);
    notifyListeners();
    NoteDBHelper.insert(note);
  }

  void editNote(Note note) {
    notes.removeWhere(((element) => element.createdAt == note.createdAt));
    notes.insert(0, note);
    notifyListeners();
    NoteDBHelper.update(note);
  }

  void deleteNote(Note note) async {
    notes.remove(note);
    notifyListeners();
    NoteDBHelper.delete(note);
  }
}
