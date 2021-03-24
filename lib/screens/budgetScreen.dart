import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/constants.dart';
import 'package:setthi/widgets/budget/budgetForm.dart';
import '../widgets/budget/BudgetItem.dart';

class BudgetScreen extends StatefulWidget {
  static final routeName = '/budget';

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

Widget _bottomModalContainer(Widget widget) {
 return Container(
    height: 380,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: kSizeS * 1.5, vertical: kSizeS),
    decoration: BoxDecoration(
      color: kNeutral450,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kSizeM),
        topRight: Radius.circular(kSizeM),
      ),
    ),
    child: widget,
  );
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      barrierColor: kTransparent,
      isScrollControlled: true,
      backgroundColor: kTransparent,
      builder: (ctx) {
        return Wrap(
          children: [
            _bottomModalContainer(
              BudgetForm(),
            ),
          ],
        );
      });
}

class _BudgetScreenState extends State<BudgetScreen> {
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
              child: BudgetItem(
                  'Pandora', 6000, 'March 1, 2021', 'March 31, 2021')),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
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
