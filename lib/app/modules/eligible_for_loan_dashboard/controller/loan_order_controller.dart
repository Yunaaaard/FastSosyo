import 'package:get/get.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/models/loan_order_card_model.dart';
import 'package:fast_sosyo/app/modules/eligible_for_loan_dashboard/services/loan_balance_service.dart';

class LoanOrderController extends GetxController {
  LoanOrderController();

  final RxInt _selectedTopTab = 0.obs;
  final LoanBalanceService balanceService = LoanBalanceService.instance;

  static const List<LoanOrderCardModel> _sampleOrders = <LoanOrderCardModel>[
    LoanOrderCardModel(
      brandName: 'Nestle',
      brandLogo: 'assets/images/nestle-sample-logo.png',
      status: 'Pending',
      orderedAmount: '1,574.08',
      productCount: 13,
      dateOrdered: 'March 25, 2026',
      orderId: 'AL-001',
    ),
    LoanOrderCardModel(
      brandName: 'Monde Nissin',
      brandLogo: 'assets/images/monde-sample-logo.png',
      status: 'Preparing',
      orderedAmount: '2,980.50',
      productCount: 24,
      dateOrdered: 'March 28, 2026',
      orderId: 'AL-002',
    ),
    LoanOrderCardModel(
      brandName: 'CDO',
      brandLogo: 'assets/images/cdo-logo.png',
      status: 'In Transit',
      orderedAmount: '4,120.00',
      productCount: 8,
      dateOrdered: 'April 02, 2026',
      orderId: 'AL-003',
    ),
    LoanOrderCardModel(
      brandName: 'Shell',
      brandLogo: 'assets/images/shell-logo.png',
      status: 'Delivered',
      orderedAmount: '6,210.75',
      productCount: 19,
      dateOrdered: 'April 05, 2026',
      orderId: 'AL-005',
    ),
    LoanOrderCardModel(
      brandName: 'Nutri Asia',
      brandLogo: 'assets/images/nutriasia-logo.png',
      status: 'Cancelled',
      orderedAmount: '980.00',
      productCount: 5,
      dateOrdered: 'April 07, 2026',
      orderId: 'AL-006',
    ),
  ];

  int get selectedTopTab => _selectedTopTab.value;

  bool get isOrdersTabSelected => _selectedTopTab.value == 0;

  List<LoanOrderCardModel> get sampleOrders => _sampleOrders;

  @override
  void onInit() {
    super.onInit();
    balanceService.addListener(_onBalanceChanged);
  }

  void selectTopTab(int index) {
    if (_selectedTopTab.value == index) {
      return;
    }

    _selectedTopTab.value = index;
    update();
  }

  void _onBalanceChanged() {
    final int? requestedTab = balanceService.consumeRequestedTopTab();
    if (requestedTab != null) {
      _selectedTopTab.value = requestedTab;
    }
    update();
  }

  @override
  void onClose() {
    balanceService.removeListener(_onBalanceChanged);
    super.onClose();
  }
}
