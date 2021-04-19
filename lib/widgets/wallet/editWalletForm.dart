import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../buttons/actionButton.dart';
import '../form/customTextField.dart';
import '../layout/errorDialog.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../model/httpException.dart';
import '../../provider/walletProvider.dart';

class EditWalletForm extends StatefulWidget {
  final WalletItem selectedWallet;
  EditWalletForm({@required this.selectedWallet});
  @override
  _EditWalletFormState createState() => _EditWalletFormState();
}

class _EditWalletFormState extends State<EditWalletForm> {
  TextEditingController _title;
  var isLoading = false;
  var isLoadingDelete = false;
  @override
  void initState() {
    _title = TextEditingController(text: widget.selectedWallet.title);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit wallet',
                      style: TextStyle(color: kGold500, fontSize: 20),
                    ),
                  ],
                ),
                kSizedBoxVerticalXXS,
                CustomTextField(title: 'Title', textEditingController: _title),
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
                          isLoading: isLoadingDelete,
                          onPressed: () async {
                            try {
                              setState(() {
                                isLoadingDelete = true;
                              });
                              await Provider.of<WalletProvider>(context,
                                      listen: false)
                                  .removeWallet(widget.selectedWallet.id);
                              setState(() {
                                isLoadingDelete = false;
                              });
                              Navigator.pop(context);
                            } on HttpException catch (error) {
                              showErrorDialog(
                                  context: context,
                                  text: error.message,
                                  isNetwork: error.isInternetProblem);
                              setState(() {
                                isLoadingDelete = false;
                              });
                            }
                          },
                        ),
                      ),
                      kSizedBoxHorizontalS,
                      Expanded(
                        child: ActionButton(
                          text: "Submit",
                          color: kGold300,
                          isLoading: isLoading,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                await Provider.of<WalletProvider>(context,
                                        listen: false)
                                    .editWallet(
                                  widget.selectedWallet.id,
                                  _title.text,
                                  widget.selectedWallet.amount,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                              } on HttpException catch (error) {
                                showErrorDialog(
                                    context: context,
                                    text: error.message,
                                    isNetwork: error.isInternetProblem);
                                setState(() {
                                  isLoading = false;
                                });
                              }
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
      ],
    );
  }
}
