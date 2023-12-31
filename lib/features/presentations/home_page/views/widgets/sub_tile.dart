import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jym_app/features/data/models/subscriber_model.dart';
import 'package:jym_app/features/presentations/home_page/views/widgets/progress_indicator.dart';

class SubTile extends StatelessWidget {
  const SubTile({Key? key, required this.subs, required this.checkDate})
      : super(key: key);
  final SubscriberModel subs;
  final DateTime checkDate;
  @override
  Widget build(BuildContext context) {
    return checkDate.compareTo(DateFormat("dd/MM/y").parse(subs.upToRecord!)) <
            0
        ? Container()
        : Container(
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
                      //Text(subs.image!.path),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time_rounded,
                              color: Colors.grey[200], size: 18),
                          const SizedBox(width: 4),
                          Text(
                            " مشترك لغاية  ${subs.upToRecord}",
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
                      MyProgressIndicator(
                          steps: checkDate
                                      .difference(DateFormat("dd/MM/y")
                                          .parse(subs.upToRecord!))
                                      .inDays >
                                  30
                              ? 30
                              : checkDate
                                  .difference(DateFormat("dd/MM/y")
                                      .parse(subs.upToRecord!))
                                  .inDays
                          // checkDate.compareTo(
                          //     DateFormat("dd/MM/y").parse(subs.upToRecord!))

                          )
                    ],
                  )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    width: 0.5,
                    color: Colors.grey[200]!.withOpacity(0.7),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      _daysLate(),
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  String _daysLate() {
    return (checkDate
                .difference(DateFormat("dd/MM/y").parse(subs.upToRecord!))
                .inDays ==
            0
        ? "Not late"
        : "${checkDate.difference(DateFormat("dd/MM/y").parse(subs.upToRecord!)).inDays} days late");
  }
}

Color overColor() {
  return Colors.greenAccent;
}
