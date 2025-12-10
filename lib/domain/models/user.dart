class User {
  final String id;
  final String fullName;
  final String email;
  final String? adress;
  final String phoneNumber;
  final String churchName;
  final String countryCode;
  final String role;
  final bool active;
  final bool deleted;
  final bool emailVerified;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.adress,
    required this.phoneNumber,
    required this.churchName,
    required this.countryCode,
    required this.role,
    required this.active,
    required this.deleted,
    required this.emailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      adress: json['adress'],
      phoneNumber: json['phoneNumber'],
      churchName: json['churchName'],
      countryCode: json['countryCode'],
      role: json['role'],
      active: json['active'],
      deleted: json['deleted'],
      emailVerified: json['emailVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'churchName': churchName,
      'countryCode': countryCode,
      'role': role,
      'active': active,
      'deleted': deleted,
      'emailVerified': emailVerified,
    };
  }
}
