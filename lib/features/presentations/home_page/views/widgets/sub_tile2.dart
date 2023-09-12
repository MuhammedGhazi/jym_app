import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:jym_app/features/data/models/subscriber_model.dart';

class SubTile2 extends StatelessWidget {
  const SubTile2({Key? key, required this.subs}) : super(key: key);
  final SubscriberModel subs;

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
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subs.fullName.toString(),
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time_rounded,
                        color: Colors.grey[200], size: 18),
                    const SizedBox(width: 4),
                    Text(
                      "${subs.dateRecord}----${subs.upToRecord}",
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: subs.image == null
                          ? null
                          : FileImage(File(subs.image!.path)),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  subs.category.toString(),
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(height: 5),
              ],
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              width: 0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}

Color overColor() {
  return Colors.greenAccent;
}
