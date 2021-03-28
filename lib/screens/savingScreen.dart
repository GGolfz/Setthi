import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/color.dart';
import '../config/constants.dart';
import '../config/string.dart';
import '../config/style.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/budget/budgetForm.dart';
import '../widgets/budget/budgetItem.dart';
import '../widgets/budget/models/Budget.dart';

class SavingScreen extends StatefulWidget {
  static final routeName = '/saving';

  @override
  _SavingScreenState createState() => _SavingScreenState();
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
        child: Text("Create a new budget", style: kBody1White),
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

class _SavingScreenState extends State<SavingScreen> {
  void _addNewBudget(
      String title, double maxBudget, DateTime startDay, DateTime lastDay) {
    final newBudget = Budget(
        title: title,
        maxBudget: maxBudget,
        startDay: DateFormat.yMMMd().format(startDay),
        endDay: DateFormat.yMMMd().format(lastDay));
    setState(() {
      _budget.add(newBudget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: "Saving Goal",
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeS),
          child: _budget.isEmpty
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("assets/images/empty-item.png")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(noBudgetText, style: kSubtitle2Black),
                    ],
                  ),
                  kSizedBoxVerticalM,
                  _buildButtonCreate(context, _addNewBudget)
                ])
              : ListView(
                  children: [
                    ..._budget
                        .map(
                          (budget) => BudgetItem(
                              budget.title,
                              budget.maxBudget,
                              budget.startDay.toString(),
                              budget.endDay.toString()),
                        )
                        .toList(),
                    _buildButtonCreate(context, _addNewBudget)
                  ],
                ),
        ));
  }
}