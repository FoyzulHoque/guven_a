import 'dart:convert';

// Overall API Response structure
class HomePostApiResponse {
  final bool success;
  final String message;
  final List<HomePostData> data;

  HomePostApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HomePostApiResponse.fromJson(Map<String, dynamic> json) {
    // --- FIX IS HERE ---
    // Check if json['data'] is null; if so, default to an empty list.
    var dataList = json['data'] as List<dynamic>?; // Make it nullable first

    return HomePostApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: dataList != null
          ? dataList
                .map((e) => HomePostData.fromJson(e as Map<String, dynamic>))
                .toList()
          : [], // Provide an empty list if data is null
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

// ... (rest of your HomePostData, User, and Post classes remain unchanged)

// Individual Home Post Data structure
class HomePostData {
  final String id;
  final String postId;
  final String userId;
  final String photoUrl;
  final DateTime createdAt;
  final User user;
  final Post post;

  HomePostData({
    required this.id,
    required this.postId,
    required this.userId,
    required this.photoUrl,
    required this.createdAt,
    required this.user,
    required this.post,
  });

  factory HomePostData.fromJson(Map<String, dynamic> json) {
    return HomePostData(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      post: Post.fromJson(json['post'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
      'user': user.toJson(),
      'post': post.toJson(),
    };
  }
}

// User sub-object within HomePostData
class User {
  final String id;
  final String email;

  User({required this.id, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'] as String, email: json['email'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}

// Post sub-object within HomePostData
class Post {
  final String id;
  final String userId;
  final String address;
  final String details;
  final bool urgent;
  final DateTime validityDate;
  final double lat;
  final double long;
  final String status;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.address,
    required this.details,
    required this.urgent,
    required this.validityDate,
    required this.lat,
    required this.long,
    required this.status,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      userId: json['userId'] as String,
      address: json['address'] as String,
      details: json['details'] as String,
      urgent: json['urgent'] as bool,
      validityDate: DateTime.parse(json['validityDate'] as String),
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'address': address,
      'details': details,
      'urgent': urgent,
      'validityDate': validityDate.toIso8601String(),
      'lat': lat,
      'long': long,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
