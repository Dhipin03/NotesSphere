import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notessphere/controller/home_screen_controller.dart';
import 'package:notessphere/utils/constants/color_constants.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // Fetch both pending and completed tasks
        final controller = context.read<HomeScreenController>();
        controller.getPendingTasks();
        controller.getCompletedTasks();
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController taskcontroller = TextEditingController();
  final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: ColorConstants.primarycolor,
                  title: Text(
                    "Add Task",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ColorConstants.secondarycolor,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: taskcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: ColorConstants.textcolor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your task',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: ColorConstants.secondarycolor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorConstants.secondarycolor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorConstants.secondarycolor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context
                              .read<HomeScreenController>()
                              .addtask(taskcontroller.text, date);
                          taskcontroller.clear(); // Clear the controller
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstants.secondarycolor,
                        ),
                      ),
                      child: Text(
                        'Add Task',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: ColorConstants.textcolor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstants.secondarycolor,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: ColorConstants.textcolor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: ColorConstants.textcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            Icons.add,
            color: ColorConstants.primarycolor,
          ),
        ),
        appBar: AppBar(
          backgroundColor: ColorConstants.primarycolor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.textcolor,
            ),
          ),
          bottom: TabBar(
            dividerColor: ColorConstants.lightbluecolor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: ColorConstants.lightbluecolor,
            labelStyle: GoogleFonts.roboto(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            unselectedLabelColor: ColorConstants.textcolor,
            labelColor: ColorConstants.secondarycolor,
            tabs: const [
              Tab(text: 'ToDo'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: Consumer<HomeScreenController>(
          builder: (context, provider, child) => Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            color: ColorConstants.primarycolor,
            child: TabBarView(
              children: [
                // Pending Tasks Tab
                ListView.separated(
                  itemCount: provider.pendingTasks?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.secondarycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 70,
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          provider.completeTask(
                            provider.pendingTasks![index]['id'],
                          );
                        },
                        icon: Icon(
                          Icons.done,
                          color: ColorConstants.textcolor,
                        ),
                      ),
                      title: Text(
                        provider.pendingTasks?[index]['task'].toString() ??
                            'No Task added',
                        style: GoogleFonts.roboto(
                          color: ColorConstants.textcolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        provider.pendingTasks?[index]['date'].toString() ??
                            'No date added',
                        style: GoogleFonts.roboto(
                          color: ColorConstants.textcolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                // Completed Tasks Tab
                ListView.separated(
                  itemCount: provider.completedTasks?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.secondarycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 70,
                    child: ListTile(
                      title: Text(
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 1,
                        provider.completedTasks?[index]['task'].toString() ??
                            'No Task added',
                        style: GoogleFonts.roboto(
                          color: ColorConstants.textcolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        provider.completedTasks?[index]['date'].toString() ??
                            'No date added',
                        style: GoogleFonts.roboto(
                          color: ColorConstants.textcolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
