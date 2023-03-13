import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class AddButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  AddButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        // margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: 120,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ThemeColor.get(context).buttonBackgroundPrimary,
        ),
        child: Text(
          label,
          style: GoogleFonts.lato(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
