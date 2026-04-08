import 'dart:async';

class ApiService {
  // Simulate API call with delay
  Future<Map<String, dynamic>> getDashboardData() async {
    await Future.delayed(const Duration(seconds: 2));

    // Returning enriched mock JSON response
    return {
      "user": {
        "id": "EMP001",
        "name": "Darshan Dalwadi",
        "role": "Software Engineer",
        "imageUrl":
            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
      },
      "attendance": {"percentage": 94, "monthlyGrowth": 2},
      "leaves": {"usedLeaves": 12, "totalLeaves": 24},
      "requests": {"pendingRequests": 3},
      "leaveDetails": [
        {
          "title": "Sick Leave",
          "startDate": "2026-04-01",
          "endDate": "2026-04-03",
          "daysCount": 3,
          "status": "approved",
          "type": "medical",
        },
        {
          "title": "Casual Leave",
          "startDate": "2026-04-10",
          "endDate": "2026-04-12",
          "daysCount": 3,
          "status": "pending",
          "type": "casual",
        },
        {
          "title": "Emergency Leave",
          "startDate": "2026-01-05",
          "endDate": "2026-01-06",
          "daysCount": 2,
          "status": "approved",
          "type": "emergency",
        },
        {
          "title": "Vacation",
          "startDate": "2026-02-10",
          "endDate": "2026-02-15",
          "daysCount": 6,
          "status": "rejected",
          "type": "vacation",
        },
        {
          "title": "Personal Leave",
          "startDate": "2026-03-01",
          "endDate": "2026-03-02",
          "daysCount": 2,
          "status": "approved",
          "type": "casual",
        },
      ],
      "attendanceLogs": [
        {"time": "09:00 AM", "status": "on_time"},
        {"time": "09:15 AM", "status": "late"},
        {"time": "08:55 AM", "status": "on_time"},
        {"time": "09:05 AM", "status": "late"},
      ],
      "upcomingHolidays": [
        {"name": "Diwali", "date": "2026-11-01"},
        {"name": "Christmas", "date": "2026-12-25"},
        {"name": "New Year", "date": "2027-01-01"},
        {"name": "Republic Day", "date": "2027-01-26"},
      ],
    };
  }
}
