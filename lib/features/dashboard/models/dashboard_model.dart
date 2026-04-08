class DashboardModel {
  final AttendanceModel attendance;
  final LeaveSummaryModel leaves;
  final RequestSummaryModel requests;
  final List<LeaveDetailModel> leaveDetails;
  final List<AttendanceLogModel> attendanceLogs;
  final List<HolidayModel> upcomingHolidays;

  DashboardModel({
    required this.attendance,
    required this.leaves,
    required this.requests,
    required this.leaveDetails,
    required this.attendanceLogs,
    required this.upcomingHolidays,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      attendance: AttendanceModel.fromJson(json['attendance']),
      leaves: LeaveSummaryModel.fromJson(json['leaves']),
      requests: RequestSummaryModel.fromJson(json['requests']),
      leaveDetails: (json['leaveDetails'] as List)
          .map((i) => LeaveDetailModel.fromJson(i))
          .toList(),
      attendanceLogs: (json['attendanceLogs'] as List)
          .map((i) => AttendanceLogModel.fromJson(i))
          .toList(),
      upcomingHolidays: (json['upcomingHolidays'] as List)
          .map((i) => HolidayModel.fromJson(i))
          .toList(),
    );
  }
}

class AttendanceModel {
  final int percentage;
  final int monthlyGrowth;

  AttendanceModel({required this.percentage, required this.monthlyGrowth});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      percentage: json['percentage'] ?? 0,
      monthlyGrowth: json['monthlyGrowth'] ?? 0,
    );
  }
}

class LeaveSummaryModel {
  final int usedLeaves;
  final int totalLeaves;

  LeaveSummaryModel({required this.usedLeaves, required this.totalLeaves});

  factory LeaveSummaryModel.fromJson(Map<String, dynamic> json) {
    return LeaveSummaryModel(
      usedLeaves: json['usedLeaves'] ?? 0,
      totalLeaves: json['totalLeaves'] ?? 0,
    );
  }
}

class RequestSummaryModel {
  final int pendingRequests;

  RequestSummaryModel({required this.pendingRequests});

  factory RequestSummaryModel.fromJson(Map<String, dynamic> json) {
    return RequestSummaryModel(
      pendingRequests: json['pendingRequests'] ?? 0,
    );
  }
}

class LeaveDetailModel {
  final String title;
  final String startDate;
  final String endDate;
  final String status;

  LeaveDetailModel({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory LeaveDetailModel.fromJson(Map<String, dynamic> json) {
    return LeaveDetailModel(
      title: json['title'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class AttendanceLogModel {
  final String time;
  final String status;

  AttendanceLogModel({required this.time, required this.status});

  factory AttendanceLogModel.fromJson(Map<String, dynamic> json) {
    return AttendanceLogModel(
      time: json['time'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class HolidayModel {
  final String name;
  final String date;

  HolidayModel({required this.name, required this.date});

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      name: json['name'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
