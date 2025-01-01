import 'package:flutter/material.dart';
import 'package:todo_project/core/firebase_utils.dart';
import 'package:todo_project/model/task_model.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    TaskModel task=ModalRoute.of(context)?.settings.arguments as TaskModel;
    return  Scaffold(
      backgroundColor: const Color(0xFFDFECDB),
      appBar: AppBar(
        title: const Text("To Do List",style: TextStyle(fontSize: 25),),
        backgroundColor:const Color(0xFF5D9CEC) ,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 600,
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),

              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Edit Task",style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
                  TextFormField(
                    initialValue: task.title,
                    onChanged: (value) {
                      task.title=value;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: "This is Title",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: task.description,
                    onChanged: (value) {
                      task.description=value;
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: "Task Details",
                    ),
                  ),
                  const SizedBox(height: 25,),
                  const Text("Select Time ",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                      ,color: Colors.black,
                  ),),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(context: context,
                          initialDate: DateUtils.dateOnly(task.selectedDate),
                          firstDate: DateTime.now(),
                          lastDate:DateTime.now().add(const Duration(days: 365))
                      ).then((value) {
                        setState(() {
                          task.selectedDate =DateUtils.dateOnly(value!);
                        });
                      });
                    },
                    child: Text(DateUtils.dateOnly(task.selectedDate).toString().substring(0,10)
                      ,style: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseUtils.editTask(task);
                        Navigator.pop(context);
                  }, child:const Text("Save Changes") )


                ],
              ),
            )
          ],
        ),
      ),


    );
  }
}
