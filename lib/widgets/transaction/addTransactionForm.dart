import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/categoryType.dart';
import 'package:setthi/model/httpException.dart';
import 'package:setthi/model/transactionType.dart';
import 'package:setthi/provider/categoryProvider.dart';
import 'package:setthi/provider/labelProvider.dart';
import 'package:setthi/provider/savingProvider.dart';
import 'package:setthi/provider/walletProvider.dart';
import 'package:setthi/screens/settingScreen.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDatePicker.dart';
import 'package:setthi/widgets/transaction/sourceList.dart';
import './categoryDropDown.dart';
import 'package:setthi/widgets/form/customTextField.dart';
import 'package:setthi/widgets/layout/errorDialog.dart';
import 'package:setthi/widgets/transaction/selectTypeBar.dart';
import 'package:setthi/widgets/transaction/walletList.dart';

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  TransactionType _current = TransactionType.Income;
  CategoryType _test = CategoryType.Income;
  WalletItem selectedWallet = WalletItem.defaultWallet;
  SourceItem selectedSource = SourceItem.defaultSource;
  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  Category _category = null;
  @override
  void initState() {
    super.initState();
    _fetchFirstWallet();
    _fetchData();
  }

  void _fetchData() async {
    try {
      final ctProvider = Provider.of<CategoryProvider>(context, listen: false);
      final savingProvider =
          Provider.of<SavingProvider>(context, listen: false);
      await ctProvider.fetchCategories();
      await savingProvider.fetchSaving();
      if (ctProvider.getCategoriesByType(categoryType).isNotEmpty) {
        _category = ctProvider.getCategoriesByType(categoryType)[0];
      }
      await Provider.of<LabelProvider>(context, listen: false).fetchLabels();
    } on HttpException catch (error) {
      showErrorDialog(
          context: context,
          text: error.message,
          isNetwork: error.isInternetProblem);
    }
  }

  void _fetchFirstWallet() async {
    await Provider.of<WalletProvider>(context, listen: false).fetchWallet();
    if (!Provider.of<WalletProvider>(context, listen: false).isEmpty()) {
      selectedWallet =
          Provider.of<WalletProvider>(context, listen: false).wallets[0];
    }
  }

  CategoryType get categoryType {
    if (_current == TransactionType.Income) return CategoryType.Income;
    return CategoryType.Expense;
  }

  List<SourceItem> getSources(wallets, savings) {
    List<SourceItem> sources = [
      ...(wallets.map(
        (el) => SourceItem(
            id: el.id,
            title: el.title,
            amount: el.amount,
            sourceType: SourceType.wallet),
      )),
      ...(savings.finish.map(
        (el) => SourceItem(
            id: el.id,
            title: el.title,
            amount: el.amount,
            sourceType: SourceType.saving),
      ))
    ];

    return sources;
  }

  Widget _renderForm(context) {
    return Consumer<WalletProvider>(
      builder: (ctx, wallet, _) => Consumer<CategoryProvider>(
          builder: (ctx, category, _) => Consumer<SavingProvider>(
                builder: (ctx, saving, _) => Container(
                  height: 504,
                  child: wallet.isEmpty() ||
                          category.getCategoriesByType(categoryType).isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('You have to add category'),
                            kSizedBoxVerticalXS,
                            ActionButton(
                              text: 'Add Category',
                              onPressed: () => Navigator.of(context)
                                  .pushReplacementNamed(
                                      SettingScreen.routeName),
                              color: kGold300,
                            )
                          ],
                        )
                      : Wrap(
                          children: [
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
                                      child: SourceList(
                                        selected: selectedSource,
                                        sources: getSources(
                                            wallet.wallets, saving.saving),
                                        onSelect: (id) {
                                          setState(() {
                                            selectedWallet = id;
                                          });
                                        },
                                      )),
                                  kSizedBoxVerticalXXS,
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: wallet.wallets.map((w) {
                                        return Container(
                                          width: kSizeXS,
                                          height: kSizeXS,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: kSizeXXXS),
                                          decoration: BoxDecoration(
                                              borderRadius: kBorderRadiusXXS,
                                              color: w.id == selectedWallet.id
                                                  ? kGold300
                                                  : kNeutral200),
                                        );
                                      }).toList()),
                                  kSizedBoxVerticalXS,
                                  CustomTextField(
                                      title: 'Title',
                                      textEditingController: _title),
                                  kSizedBoxVerticalXS,
                                  Consumer<LabelProvider>(
                                    builder: (ctx, label, _) => Row(
                                      children: label.labels
                                          .map(
                                            (e) => GestureDetector(
                                              child: Container(
                                                child: Text(e.name),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1, horizontal: 2),
                                              ),
                                              onTap: () {
                                                _title.text = e.name;
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                  CategoryDropDown(
                                    title: 'Category',
                                    currentValue: _category == null
                                        ? _category
                                        : category.getCategoriesByType(
                                            categoryType)[0],
                                    items: category
                                        .getCategoriesByType(categoryType),
                                    onChanged: (val) {
                                      setState(() => _category = val);
                                    },
                                  ),
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
                              ),
                            )
                          ],
                        ),
                ),
              )),
    );
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
                  setState(() => _current = value);
                }),
            _renderForm(context),
          ],
        ),
      ),
    );
  }
}
