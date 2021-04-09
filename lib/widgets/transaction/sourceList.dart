import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:setthi/widgets/transaction/sourceListItem.dart';

enum SourceType { wallet, saving }

class SourceItem {
  final int id;
  final String title;
  final double amount;
  final SourceType sourceType;
  SourceItem(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.sourceType});
  static SourceItem get defaultSource {
    return SourceItem(
        id: 0, title: '', amount: 0, sourceType: SourceType.wallet);
  }
}

class SourceList extends StatelessWidget {
  final SourceItem selected;
  final Function onSelect;
  final List<SourceItem> sources;
  SourceList({@required this.selected, this.onSelect, this.sources});
  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      onItemFocus: (val) {
        onSelect(sources[val]);
      },
      itemSize: 176,
      itemBuilder: (context, index) => SourceListItem(
          source: sources[index], isSelect: sources[index].id == selected.id),
      focusOnItemTap: true,
      itemCount: sources.length,
    );
  }
}
