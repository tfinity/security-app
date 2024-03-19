class UserModel {
  String? name;
  String? phone;
  String? ChildEmail;
  String? ParentEmail;
  String? Identity;

  UserModel(
      {this.name,
      this.ChildEmail,
      this.ParentEmail,
      this.phone,
      this.Identity});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'ChildEmail': ChildEmail,
        'ParentEmail': ParentEmail,
        'Identity': Identity
      };
}
