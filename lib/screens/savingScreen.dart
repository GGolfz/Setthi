import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../model/httpException.dart';
import '../provider/savingProvider.dart';
import '../widgets/buttons/actionButton.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/customDialog.dart';
import '../widgets/layout/errorDialog.dart';
import '../widgets/saving/savingForm.dart';
import '../widgets/saving/savingItem.dart';
import '../widgets/saving/savingTitleToggle.dart';

class SavingScreen extends StatefulWidget {
  static final routeName = '/saving';

  @override
  _SavingScreenState createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  var inProcessOpen = true;
  var finishOpen = false;
  var usedOpen = false;

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
    fetchSaving();
    super.initState();
  }

  void fetchSaving() async {
    try {
      await Provider.of<SavingProvider>(context, listen: false).fetchSaving();
    } on HttpException catch (error) {
      showErrorDialog(
          context: context,
          text: error.message,
          isNetwork: error.isInternetProblem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: "Saving Goal",
        ),
        body: SingleChildScrollView(
            child: Consumer<SavingProvider>(
                builder: (ctx, saving, _) => Container(
                    padding: EdgeInsets.symmetric(
                        vertical: kSizeS, horizontal: kSizeS),
                    child: Column(
                        mainAxisAlignment: saving.saving.isEmpty
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          saving.saving.isEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/empty-item.png")
                                  ],
                                )
                              : Container(
                                  height: 500,
                                  child: ListView(
                                    children: [
                                      SavingTitleToggle(
                                        text: "In Progress",
                                        isOpen: inProcessOpen,
                                        toggle: () {
                                          setState(() {
                                            inProcessOpen = !inProcessOpen;
                                          });
                                        },
                                      ),
                                      if (inProcessOpen)
                                        ...saving.saving.inProcess
                                            .map(
                                              (saving) => SavingItem(
                                                item: saving,
                                              ),
                                            )
                                            .toList(),
                                      SavingTitleToggle(
                                        text: "Finished",
                                        isOpen: finishOpen,
                                        toggle: () {
                                          setState(() {
                                            finishOpen = !finishOpen;
                                          });
                                        },
                                      ),
                                      if (finishOpen)
                                        ...saving.saving.finish
                                            .map(
                                              (saving) => SavingItem(
                                                item: saving,
                                              ),
                                            )
                                            .toList(),
                                      SavingTitleToggle(
                                        text: "Used",
                                        isOpen: usedOpen,
                                        toggle: () {
                                          setState(() {
                                            usedOpen = !usedOpen;
                                          });
                                        },
                                      ),
                                      if (usedOpen)
                                        ...saving.saving.used
                                            .map(
                                              (saving) => SavingItem(
                                                item: saving,
                                              ),
                                            )
                                            .toList(),
                                    ],
                                  )),
                          kSizedBoxVerticalS,
                          _buildButtonCreate(context)
                        ])))));
  }
}
