import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/transactionType.dart';
import 'package:setthi/provider/walletProvider.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDatePicker.dart';
import 'package:setthi/widgets/form/customDropDown.dart';
import 'package:setthi/widgets/form/customTextField.dart';
import 'package:setthi/widgets/transaction/selectTypeBar.dart';
import 'package:setthi/widgets/transaction/walletList.dart';

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  TransactionType _current = TransactionType.Income;
  WalletItem selectedWallet;
  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  String _category = "Salary";
  @override
  void initState() {
    super.initState();
    _fetchFirstWallet();
  }

  void _fetchFirstWallet() {
    var wallet = Provider.of<WalletProvider>(context);
    if (!wallet.isEmpty()) {
      selectedWallet = wallet.wallets[0];
    }
  }

  Widget _renderForm(context) {
    final category = ["Salary", "Food", "Shopping", "Travel"];
    final label = ["Salary", "Bonus", "Gift"];
    switch (_current) {
      case TransactionType.Income:
      case TransactionType.Expense:
      case TransactionType.Saving:
      default:
        return Consumer<WalletProvider>(
            builder: (ctx, wallet, _) => Container(
                  height: 504,
                  child: Wrap(children: [
                    SingleChildScrollView(
                        child: Column(
                      children: [
                        kSizedBoxVerticalXS,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Wallet",
                              style: kHeadline4Black.copyWith(
                                  color: kNeutral400,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        kSizedBoxVerticalXXS,
                        Container(
                            width: double.infinity,
                            height: 75,
                            child: WalletList(
                              selected: selectedWallet,
                              wallets: wallet.wallets,
                              onSelect: (id) {
                                setState(() {
                                  selectedWallet = id;
                                });
                              },
                            )),
                        kSizedBoxVerticalXXS,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: wallet.wallets.map((w) {
                              return Container(
                                width: kSizeXS,
                                height: kSizeXS,
                                margin:
                                    EdgeInsets.symmetric(horizontal: kSizeXXXS),
                                decoration: BoxDecoration(
                                    borderRadius: kBorderRadiusXXS,
                                    color: w.id == selectedWallet.id
                                        ? kGold300
                                        : kNeutral200),
                              );
                            }).toList()),
                        kSizedBoxVerticalXS,
                        CustomTextField(
                            title: 'Title', textEditingController: _title),
                        kSizedBoxVerticalXS,
                        Row(
                            children: label
                                .map((e) => GestureDetector(
                                      child: Container(
                                        child: Text(e),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 2),
                                      ),
                                      onTap: () {
                                        _title.text = e;
                                      },
                                    ))
                                .toList()),
                        kSizedBoxVerticalS,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Amount",
                              style: kBody1Black.copyWith(
                                  color: kNeutral450,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [Text("THB")],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            kSizedBoxHorizontalXS,
                            Expanded(
                              child: CustomTextField(
                                title: '',
                                textEditingController: _amount,
                              ),
                            )
                          ],
                        ),
                        kSizedBoxVerticalXS,
                        CustomDropDown(
                            title: 'Category',
                            currentValue: _category,
                            items: category,
                            onChanged: (val) {
                              setState(() {
                                _category = val;
                              });
                            }),
                        kSizedBoxVerticalXS,
                        CustomDatePicker(
                            title: 'Date',
                            getDateTime: (val) {},
                            dateTime: DateTime.now()),
                        kSizedBoxVerticalXS,
                        ActionButton(
                          text: "Save",
                          color: kGold300,
                        )
                      ],
                    ))
                  ]),
                ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        width: 400,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SelectTypeBar(
                current: _current,
                onChange: (value) {
                  setState(() {
                    _current = value;
                  });
                }),
            _renderForm(context)
          ],
        )));
  }
}
