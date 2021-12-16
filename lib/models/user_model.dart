class UserModel {
  late String name;
  late String? email;
  late String phone;
  late String uId;
  late String? image;
  late String? bio;
  late String? cover;
  late bool? isEmailVerified;

  UserModel(
      {required this.name,
      this.email,
      required this.phone,
      required this.uId,
      this.image,
      this.bio,
      this.cover,
      this.isEmailVerified});

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
    };
  }
}
