import 'dart:convert';

// Model for an individual Request item when its status is ACTIVE.
class ActiveRequest {
  final String id;
  final String userId;
  final double lat;
  final double long;
  final String address;
  final String details;
  final DateTime validityDate;
  final bool urgent;
  final DateTime createdAt;
  final String status;

  ActiveRequest({
    required this.id,
    required this.userId,
    required this.lat,
    required this.long,
    required this.address,
    required this.details,
    required this.validityDate,
    required this.urgent,
    required this.createdAt,
    required this.status,
  });

  factory ActiveRequest.fromJson(Map<String, dynamic> json) {
    return ActiveRequest(
      id: json['id'] as String,
      userId: json['userId'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      address: json['address'] as String,
      details: json['details'] as String,
      validityDate: DateTime.parse(json['validityDate'] as String),
      urgent: json['urgent'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'lat': lat,
      'long': long,
      'address': address,
      'details': details,
      'validityDate': validityDate.toIso8601String(),
      'urgent': urgent,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
    };
  }
}

// Overall API Response structure for a list of Active Requests.
class ActiveRequestApiResponse {
  final bool success;
  final String message;
  final List<ActiveRequest> data;

  ActiveRequestApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ActiveRequestApiResponse.fromJson(Map<String, dynamic> json) {
    // This line safely casts 'data' to a nullable List<dynamic>
    var dataList = json['data'] as List<dynamic>?;

    return ActiveRequestApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      // This part checks if dataList is null.
      // If it is, it provides an empty list ([]), preventing errors.
      // If it's an empty list already, map.toList() will correctly return an empty list.
      data: dataList != null
          ? dataList
                .map((e) => ActiveRequest.fromJson(e as Map<String, dynamic>))
                .toList()
          : [], // <--- This handles the empty/null case
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}
