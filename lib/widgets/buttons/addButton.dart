import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/widgets/layout/congratsDialog.dart';
import '../layout/customDialog.dart';
import '../transaction/addTransactionForm.dart';
import '../../config/color.dart';
import '../../provider/savingProvider.dart';
import '../../provider/walletProvider.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: kGold200,
      ),
      backgroundColor: kNeutral450,
      onPressed: () {
        showCustomDialog(
            context: context,
            content: AddTransactionForm(
              onFinish: (result) async {
                Navigator.of(context).pop();
                await Provider.of<WalletProvider>(context, listen: false)
                    .fetchExpenseChart();
                await Provider.of<WalletProvider>(context, listen: false)
                    .fetchWallet();
                await Provider.of<SavingProvider>(context, listen: false)
                    .fetchSaving();
                if (result != null) {
                  showCongratsDialog(context: context, savingName: result);
                }
              },
            ));
      },
    );
  }
}
