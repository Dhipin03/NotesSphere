import 'package:flutter/material.dart';
import 'package:notessphere/utils/constants/color_constants.dart';

class NoteUpdateScreen extends StatefulWidget {
  const NoteUpdateScreen({super.key});

  @override
  State<NoteUpdateScreen> createState() => _NoteUpdateScreenState();
}

class _NoteUpdateScreenState extends State<NoteUpdateScreen> {
  TextEditingController noteContentcontroller =
      TextEditingController(text: 'gafsdjhagsdhasgdjhasgd');
  TextEditingController notetitlecontroller =
      TextEditingController(text: 'gafsdjhagsdhasgdjhasgd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              controller: noteContentcontroller,
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
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
