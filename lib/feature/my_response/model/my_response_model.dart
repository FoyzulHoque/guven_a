class Post {
  final String? id;
  final String? userId;
  final double? lat;
  final double? long;
  final String? address;
  final String? details;
  final DateTime? validityDate;
  final bool? urgent;
  final DateTime? createdAt;
  final String? status;

  Post({
    this.id,
    this.userId,
    this.lat,
    this.long,
    this.address,
    this.details,
    this.validityDate,
    this.urgent,
    this.createdAt,
    this.status,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      lat: (json['lat'] as num?)?.toDouble(), // Handle num to double conversion
      long: (json['long'] as num?)
          ?.toDouble(), // Handle num to double conversion
      address: json['address'] as String?,
      details: json['details'] as String?,
      validityDate: json['validityDate'] != null
          ? DateTime.tryParse(json['validityDate'] as String)
          : null,
      urgent: json['urgent'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      status: json['status'] as String?,
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
      'validityDate': validityDate?.toIso8601String(),
      'urgent': urgent,
      'createdAt': createdAt?.toIso8601String(),
      'status': status,
    };
  }
}

class ApiResponse {
  final bool? success;
  final String? message;
  final List<Post>? data;

  ApiResponse({this.success, this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}
