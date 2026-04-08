import 'package:employee_dashboard_application/features/dashboard/models/dashboard_model.dart';
import '../core/network/api_service.dart';

class DashboardRepository {
  final ApiService _apiService;

  DashboardRepository(this._apiService);

  Future<DashboardModel> getDashboardData() async {
    try {
      final json = await _apiService.getDashboardData();
      return DashboardModel.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
