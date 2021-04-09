import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/categoryType.dart';
import 'package:setthi/model/httpException.dart';
import 'package:setthi/model/labelType.dart';
import 'package:setthi/model/transactionType.dart';
import 'package:setthi/provider/transactionProvider.dart';
import 'package:setthi/provider/categoryProvider.dart';
import 'package:setthi/provider/labelProvider.dart';
import 'package:setthi/provider/savingProvider.dart';
import 'package:setthi/provider/walletProvider.dart';
import 'package:setthi/screens/settingScreen.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDatePicker.dart';
import 'package:setthi/widgets/transaction/sourceList.dart';
import 'customDropDown.dart';
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
  SourceItem selectedSource = SourceItem.defaultSource;
  SourceType sourceType = SourceType.wallet;
  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  DateTime _dateTime = DateTime.now();
  Category _category = null;
  Saving _saving = null;
  bool _isLoading = false;
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
      if (savingProvider.saving.inProcess.isNotEmpty) {
        _saving = savingProvider.saving.inProcess[0];
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
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.fetchWallet();
    if (walletProvider.wallets.isNotEmpty) {
      selectedSource = SourceItem(
          id: walletProvider.wallets[0].id,
          title: walletProvider.wallets[0].title,
          amount: walletProvider.wallets[0].amount,
          sourceType: SourceType.wallet);
    }
  }

  CategoryType get categoryType {
    if (_current == TransactionType.Income) return CategoryType.Income;
    return CategoryType.Expense;
  }

  List<SourceItem> getSources(wallets, savings) {
    List<SourceItem> walletSources = [
      ...wallets.map((el) => SourceItem(
          id: el.id,
          title: el.title,
          amount: el.amount,
          sourceType: SourceType.wallet))
    ];
    List<SourceItem> savingSources = [
      ...savings.finish.map((el) => SourceItem(
          id: el.id,
          title: el.title,
          amount: el.currentAmount,
          sourceType: SourceType.saving))
    ];
    List<SourceItem> sources = [...walletSources, ...savingSources];
    if (_current == TransactionType.Expense ||
        _current == TransactionType.ExpenseFromSaving) return sources;
    return walletSources;
  }

  String getSourceText() {
    return _current == TransactionType.Income ? 'Destination' : 'Source';
  }

  LabelType get labelType {
    return {
      TransactionType.Expense: LabelType.Expense,
      TransactionType.Saving: LabelType.Expense,
      TransactionType.ExpenseFromSaving: LabelType.Expense,
      TransactionType.Income: LabelType.Income,
    }[_current];
  }

  Future<void> submitForm() async {
    print('from form saving id is ${_saving.id}');
    final tsProvider = Provider.of<TransactionProvider>(context, listen: false);
    setState(() => _isLoading = true);
    try {
      await tsProvider.createTransaction(
          title: _title.text,
          amount: double.tryParse(_amount.text),
          category: _category,
          transactionType: _current,
          selectedSource: selectedSource,
          dateTime: _dateTime,
          saving: _saving);
      setState(() => _isLoading = false);
      Navigator.of(context).pop();
    } on HttpException catch (error) {
      setState(() => _isLoading = false);
      print(error.message);
    }
  }

  Widget _renderForm(context) {
    return Consumer<WalletProvider>(
      builder: (ctx, wallet, _) => Consumer<CategoryProvider>(
        builder: (ctx, category, _) => Consumer<SavingProvider>(
          builder: (ctx, saving, _) => Column(
            children: [
              kSizedBoxVerticalXS,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    getSourceText(),
                    style: kHeadline4Black.copyWith(
                        color: kNeutral400, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              kSizedBoxVerticalXXS,
              Container(
                  width: double.infinity,
                  height: 90,
                  child: SourceList(
                    selected: selectedSource,
                    sources: getSources(wallet.wallets, saving.saving),
                    onSelect: (id) {
                      setState(() {
                        selectedSource = id;
                      });
                    },
                  )),
              kSizedBoxVerticalXXS,
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getSources(wallet.wallets, saving.saving).map((s) {
                    return Container(
                      width: kSizeXS,
                      height: kSizeXS,
                      margin: EdgeInsets.symmetric(horizontal: kSizeXXXS),
                      decoration: BoxDecoration(
                          borderRadius: kBorderRadiusXXS,
                          color: s.id == selectedSource.id &&
                                  s.sourceType == selectedSource.sourceType
                              ? kGold300
                              : kNeutral200),
                    );
                  }).toList()),
              kSizedBoxVerticalXS,
              CustomTextField(title: 'Title', textEditingController: _title),
              kSizedBoxVerticalXS,
              Consumer<LabelProvider>(
                builder: (ctx, label, _) => Container(
                  height: 20,
                  width: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: label
                        .getLabelByType(labelType)
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
              ),
              kSizedBoxVerticalS,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: kBody1Black.copyWith(
                        color: kNeutral450, fontWeight: FontWeight.w600),
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
                items: category.getCategoriesByType(categoryType),
                onChanged: (val) {
                  print('val is $val');
                  setState(() => _category = val);
                },
              ),
              kSizedBoxVerticalXS,
              if (_current == TransactionType.Saving)
                CustomDropDown(
                  title: 'Saving',
                  currentValue: _saving,
                  items: saving.saving.inProcess,
                  onChanged: (val) {
                    print('val is $val');
                    setState(() => _saving = val);
                  },
                ),
              kSizedBoxVerticalXS,
              CustomDatePicker(
                  title: 'Date',
                  getDateTime: (val) {
                    _dateTime = val;
                  },
                  dateTime: _dateTime),
              kSizedBoxVerticalXS,
              ActionButton(
                text: "Save",
                color: kGold300,
                onPressed: () => submitForm(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeType(TransactionType value) {
    final ctProvider = Provider.of<CategoryProvider>(context, listen: false);
    setState(() {
      _current = value;
      _category = ctProvider.getCategoriesByType(categoryType)[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: 400,
      child: Column(
        children: [
          SelectTypeBar(
              current: _current,
              onChange: (value) {
                setState(() => changeType(value));
              }),
          kSizedBoxVerticalXS,
          Container(
            height: 504,
            child: SingleChildScrollView(
              child: _renderForm(context),
            ),
          ),
        ],
      ),
    );
  }
}
