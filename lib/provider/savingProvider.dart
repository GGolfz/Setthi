import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Saving {
  final String id;
  final String title;
  final double savingGoal;
  final String startDay;
  final String endDay;
  Saving({
    @required this.id,
    @required this.title,
    @required this.savingGoal,
    this.startDay,
    this.endDay,
  });
}

class SavingProvider with ChangeNotifier {
  final List<Saving> _saving = [];
  int get savingCount {
    return _saving.length;
  }
    List<Saving> get saving {
    return _saving;
  }
  Future<void> addSaving(String title, String savingGoal,
      DateTime startDay, DateTime lastDay) async {
    final newBudget = Saving(
        id: savingCount.toString(),
        title: title,
        savingGoal:  double.tryParse(savingGoal),
        startDay: DateFormat.yMMMd().format(startDay),
        endDay: DateFormat.yMMMd().format(lastDay));

    _saving.add(newBudget);
    notifyListeners();
  }

  Future<void> removeSaving(String id) async {
    _saving.removeWhere((el) => el.id == id);
    notifyListeners();
  }

  Future<void> editingSaving(String id, String title, String savingGoal) async {
    //mockup edit wallet
    int index = _saving.indexWhere((el) => el.id == id);
    _saving[index] = new Saving(id: id, title: title, savingGoal: double.tryParse(savingGoal),startDay:_saving[index].startDay,endDay:_saving[index].endDay );
    notifyListeners();
  }
}
