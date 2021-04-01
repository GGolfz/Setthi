import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/provider/walletProvider.dart';
import 'package:setthi/widgets/transaction/walletListItem.dart';

class WalletList extends StatelessWidget {
  final WalletItem selected;
  final Function onSelect;
  final List<WalletItem> wallets;
  WalletList({@required this.selected, this.onSelect, this.wallets});
  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      onItemFocus: (val) {
        onSelect(wallets[val]);
      },
      itemSize: 136,
      itemBuilder: (context, index) => WalletListItem(
          wallet: wallets[index], isSelect: wallets[index].id == selected.id),
      focusOnItemTap: true,
      itemCount: wallets.length,
    );
  }
}
