import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/core/firebase_utils.dart';
import 'package:todo_project/core/page_routes_names.dart';
import 'package:todo_project/model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskItemWidget({super.key,
  required this.taskModel
  });

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical:15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: (context) {
                EasyLoading.show();
                FirebaseUtils.deleteTask(taskModel).then((value) => EasyLoading.dismiss());
              },
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                bottomLeft: Radius.circular(18.0),
              ),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              flex: 1,
            ),
            SlidableAction(
              padding: EdgeInsets.zero,
              onPressed: (context) {
                Navigator.pushNamed(context, PageRouteName.edit,arguments: taskModel);
              },

              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              flex: 1,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: ListTile(
            leading: Container(
              width: 6,
              height: 100,
              decoration: BoxDecoration(
                color: theme.primaryColor,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskModel.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: taskModel.isDone ? const Color(0xFF61E757) : theme.primaryColor,
                      fontSize: 18,
                    ),),
                const SizedBox(height: 6,),
                Text(taskModel.description,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color:taskModel.isDone ? const Color(0xFF61E757) : Colors.black,
                    fontSize: 14,
                  ),),
                const SizedBox(height: 6,),
                Row(
                  children: [
                    const Icon(Icons.alarm ,size: 20,color: Colors.black,),
                    const SizedBox(width: 5,),
                    Text(
                      taskModel.selectTime,)
                  ],
                ),
              ],
            ),
            trailing:taskModel.isDone?
            Text("Done!",
              style: theme.textTheme.titleLarge?.copyWith(
                color: const Color(0xFF61E757),
                fontSize:24,
              ),)
            :
            InkWell(
              onTap: () {
                EasyLoading.show();
                FirebaseUtils.updateTask(taskModel).then((value) => EasyLoading.dismiss());
              },
              child: Container(
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color:  theme.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(Icons.check,color: Colors.white,size: 30,),
              ),
            ) ,

          ),
        ),
      ),
    );
  }
}
