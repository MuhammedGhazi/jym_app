import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/sub_tile.dart';

class CatgTile extends StatelessWidget {
  const CatgTile({Key? key, required this.catg}) : super(key: key);
  final String catg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: overColor(),
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(
              catg,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 30,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
