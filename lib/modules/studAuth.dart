class StudReg {
  late final String uid;
  late final String matricno;
  late final String name;
  late final String gender;
  late final String depart;
  late final String level;
  late final String phone;

  //late final String address;
  // late final String password;

  StudReg({
    required this.uid,
    required this.matricno,
    required this.name,
    required this.gender,
    required this.depart,
    required this.level,
    required this.phone,
    // required this.address,
    // required this.password,
  });
  factory StudReg.froJson(Map<String, dynamic> json) {
    return StudReg(
      uid: json['uid'],
      matricno: json['matric'],
      name: json['name'],
      gender: json['gender'],
      depart: json['depart'],
      level: json['level'],
      phone: json['phone'],
      //  address: json['address'],
      // password: json['password']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'matric': matricno,
      'name': name,
      'gender': gender,
      'depart': depart,
      'level': level,
      'phone': phone,
      //'address': address,
    };
  }
}
