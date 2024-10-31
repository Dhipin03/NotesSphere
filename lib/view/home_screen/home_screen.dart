import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notessphere/utils/constants/color_constants.dart';
import 'package:notessphere/utils/constants/image_constants.dart';
import 'package:notessphere/view/notes_screen/notes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primarycolor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          color: ColorConstants.primarycolor,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NoteSphere',
                style: GoogleFonts.roboto(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textcolor),
              ),
              SizedBox(height: 22),
              _buildProgressSection(),
              SizedBox(height: 22),
              buildDashboardCardRow(),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Progress",
                    style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textcolor),
                  ),
                  Text(
                    "See all",
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.textcolor),
                  )
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.secondarycolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 80,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: ListTile(
                            trailing: Icon(
                              Icons.done_all,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Read a Book',
                              style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.textcolor),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: 3),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildDashboardCardRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesScreen(),
                ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
            height: 140,
            decoration: BoxDecoration(
                color: ColorConstants.secondarycolor,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Image.asset(
                  ImageConstants.notesicon,
                  height: 50,
                ),
                SizedBox(height: 8),
                Text(
                  'Notes',
                  style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.textcolor),
                ),
                SizedBox(height: 3),
                Text(
                  '3 Notes',
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: ColorConstants.textcolor),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          height: 140,
          decoration: BoxDecoration(
              color: ColorConstants.secondarycolor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Image.asset(
                ImageConstants.todoicon,
                height: 50,
              ),
              SizedBox(height: 8),
              Text(
                'To-Do List',
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textcolor),
              ),
              SizedBox(height: 3),
              Text(
                '3 Tasks',
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: ColorConstants.textcolor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container _buildProgressSection() {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.secondarycolor,
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      height: 120,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textcolor),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "You have completed 1 out of 3 tasks,\nkeep up the progress!",
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: ColorConstants.textcolor),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: 45),
          CircleAvatar(
            backgroundColor: ColorConstants.primarycolor,
            radius: 40,
            child: Center(
              child: Text(
                '33%',
                style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.textcolor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
