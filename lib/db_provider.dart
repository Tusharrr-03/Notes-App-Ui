import 'package:flutter/cupertino.dart';
import 'package:notes_ui/db_helper.dart';
import 'package:notes_ui/note_model.dart';

class DbProvider extends ChangeNotifier{
  DbHelper dbHelper;
  DbProvider({required this.dbHelper});

  List<NoteModel> _mNotes = [];

  List<NoteModel> getAllNotes() => _mNotes;

  /// Events
  /// add notes
  addNote(NoteModel newnote) async{
    bool check = await dbHelper.addNotes(newnote: newnote);

    if(check){
      _mNotes = await dbHelper.fetchNotes();
      notifyListeners();
    }
  }

  /// Fetch notes
  void getInitialNotes() async{
    _mNotes = await dbHelper.fetchNotes();
    notifyListeners();
  }

  /// Update Notes
  Future <void> updateNote(NoteModel note) async {
    bool check = await dbHelper.updateValue(note);
    if (check) {
      _mNotes = await dbHelper.fetchNotes();
      notifyListeners();
    }
  }

  /// Delete Notes
  void deleteNote(int id) async {
    bool check = await dbHelper.deleteNote(id);
    if (check) {
      _mNotes.removeWhere((note) => note.nID == id);
      notifyListeners();
    }
  }

}