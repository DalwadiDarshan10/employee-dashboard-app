import '../../core/network/api_service.dart';
import '../models/user_model.dart';
import '../models/leave_history_model.dart';

class HistoryResponse {
  final UserModel user;
  final List<LeaveHistoryModel> leaves;

  HistoryResponse({required this.user, required this.leaves});
}

class HistoryRepository {
  final ApiService _apiService;

  HistoryRepository(this._apiService);

  Future<HistoryResponse> getHistoryData() async {
    try {
      final json = await _apiService.getDashboardData(); // Reusing the main endpoint for this demo
      
      final user = UserModel.fromJson(json['user']);
      final leaves = (json['leaveDetails'] as List)
          .map((i) => LeaveHistoryModel.fromJson(i))
          .toList();

      return HistoryResponse(user: user, leaves: leaves);
    } catch (e) {
      rethrow;
    }
  }
}
