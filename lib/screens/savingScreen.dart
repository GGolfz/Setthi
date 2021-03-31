import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:setthi/model/saving.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/layout/customDialog.dart';
import 'package:setthi/widgets/saving/savingItem.dart';
import '../config/constants.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/saving/savingForm.dart';
import '../widgets/saving/savingItem.dart';

class SavingScreen extends StatefulWidget {
  static final routeName = '/saving';

  @override
  _SavingScreenState createState() => _SavingScreenState();
}

final List<Saving> _saving = [];
Widget _buildButtonCreate(BuildContext context, Function _addNewBudget) {
  return Center(
      child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: kSizeM * 1.8, vertical: kSizeS),
          child: ActionButton(
            text: "Create a new saving",
            onPressed: () {
              showCustomDialog(
                  context: context,
                  content: SavingForm(
                    addBudget: _addNewBudget,
                  ));
            },
          )));
}

class _SavingScreenState extends State<SavingScreen> {
  void _addNewBudget(
      String title, double savingGoal, DateTime startDay, DateTime lastDay) {
    final newBudget = Saving(
        title: title,
        savingGoal: savingGoal,
        startDay: DateFormat.yMMMd().format(startDay),
        endDay: DateFormat.yMMMd().format(lastDay));
    setState(() {
      _saving.add(newBudget);
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
          child: _saving.isEmpty
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("assets/images/empty-item.png")],
                  ),
                  kSizedBoxVerticalM,
                  _buildButtonCreate(context, _addNewBudget)
                ])
              : ListView(
                  children: [
                    ..._saving
                        .map(
                          (saving) => SavingItem(
                              saving.title,
                              saving.savingGoal,
                              saving.startDay.toString(),
                              saving.endDay.toString()),
                        )
                        .toList(),
                    _buildButtonCreate(context, _addNewBudget)
                  ],
                ),
        ));
  }
}
