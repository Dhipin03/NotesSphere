import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notessphere/utils/constants/color_constants.dart';

class NotesdetailScreen extends StatefulWidget {
  final String title;
  final String content;
  const NotesdetailScreen(
      {super.key, required this.content, required this.title});

  @override
  State<NotesdetailScreen> createState() => _NotesdetailScreenState();
}

class _NotesdetailScreenState extends State<NotesdetailScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primarycolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstants.textcolor,
            )),
      ),
      body: Container(
        width: width,
        color: ColorConstants.primarycolor,
        child: Column(
          children: [
            Text(
              widget.title,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: ColorConstants.textcolor),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Text(
                widget.content,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: ColorConstants.textcolor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
