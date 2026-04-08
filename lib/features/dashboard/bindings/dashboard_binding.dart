import 'package:get/get.dart';
import '../../../core/network/api_service.dart';
import '../repositories/dashboard_repository.dart';
import '../controllers/dashboard_controller.dart';
import '../../../data/repositories/history_repository.dart';
import '../../history/controllers/history_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    
    Get.lazyPut(() => DashboardRepository(Get.find<ApiService>()));
    Get.lazyPut(() => HistoryRepository(Get.find<ApiService>()));
    
    Get.lazyPut(() => DashboardController(Get.find<DashboardRepository>()));
    Get.lazyPut(() => HistoryController(Get.find<HistoryRepository>()));
  }
}
