import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_project/core/firebase_utils.dart';
import 'package:todo_project/core/services/sank_bar_service.dart';
import 'package:todo_project/model/task_model.dart';

class AddTaskBottomSheetWidget extends StatefulWidget {
  const AddTaskBottomSheetWidget({super.key});
  @override
  State<AddTaskBottomSheetWidget> createState() => _AddTaskBottomSheetWidgetState();
}
class _AddTaskBottomSheetWidgetState extends State<AddTaskBottomSheetWidget> {
  var formKey = GlobalKey<FormState>();
  TextEditingController taskController = TextEditingController();
  TextEditingController taskDetailsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(15),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Add new Task ",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),),
            const SizedBox(height: 20,),
               TextFormField(
                controller: taskController,
                decoration: const InputDecoration(
                  hintText: "Enter task title"
                ),
                validator: (value) {
                  if(value==null || value.trim().isEmpty){
                    return "plz enter your task ";
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20,),
            TextFormField(
                controller: taskDetailsController,
                decoration: const InputDecoration(
                    hintText: "Enter your task details"
                ),
                validator: (value) {
                  if(value==null || value.trim().isEmpty){
                    return "plz enter the details ";
                  }
                  return null;
                },
              ),
            const SizedBox(height: 20,),
            Text("Select Date"
            ,style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
              ),),
            const SizedBox(height: 10),
            InkWell(
              onTap:() {
                getSelectedDate();
              },
              child: Text(
                DateFormat("dd MMM yyyy").format(selectedDate)
                ,style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,

                ),textAlign: TextAlign.center,),
            ),
            const SizedBox(height: 20),
            Text(
              "Select Time",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                getSelectedTime();
              },
              child: Text(
                selectedTime != null ? selectedTime!.format(context) : "No time selected",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            FilledButton(onPressed: (){
              if(formKey.currentState!.validate()){
                var taskModel=TaskModel(title:taskController.text,
                    description: taskDetailsController.text,
                    selectedDate: selectedDate,
                  selectTime: selectedTime != null ? selectedTime!.format(context) : '',
                );
                EasyLoading.show();
                FirebaseUtils.addTaskToFirestore(taskModel).then((value) {
                  Navigator.pop(context);
                  EasyLoading.dismiss();
                  SnackBarService.showSuccessMessage("Task Successfully Added ! ");
                });
              }
            },
                style: FilledButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child:Text("Save" ,style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white
              )
              ,))

          ],
        ),
      ),
    ) ;
  }
  getSelectedDate() async {
    var currentDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate:DateTime.now().add(Duration(days: 365),),);
    if(currentDate != null){
      setState(() {
        selectedDate =currentDate;
      });
    }
  }

  getSelectedTime() async {
    var currentTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (currentTime != null) {
      setState(() {
        selectedTime = currentTime;
      });
    }
  }

}
