class UserResponceModal {
  String id;
  String name;
  String email;
  String phoneNumber;
  String profileImg;

  UserResponceModal(
      {this.id = "",
      this.name = "",
      this.email = "",
      this.phoneNumber = "",
      this.profileImg = ""});

  factory UserResponceModal.fromJson(Map<String, dynamic> json) =>
      UserResponceModal(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        profileImg: json['profileImg'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'profileImg': profileImg,
      };
}
