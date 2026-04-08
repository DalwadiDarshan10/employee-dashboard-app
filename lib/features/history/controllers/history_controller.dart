import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/leave_history_model.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../core/constants/app_strings.dart';

class HistoryController extends GetxController {
  final HistoryRepository _repository;

  HistoryController(this._repository);

  var isLoading = true.obs;
  var user = Rxn<UserModel>();
  var allLeaves = <LeaveHistoryModel>[].obs;
  var filteredLeaves = <LeaveHistoryModel>[].obs;
  
  var selectedStatus = AppStrings.historyFilterAll.obs;
  var selectedTimeFilter = AppStrings.historyFilterAll.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      final response = await _repository.getHistoryData();
      user.value = response.user;
      allLeaves.assignAll(response.leaves);
      applyFilters();
    } catch (e) {
      Get.snackbar(AppStrings.error, AppStrings.historyLoadError);
    } finally {
      isLoading.value = false;
    }
  }

  void filterByStatus(String status) {
    selectedStatus.value = status;
    applyFilters();
  }

  void filterByTime(String time) {
    selectedTimeFilter.value = time;
    applyFilters();
  }

  void applyFilters() {
    var results = allLeaves.toList();

    if (selectedStatus.value != AppStrings.historyFilterAll) {
      results = results.where((e) => e.status.toLowerCase() == selectedStatus.value.toLowerCase()).toList();
    }

    final now = DateTime.now();
    if (selectedTimeFilter.value == AppStrings.historyFilterWeek) {
      results = results.where((e) => e.parsedStartDate.isAfter(now.subtract(const Duration(days: 7)))).toList();
    } else if (selectedTimeFilter.value == AppStrings.historyFilterMonth) {
      results = results.where((e) => e.parsedStartDate.month == now.month && e.parsedStartDate.year == now.year).toList();
    } else if (selectedTimeFilter.value == AppStrings.historyFilterYear) {
      results = results.where((e) => e.parsedStartDate.year == now.year).toList();
    }

    filteredLeaves.assignAll(results);
  }

  int get totalLeaves => allLeaves.fold(0, (sum, item) => sum + item.daysCount);
  int get usedLeaves => allLeaves.where((e) => e.status.toLowerCase() == 'approved').fold(0, (sum, item) => sum + item.daysCount);
  int get currentBalance => totalLeaves - usedLeaves;

  Future<void> onRefresh() async {
    await fetchHistory();
  }
}
