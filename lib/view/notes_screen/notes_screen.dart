import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notessphere/controller/home_screen_controller.dart';
import 'package:notessphere/utils/constants/color_constants.dart';
import 'package:notessphere/view/home_screen/home_screen.dart';
import 'package:notessphere/view/notes_detail_screen/notesdetail_screen.dart';
import 'package:notessphere/view/noteupdate_screen/note_update_screen.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController notetiltlecontroller = TextEditingController();
  TextEditingController noteContentcontroller = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<HomeScreenController>().getnotes();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notesList = context.watch<HomeScreenController>().notelist ?? [];
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: ColorConstants.lightbluecolor,
            ),
            borderRadius: BorderRadius.circular(30)),
        child: FloatingActionButton(
          backgroundColor: ColorConstants.textcolor,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.5, // Initial height of the bottom sheet
                minChildSize: 0.3, // Minimum height when collapsed
                maxChildSize: 1.0, // Maximum height when fully expanded
                expand: false, // Prevents expanding to full height immediately
                builder: (context, scrollController) {
                  return StatefulBuilder(
                    builder: (context, setState) => Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 25),
                      decoration: BoxDecoration(
                        color: ColorConstants.primarycolor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller:
                            scrollController, // Attach the scroll controller here
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Create Note',
                                style: GoogleFonts.roboto(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.textcolor),
                              ),
                            ),
                            SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: notetiltlecontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.all(16), // Adjust padding
                                      filled: true,
                                      fillColor: ColorConstants
                                          .lightbluecolor, // Background color
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Rounded borders
                                        borderSide: BorderSide
                                            .none, // Remove the outline border
                                      ),
                                      hintText:
                                          'Note Title', // Hint for note title
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants
                                            .primarycolor, // Color of the hint text
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.primarycolor,
                                    ),
                                  ),
                                  SizedBox(
                                      height: 20), // Spacing between fields
                                  TextFormField(
                                    controller: noteContentcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    maxLines:
                                        6, // Multi-line input for note content
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16),
                                      filled: true,
                                      fillColor: ColorConstants.lightbluecolor,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText:
                                          'Note Content', // Hint for note content
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.primarycolor,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.primarycolor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<HomeScreenController>()
                                        .addnotes(notetiltlecontroller.text,
                                            noteContentcontroller.text);
                                  }
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.lightbluecolor,
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Text(
                                    'Save Note',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.primarycolor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Icon(
            Icons.add,
            color: ColorConstants.primarycolor,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorConstants.primarycolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.textcolor,
            )),
      ),
      body: Container(
        width: double.infinity,
        color: ColorConstants.primarycolor,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes",
              style: GoogleFonts.roboto(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.textcolor),
            ),
            SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                itemCount: notesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.79),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotesdetailScreen(
                            content:
                                notesList[index]['notecontent']?.toString() ??
                                    'No Content',
                            title: notesList[index]['title']?.toString() ??
                                'No Title',
                          ),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.secondarycolor,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 90),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NoteUpdateScreen(
                                          title: notesList[index]['title']
                                                  ?.toString() ??
                                              'No Title',
                                          content: notesList[index]
                                                      ['notecontent']
                                                  ?.toString() ??
                                              'No Content',
                                          id: notesList[index]['id'],
                                        ),
                                      ));
                                },
                                child: Icon(
                                  size: 22,
                                  Icons.edit,
                                  color: ColorConstants.textcolor,
                                ),
                              ),
                              SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<HomeScreenController>()
                                      .deletenote(notesList[index]['id']);
                                },
                                child: Icon(
                                  size: 22,
                                  Icons.delete,
                                  color: ColorConstants.textcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          notesList[index]['title']?.toString() ??
                              'Untitled Note',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.textcolor),
                        ),
                        SizedBox(height: 8),
                        Text(
                          notesList[index]['notecontent'].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          softWrap: true,
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: ColorConstants.textcolor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
