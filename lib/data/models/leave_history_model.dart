class LeaveHistoryModel {
  final String title;
  final String startDate;
  final String endDate;
  final int daysCount;
  final String status;
  final String type;

  LeaveHistoryModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.daysCount,
    required this.status,
    required this.type,
  });

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) {
    return LeaveHistoryModel(
      title: json['title'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      daysCount: json['daysCount'] ?? 0,
      status: json['status'] ?? '',
      type: json['type'] ?? '',
    );
  }

  // Helper method to parse startDate into DateTime for filtering
  DateTime get parsedStartDate => DateTime.parse(startDate);
}
