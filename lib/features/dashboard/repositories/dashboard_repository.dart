import '../../../core/network/api_service.dart';
import '../models/dashboard_model.dart';

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
