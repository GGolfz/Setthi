import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/model/httpException.dart';
import '../../provider/walletProvider.dart';
import '../buttons/actionButton.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../widgets/layout/errorDialog.dart';

class EditWalletForm extends StatefulWidget {
  final WalletItem selectedWallet;
  EditWalletForm({@required this.selectedWallet});
  @override
  _EditWalletFormState createState() => _EditWalletFormState();
}

class _EditWalletFormState extends State<EditWalletForm> {
  TextEditingController _title;
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
                      'Create new wallet',
                      style: TextStyle(color: kGold500, fontSize: 20),
                    ),
                  ],
                ),
                kSizedBoxVerticalXXS,
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kNeutralWhite,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (_title.text.isEmpty) return 'Title cannot be empty';
                    return null;
                  },
                  controller: _title,
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
                            try{
                            await Provider.of<WalletProvider>(context, listen: false)
                                .removeWallet(widget.selectedWallet.id);
                            Navigator.pop(context);
                            }on HttpException catch(error){
                              showErrorDialog(context: context,text: error.message);
                            }
                          },
                        ),
                      ),
                      kSizedBoxHorizontalS,
                      Expanded(
                        child: ActionButton(
                          text: "Submit",
                          color: kGold300,
                          onPressed: () async{
                            if (_formKey.currentState.validate()) {
                              try{
                              _formKey.currentState.save();
                              await Provider.of<WalletProvider>(context,
                                      listen: false)
                                  .editWallet(
                                widget.selectedWallet.id,
                                _title.text,
                                widget.selectedWallet.amount,
                              );
                              Navigator.pop(context);
                              }on HttpException catch(error){
                                showErrorDialog(context: context,text: error.message);
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
