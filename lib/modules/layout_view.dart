import 'package:flutter/material.dart';
import 'package:todo_project/modules/settings/settings_view.dart';
import 'package:todo_project/modules/tasks/add_task_bottom_sheet_widget.dart';
import 'package:todo_project/modules/tasks/task_view.dart';
class LayOutView extends StatefulWidget {
  const LayOutView({super.key});
  @override
  State<LayOutView> createState() => _LayOutViewState();
}

class _LayOutViewState extends State<LayOutView> {
  List<Widget> screensList=[
    const TaskView(),
    const SettingsView(),
  ];
  int currentIndex =0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFDFECDB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (context) => AddTaskBottomSheetWidget(),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)));
      },
        elevation: 4,
        backgroundColor : Colors.white,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),),
        child:CircleAvatar(
          backgroundColor:theme.primaryColor,
          radius:24,
          child: Icon(Icons.add,size: 35 ,color: Colors.white)
          ,
        ) ,

      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: Colors.white,
        padding: EdgeInsets.zero ,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap:(value) {
           setState(() {
             currentIndex=value;
           });
          },
          items: const [

            BottomNavigationBarItem(icon: ImageIcon(
              AssetImage("assets/icons/tasks_icn.png"),
            ),
              label:"Tasks",
            ),

            BottomNavigationBarItem(icon: ImageIcon(
              AssetImage("assets/icons/settings_icn.png"),
            ),
              label:"Settings",
            ),
          ],
        ),
      ),
      body: screensList[currentIndex],

    );
  }
}
