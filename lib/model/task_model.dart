import 'dart:core';

import 'package:todo_project/core/utils.dart';
class TaskModel{

  String? id;
  String title;
  String description;
  DateTime selectedDate;
  bool isDone;
  String selectTime;

  TaskModel({
     this.id,
    required this.title,
    required this.description,
    required this.selectedDate,
    this.isDone = false,required this.selectTime}
      );
  Map<String,dynamic>toFirestore(){
    return{
      "id":id,
      "title": title,
      "description":description,
      "selectedDate": extractedDate(selectedDate).millisecondsSinceEpoch,
      "isDone":isDone,
      "selectTime": selectTime,
    };
  }
  factory TaskModel.firestore(Map<String,dynamic> json)=> TaskModel(id: json["id"],
        title: json["title"],
        description: json["description"],
        selectedDate:DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]) ,
        isDone: json["isDone"],
       selectTime: json["selectTime"] as String? ?? '',
    );


}