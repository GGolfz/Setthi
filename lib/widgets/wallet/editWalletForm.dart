import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/walletProvider.dart';
import '../buttons/actionButton.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class EditWalletForm extends StatefulWidget {
  final WalletItem selectedWallet;
  EditWalletForm({@required this.selectedWallet});
  @override
  _EditWalletFormState createState() => _EditWalletFormState();
}

class _EditWalletFormState extends State<EditWalletForm> {
  String _title = "";
  @override
  void initState() {
    _title = widget.selectedWallet.title;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    TextEditingController _controller =
        new TextEditingController(text: widget.selectedWallet.title);
    return Container(
      width: 400,
      height: 160,
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
                if (value.isEmpty) return 'Title cannot be empty';
                return null;
              },
              controller: _controller,
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
                      onPressed: () {
                        wallet.removeWallet(widget.selectedWallet.id);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  kSizedBoxHorizontalS,
                  Expanded(
                    child: ActionButton(
                      text: "Submit",
                      color: kGold300,
                      onPressed: () {
                        wallet.editWallet(widget.selectedWallet.id,
                            _controller.text, widget.selectedWallet.amount);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
