import 'package:flutter/material.dart';

class EmptyWallet extends StatelessWidget {
  static final routeName = '/wallet';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/empty-wallet.png")],
        ),
        Text('Empty wallet'),
      ],
    );
  }
}
