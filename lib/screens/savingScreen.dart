import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/layout/customDialog.dart';
import 'package:setthi/widgets/saving/savingItem.dart';
import '../config/constants.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/saving/savingForm.dart';
import '../widgets/saving/savingItem.dart';
import '../provider/savingProvider.dart';

class SavingScreen extends StatefulWidget {
  static final routeName = '/saving';

  @override
  _SavingScreenState createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  Widget _buildButtonCreate(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: kSizeM * 1.8, vertical: kSizeS),
            child: ActionButton(
              text: "Create a new saving",
              onPressed: () {
                showCustomDialog(context: context, content: SavingForm());
              },
            )));
  }

  @override
  void initState() {
    Provider.of<SavingProvider>(context, listen: false).fetchSaving();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final savingProvider = Provider.of<SavingProvider>(context);
    return Scaffold(
        appBar: SetthiAppBar(
          title: "Saving Goal",
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeS),
          child: savingProvider.saving.isEmpty
              ? SingleChildScrollView(
                  child: Column(children: [
                  kSizedBoxVerticalXL,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("assets/images/empty-item.png")],
                  ),
                  kSizedBoxVerticalM,
                  _buildButtonCreate(context),
                ]))
              : ListView(
                  children: [
                    ...savingProvider.saving
                        .map(
                          (saving) => SavingItem(
                            item: saving,
                          ),
                        )
                        .toList(),
                    _buildButtonCreate(context)
                  ],
                ),
        ));
  }
}
