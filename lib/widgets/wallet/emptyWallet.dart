import 'package:flutter/material.dart';

import '../../config/constants.dart';

class EmptyWallet extends StatelessWidget {
  static final routeName = '/wallet';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/empty-wallet.png")],
        ),
        Text('Empty wallet'),
        kSizedBoxVerticalM,
      ],
    );
  }
}
