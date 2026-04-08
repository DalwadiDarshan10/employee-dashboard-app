import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/name_routes.dart';
import '../models/dashboard_model.dart';
import '../repositories/dashboard_repository.dart';

class DashboardController extends GetxController {
  final DashboardRepository _repository;
  final storage = GetStorage();

  DashboardController(this._repository);

  // Observables
  var isLoading = true.obs;
  var isError = false.obs;
  var dashboardData = Rxn<DashboardModel>();
  var selectedIndex = 0.obs;
  
  // Expansion states
  var isLeaveExpanded = false.obs;
  var isAttendanceExpanded = false.obs;
  var isHolidayExpanded = false.obs;
  
  // Tab-specific loading states
  var isProfileLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardInfo();
  }

  // Fetch all dashboard data
  Future<void> fetchDashboardInfo() async {
    try {
      isLoading.value = true;
      isError.value = false;
      
      final data = await _repository.getDashboardData();
      dashboardData.value = data;
    } catch (e) {
      isError.value = true;
      Get.snackbar(
        "Error",
        "Failed to load dashboard data. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Handle pull-to-refresh
  Future<void> onRefresh() async {
    await fetchDashboardInfo();
  }

  // Dynamic Greeting based on current time
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 22) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  // TOGGLE METHODS
  void toggleLeave() => isLeaveExpanded.toggle();
  void toggleAttendance() => isAttendanceExpanded.toggle();
  void toggleHoliday() => isHolidayExpanded.toggle();

  // Handle tab change
  void changeTabIndex(int index) {
    if (selectedIndex.value == index) return;
    
    selectedIndex.value = index;
    
    if (index == 3) {
      _simulateTabLoading(isProfileLoading);
    }
  }

  void _simulateTabLoading(RxBool loadingState) {
    loadingState.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      loadingState.value = false;
    });
  }
  
  // Logout functionality
  void logout() async {
    await storage.remove('isLoggedIn');
    Get.offAllNamed(NameRoutes.login);
  }
}
