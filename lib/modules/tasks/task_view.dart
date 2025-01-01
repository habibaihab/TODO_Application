import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_project/core/firebase_utils.dart';
import 'package:todo_project/model/task_model.dart';
import 'package:todo_project/modules/tasks/task_item_widget.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();

}

class _TaskViewState extends State<TaskView> {
  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();
  DateTime _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: Stack(
            clipBehavior: Clip.none,
            children:[ Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 40,
                right: 40,
              ),
              height: mediaQuery.size.height*0.22,
              width: mediaQuery.size.width,
              color: theme.primaryColor,
              child: Text("To Do List" ,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),),
            ),
              Positioned(
                top: 133,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                        print(selectedDate);
                      });
                    },
                    showTimelineHeader: false,
                    timeLineProps: const EasyTimeLineProps(
                      separatorPadding: 10,
                    ),
                    dayProps: EasyDayProps(
                      activeDayStyle:DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                      ),
                      dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),

                    ),
                  ),
                ),
              ),
  ]
          ),
        ),
        // FutureBuilder<List<TaskModel>>(
        //     future: FirebaseUtils.getOnTimeReadFromFirestore(_focusDate),
        //     builder: (context, snapshot) {
        //       if(snapshot.hasError){
        //         return const Text(
        //             "Something went wrong",);
        //       }
        //       if(snapshot.connectionState == ConnectionState.waiting){
        //         return Center(
        //           child: CircularProgressIndicator(
        //             color: theme.primaryColor,
        //           ),
        //         );
        //       }
        //       var tasksList=snapshot.data;
        //       return  Expanded(
        //         child: ListView.builder(itemBuilder: (context, index) =>  TaskItemWidget(taskModel: tasksList![index],),
        //           itemCount: tasksList?.length ??0,
        //         ),
        //       );
        //
        //     },
        // ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirebaseUtils.getRealTimeReadFromFirestore(_focusDate),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return const Text(
                  "Something went wrong",);
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                );
              }
              List<TaskModel> tasksList=snapshot.data?.docs.map((e) => e.data()).toList()??[];
              return ListView.builder(
                itemBuilder: (context, index) =>  TaskItemWidget(
                  taskModel: tasksList[index],
                ),
                itemCount: tasksList.length,
              );

            },
          ),
        ),

      ],
    );
  }
}
