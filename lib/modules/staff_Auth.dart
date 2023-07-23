class StaffReg {
  late final String uid;
  late final String staffid;
  late final String fullname;
  late final String gender;
  late final String level;
  late final String email;
  late final String phone;
// constructor of class
  StaffReg({
    required this.uid,
    required this.fullname,
    required this.staffid,
    required this.gender,
    required this.level,
    required this.email,
    required this.phone,
  });

  factory StaffReg.froJson(Map<String, dynamic> json) {
    return StaffReg(
      uid: json['uid'],
      fullname: json['fullname'],
      staffid: json['staffid'],
      gender: json['gender'],
      level: json['advisor'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'staffid': staffid,
      'gender': gender,
      'advisor': level,
      'email': email,
      'phone': phone,
    };
  }
}

// 'uid': fireAuth.user!.uid,
// 'staffid': _staffidController.text,
// 'fullname': _fullnameController.text,
// 'gender': _genderController.text,
// 'advisor': _advisorController.text,
