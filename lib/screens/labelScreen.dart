import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../model/formType.dart';
import '../model/labelType.dart';
import '../provider/labelProvider.dart';
import '../widgets/buttons/actionButton.dart';
import '../widgets/label/labelForm.dart';
import '../widgets/label/labelItem.dart';
import '../widgets/label/labelTypeSelect.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/customDialog.dart';
import '../widgets/layout/divider.dart';

class LabelScreen extends StatefulWidget {
  static const routeName = '/label';

  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  var _status = LabelType.Income;

  @override
  void initState() {
    super.initState();
  }

  void _changeStatus(LabelType status) {
    setState(() {
      _status = status;
    });
  }

  Widget _buildSelection() {
    return Container(
      height: 40,
      child: Row(
        children: [
          LabelTypeSelect(
              text: "Income Title",
              type: LabelType.Income,
              changeStatus: _changeStatus,
              current: _status),
          LabelTypeSelect(
              text: "Expense Title",
              type: LabelType.Expense,
              changeStatus: _changeStatus,
              current: _status),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Prefilled Title',
          leading: BackButton(),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXS),
          child: Column(
            children: [
              _buildSelection(),
              kSizedBoxVerticalS,
              Container(
                height: MediaQuery.of(context).size.height * 0.67,
                child: Consumer<LabelProvider>(builder: (ctx, labels, _) {
                  final labelList = labels.getLabelByType(_status);
                  return ListView.separated(
                      itemBuilder: (ctx, index) => LabelItem(
                            labelText: labelList[index].name ?? '',
                            onTap: () {
                              showCustomDialog(
                                  context: context,
                                  content: LabelForm(
                                    type: FormType.Edit,
                                    labelKey: labelList[index].id,
                                    labelText: labelList[index].name,
                                    labelType: labelList[index].stringType,
                                  ));
                            },
                          ),
                      separatorBuilder: (ctx, index) => CustomDivider(),
                      itemCount: labelList.length);
                }),
              ),
              kSizedBoxVerticalS,
              Container(
                  width: 220,
                  child: ActionButton(
                    text: "Create a new title",
                    onPressed: () {
                      showCustomDialog(
                          context: context,
                          content: LabelForm(type: FormType.Create));
                    },
                  ))
            ],
          ),
        ));
  }
}
