import 'package:flutter/foundation.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_balance_card_model.dart';

class LoanBalanceService extends ChangeNotifier {
  LoanBalanceService._();

  static final LoanBalanceService instance = LoanBalanceService._();

  final List<LoanBalanceCardModel> _confirmedBalances =
      <LoanBalanceCardModel>[];
  int? _requestedTopTab;

  List<LoanBalanceCardModel> get confirmedBalances =>
      List<LoanBalanceCardModel>.unmodifiable(_confirmedBalances);

  int? consumeRequestedTopTab() {
    final int? targetTab = _requestedTopTab;
    _requestedTopTab = null;
    return targetTab;
  }

  void addConfirmedLoan(LoanBalanceCardModel loan) {
    _confirmedBalances.insert(0, loan);
    _requestedTopTab = 1;
    notifyListeners();
  }

  void removeConfirmedLoan(String orderID) {
    _confirmedBalances.removeWhere((loan) => loan.orderID == orderID);
    notifyListeners();
  }
}
