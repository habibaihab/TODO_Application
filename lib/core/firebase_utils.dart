
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_project/core/services/sank_bar_service.dart';
import 'package:todo_project/core/utils.dart';
import 'package:todo_project/model/task_model.dart';

class FirebaseUtils {
  static String? userID=FirebaseAuth.instance.currentUser?.uid;
  static getCollectionRef() {
    return
      FirebaseFirestore.instance.collection(userID!)
          .withConverter<TaskModel>(
        fromFirestore: (snapshot, _) => TaskModel.firestore(snapshot.data()!),
        toFirestore: (taskModel, _) => taskModel.toFirestore(),
      );
  }

  static Future<void> addTaskToFirestore(TaskModel taskModel) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  static Future<List<TaskModel>> getOnTimeReadFromFirestore(
      DateTime selectedDate) async {
    var collectionRef = await getCollectionRef().where(
      "selectedDate",
      isEqualTo: extractedDate(selectedDate).millisecondsSinceEpoch,
    );
    QuerySnapshot<TaskModel> data = await collectionRef.get();
    List<TaskModel> tasksList = [];
    tasksList = data.docs.map((e) => e.data()).toList();
    return tasksList;
  }

  static Stream<QuerySnapshot<TaskModel>> getRealTimeReadFromFirestore(
      DateTime selectedDate) {
    var collectionRef = getCollectionRef().where(
      "selectedDate",
      isEqualTo: extractedDate(selectedDate).millisecondsSinceEpoch,
    );
    return collectionRef.snapshots();
  }

  static Future<void> deleteTask(TaskModel taskModel) async {
    var collectionsRef = getCollectionRef();
    var docRef = collectionsRef.doc(taskModel.id);
    return docRef.delete();
  }

  static Future<void> updateTask(TaskModel taskModel) async {
    var collectionsRef = getCollectionRef();
    var docRef = collectionsRef.doc(taskModel.id);
    taskModel.isDone = true;
    return docRef.update(
      taskModel.toFirestore(),
    );
  }

  static Future<bool> createUserWithEmailAndPassword(String emailAddress,
      String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      userID=credential.user?.uid;
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        SnackBarService.showErrorMessage("The password provided is too weak.");
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        SnackBarService.showErrorMessage(
            "The account already exists for that email.");

        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
    return Future.value(false);
  }

  static Future<bool> signIn(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      userID=credential.user?.uid;
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage("No user found for that email");
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        EasyLoading.dismiss();
        SnackBarService.showErrorMessage(
            "Wrong password provided for that user");
        return Future.value(false);
      }
    }
    return Future.value(false);
  }
  static editTask(TaskModel taskModel) async {
    var collectionsRef = getCollectionRef();
    await collectionsRef.doc(taskModel.id).update(taskModel.toFirestore());


  }
  }

