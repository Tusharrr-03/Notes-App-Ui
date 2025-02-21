


/// Flutter block kya hota hai
/// or guruji sqllite to local level pr data store krta hai toh apn shared prefrence ka hi use nhi kr lete kya?

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'note_model.dart';

class DbHelper {
  DbHelper._();

  static DbHelper getInstance() => DbHelper._();
  static const String TABLE_NOTES = 'notes';
  static const String COLUMN_NOTES_ID = 'nId';
  static const String COLUMN_NOTES_TITLE = 'nTitle';
  static const String COLUMN_NOTES_DESC = 'nDesc';
  static const String COLUMN_NOTES_CREATED_AT = 'nCreatedAt';

  Database? _db;


  /// GET DATABASE FUNCTION
  Future<Database> getDB() async{
    _db ??= await openDB();
    return _db!;

/*if(_db == null){
      return _db!;
    }else{
      _db = await openDB();
      return _db!;
    }*/
  }


  /// OPEN DATABASE
  Future<Database> openDB() async{
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, "notesDB.db");


    return await openDatabase(dbPath , version: 1 , onCreate: (db , version){
      db.execute("Create table $TABLE_NOTES ( $COLUMN_NOTES_ID integer primary key autoincrement, $COLUMN_NOTES_TITLE text, $COLUMN_NOTES_DESC text, $COLUMN_NOTES_CREATED_AT text)");
    });
  }


  /// ADD VALUES TO THE DATABSE
  Future<bool> addNotes({required NoteModel newnote})async{
    Database db = await getDB();

    int rowsEffected = await db.insert(TABLE_NOTES, newnote.toMap());

     return rowsEffected>0;
  }

  /// FETCH VALUES FROM DATABASE
  Future<List<NoteModel>> fetchNotes() async{
    var db = await getDB();

    List<Map<String ,dynamic>> mNotes = await db.query(TABLE_NOTES);

    List<NoteModel> allNotes = [];
    for(Map<String , dynamic> eachNotes in mNotes){
      allNotes.add(NoteModel.fromMap(eachNotes));
    }

    /*for(int i = 0 ; i <= mNotes.length ; i++ ){
      allNotes.add(NoteModel.fromMap(mNotes[i]));
    }*/

    return allNotes;
  }

  /// DELETE VALUES FROM DATABASE


}
