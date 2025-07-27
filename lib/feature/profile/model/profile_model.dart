import 'dart:convert';

// Top-level response model
class ProfileApiResponse {
  final bool success;
  final String message;
  final ProfileData data;

  ProfileApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProfileApiResponse.fromJson(Map<String, dynamic> json) {
    return ProfileApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

// Data part of the response
class ProfileData {
  final String email;

  ProfileData({required this.email});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(email: json['email'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
