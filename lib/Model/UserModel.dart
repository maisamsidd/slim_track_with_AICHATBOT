class UserModel {
  final String image;
  final String name;
  final String about;
  final String? createdAt; // Change to String?
  final bool isOnline;
  final String? lastActive; // Change to String?
  final String id;
  final String email;
  final String? pushToken;

  UserModel({
    required this.image,
    required this.name,
    required this.about,
    required this.createdAt,
    required this.isOnline,
    required this.lastActive,
    required this.id,
    required this.email,
    this.pushToken,
  });

  // Factory method to create an instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      image: json['image'] as String,
      name: json['name'] as String,
      about: json['about'] as String,
      createdAt: json['created_at'] as String?, // Handle nullable string
      isOnline: json['is_online'] as bool,
      lastActive: json['last_active'] as String?, // Handle nullable string
      id: json['id'] as String,
      email: json['email'] as String,
      pushToken: json['push_token'] as String?, // Nullable string
    );
  }

  // Method to convert an instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'about': about,
      'created_at': createdAt, // Already a string
      'is_online': isOnline,
      'last_active': lastActive, // Already a string
      'id': id,
      'email': email,
      'push_token': pushToken, // Nullable string
    };
  }
}
