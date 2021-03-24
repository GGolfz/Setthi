import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';

class BudgetScreen extends StatelessWidget {
  static final routeName = '/budget';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Budget',
          style: GoogleFonts.quicksand(color: kNeutralBlack, fontSize: 25),
        ),
        backgroundColor: kGold200,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PANDORA',
                    style: GoogleFonts.quicksand(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'THB 600',
                        style: GoogleFonts.quicksand(
                            fontSize: 20, color: kGreen500),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'of THB 6000',
                        style: GoogleFonts.quicksand(
                            fontSize: 15, color: kNeutral300),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: kNeutral150,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(children: [
                        SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: kGold500,
                            ),
                            width: 50,
                            height: double.infinity,
                          ),
                          height: 50,
                          width: 50,
                        )
                      ])),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'March 1, 2021',
                        style: GoogleFonts.quicksand(color: kNeutral300),
                      ),
                      Text(
                        'March 31, 2021',
                        style: GoogleFonts.quicksand(color: kNeutral300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: kNeutral450,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: Text("Create a new budget",
                    style: GoogleFonts.quicksand(fontSize: 15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
