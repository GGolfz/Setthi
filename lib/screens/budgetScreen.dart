import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/constants.dart';
import 'package:setthi/widgets/budget/budgetForm.dart';
import '../widgets/budget/BudgetItem.dart';
import '../widgets/budget/models/Budget.dart';

class BudgetScreen extends StatefulWidget {
  static final routeName = '/budget';

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

final List<Budget> _budget = [];
Widget _buildButtonCreate(BuildContext context, Function _addNewBudget) {
  return Center(
    child: Container(
      margin: EdgeInsets.all(5),
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          _settingModalBottomSheet(context, _addNewBudget);
        },
        style: ElevatedButton.styleFrom(
          primary: kNeutral450,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text("Create a new budget",
            style: GoogleFonts.quicksand(fontSize: 15)),
      ),
    ),
  );
}

Widget _bottomModalContainer(Widget widget) {
  return Container(
    height: 450,
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

void _settingModalBottomSheet(context, Function addNewBudget) {
  showModalBottomSheet(
      context: context,
      barrierColor: kTransparent,
      isScrollControlled: true,
      backgroundColor: kTransparent,
      builder: (ctx) {
        return Wrap(
          children: [
            _bottomModalContainer(
              BudgetForm(addBudget: addNewBudget),
            ),
          ],
        );
      });
}

class _BudgetScreenState extends State<BudgetScreen> {
  void _addNewBudget(
      String title, int maxBudget, String startday, String lastDay) {
    final newBudget = Budget(
        title: title,
        maxBudget: maxBudget,
        startDay: startday,
        endDay: lastDay);
    setState(() {
      _budget.add(newBudget);
      print(_budget.length);
    });
  }

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
      body: _budget.isEmpty
          ? Column(children: [
              Text('Please add new budget'),
              _buildButtonCreate(context, _addNewBudget)
            ])
          : ListView(
              children: [
                ..._budget
                    .map(
                      (budget) => BudgetItem(budget.title, budget.maxBudget,
                          budget.startDay.toString(), budget.endDay.toString()),
                    )
                    .toList(),
                _buildButtonCreate(context, _addNewBudget)
              ],
            ),
    );
  }
}
