import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:notessphere/controller/home_screen_controller.dart';
import 'package:notessphere/utils/constants/color_constants.dart';
import 'package:notessphere/utils/constants/image_constants.dart';
import 'package:notessphere/view/notes_screen/notes_screen.dart';
import 'package:notessphere/view/todo_screen/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().refreshTaskData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.primarycolor,
      body: SafeArea(
        child: Consumer<HomeScreenController>(
          builder: (context, value, child) => Container(
            height: height,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            color: ColorConstants.primarycolor,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NoteSphere',
                  style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textcolor,
                  ),
                ),
                const SizedBox(height: 22),
                _buildProgressSection(),
                const SizedBox(height: 22),
                _buildDashboardCardRow(),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Progress",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textcolor,
                      ),
                    ),
                    Text(
                      "See all",
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textcolor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildCompletedTasksList(value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedTasksList(HomeScreenController value) {
    return ListView.separated(
      itemCount:
          value.completedTasks!.length > 4 ? 4 : value.completedTasks!.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: ColorConstants.secondarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: ListTile(
          trailing: const Icon(
            Icons.done_all,
            color: Colors.green,
          ),
          title: Text(
            value.completedTasks?[index]['task']?.toString() ?? 'No Task Added',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textcolor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCardRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDashboardCard(
          'Notes',
          ImageConstants.notesicon,
          context.watch<HomeScreenController>().notelist?.length.toString() ??
              '0',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotesScreen()),
          ),
        ),
        _buildDashboardCard(
          'To-Do List',
          ImageConstants.todoicon,
          context
                  .watch<HomeScreenController>()
                  .pendingTasks
                  ?.length
                  .toString() ??
              '0',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard(
      String title, String iconPath, String count, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        height: 140,
        decoration: BoxDecoration(
          color: ColorConstants.secondarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              iconPath,
              height: 50,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorConstants.textcolor,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              '$count ${title == 'Notes' ? 'Notes' : 'Tasks'}',
              style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: ColorConstants.textcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Consumer<HomeScreenController>(
      builder: (context, providerObj, child) => Container(
        decoration: BoxDecoration(
          color: ColorConstants.secondarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        height: 120,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Progress",
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.textcolor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "You have completed ${providerObj.completedTaskCount} out of ${providerObj.completedTaskCount + providerObj.pendingTaskCount} tasks,\nkeep up the progress!",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: ColorConstants.textcolor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 45),
            CircleAvatar(
              backgroundColor: ColorConstants.primarycolor,
              radius: 40,
              child: Center(
                child: Text(
                  '${providerObj.result}%',
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textcolor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
