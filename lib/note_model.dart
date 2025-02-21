import 'package:flutter/foundation.dart';
import 'package:notes_ui/db_helper.dart';

class NoteModel {
  int? nID;
  String nTitle;
  String nDesc;
  String nCreatedAt;

  NoteModel(
      {this.nID,
      required this.nTitle,
      required this.nDesc,
      required this.nCreatedAt});

  /// To Map
    Map<String,dynamic> toMap(){
      return {
        DbHelper.COLUMN_NOTES_TITLE : nTitle,
        DbHelper.COLUMN_NOTES_DESC : nDesc,
        DbHelper.COLUMN_NOTES_CREATED_AT : nCreatedAt,
      };
    }
  /// From Map
    factory NoteModel.fromMap(Map<String , dynamic> map){
      return NoteModel(
          nID: map[DbHelper.COLUMN_NOTES_ID],
          nTitle: map[DbHelper.COLUMN_NOTES_TITLE],
          nDesc: map[DbHelper.COLUMN_NOTES_DESC],
          nCreatedAt: map[DbHelper.COLUMN_NOTES_CREATED_AT],
      );
    }


}
