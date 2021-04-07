import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/model/http_exception.dart';
import '../../provider/savingProvider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../buttons/actionButton.dart';
import '../../widgets/layout/errorDialog.dart';

class SavingEditForm extends StatefulWidget {
  final Saving selectedSaving;
  SavingEditForm({@required this.selectedSaving});
  @override
  _SavingEditFormState createState() => _SavingEditFormState();
}

class _SavingEditFormState extends State<SavingEditForm> {
  String title = "";
  String amount = "";
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    TextEditingController _controller =
        new TextEditingController(text: widget.selectedSaving.title);
    TextEditingController _controllerAmount = new TextEditingController(
        text: widget.selectedSaving.targetAmount.toString());
    return Wrap(children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit New Saving',
                    style: TextStyle(color: kGold500, fontSize: 20),
                  ),
                ],
              ),
              kSizedBoxVerticalXXS,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  filled: true,
                  fillColor: kNeutralWhite,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) return 'Title cannot be empty';
                  return null;
                },
                controller: _controller,
              ),
              kSizedBoxVerticalS,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'SavingGoal',
                  filled: true,
                  fillColor: kNeutralWhite,
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) return 'Title cannot be empty';
                  return null;
                },
                controller: _controllerAmount,
              ),
              kSizedBoxVerticalS,
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ActionButton(
                        text: "Delete",
                        color: kRed400,
                        isOutlined: true,
                        onPressed: () async {
                          try {
                            await Provider.of<SavingProvider>(context,
                                    listen: false)
                                .deleteSaving(widget.selectedSaving.id);
                            Navigator.pop(context);
                          } on HttpException catch (error) {
                            showErrorDialog(
                                context: context, text: error.message);
                          }
                        },
                      ),
                    ),
                    kSizedBoxHorizontalS,
                    Expanded(
                      child: ActionButton(
                        text: "Submit",
                        color: kGold300,
                        onPressed: () async {
                          try {
                            await Provider.of<SavingProvider>(context,
                                    listen: false)
                                .editSaving(widget.selectedSaving.id,
                                    _controller.text, _controllerAmount.text);
                            Navigator.pop(context);
                          } on HttpException catch (error) {
                            showErrorDialog(
                                context: context, text: error.message);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
