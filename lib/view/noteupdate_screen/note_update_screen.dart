import 'package:flutter/material.dart';
import 'package:notessphere/controller/home_screen_controller.dart';
import 'package:notessphere/utils/constants/color_constants.dart';
import 'package:provider/provider.dart';

class NoteUpdateScreen extends StatefulWidget {
  final String title;
  final String content;
  final int id;
  const NoteUpdateScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.id});

  @override
  State<NoteUpdateScreen> createState() => _NoteUpdateScreenState();
}

class _NoteUpdateScreenState extends State<NoteUpdateScreen> {
  late TextEditingController notetitlecontroller;
  late TextEditingController? notecontentcontroller;
  @override
  void initState() {
    notetitlecontroller = TextEditingController(text: widget.title);
    notecontentcontroller = TextEditingController(text: widget.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.textcolor,
            )),
        centerTitle: true,
        title: Text(
          'Update Note',
          style: TextStyle(
              color: ColorConstants.textcolor,
              fontWeight: FontWeight.bold,
              fontSize: 28),
        ),
        backgroundColor: ColorConstants.primarycolor,
      ),
      body: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 15),
        color: ColorConstants.primarycolor,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: notetitlecontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16), // Adjust padding
                filled: true,
                fillColor: ColorConstants.lightbluecolor, // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                  borderSide: BorderSide.none, // Remove the outline border
                ),
                hintText: 'Note Title', // Hint for note title
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.primarycolor, // Color of the hint text
                ),
              ),
              style: TextStyle(
                fontSize: 18,
                color: ColorConstants.primarycolor,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: notecontentcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              maxLines: 6, // Multi-line input for note content
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                filled: true,
                fillColor: ColorConstants.lightbluecolor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Note Content', // Hint for note content
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: ColorConstants.primarycolor,
                ),
              ),
              style:
                  TextStyle(fontSize: 18, color: ColorConstants.primarycolor),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                context.read<HomeScreenController>().updatenote(
                    widget.id,
                    notetitlecontroller?.text ?? 'no',
                    notecontentcontroller?.text ?? 'no');
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstants.lightbluecolor,
                    borderRadius: BorderRadius.circular(15)),
                height: 60,
                width: 160,
                child: Center(
                  child: Text(
                    'Update Note',
                    style: TextStyle(
                        color: ColorConstants.primarycolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
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
