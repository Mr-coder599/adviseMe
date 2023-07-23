class Posting {
  late final String uid;
  late final String title;
  late final String level;
  late final String desc;
  late final String adviser;
  late final String timeDate;
  //constructor of each field
  Posting({
    required this.uid,
    required this.timeDate,
    required this.level,
    required this.title,
    required this.desc,
    required this.adviser,
  });
  factory Posting.froJson(Map<String, dynamic> json) {
    return Posting(
      timeDate: json['timeDate'].toDate,
      uid: json['uid'],
      level: json['level'],
      title: json['title'],
      desc: json['desc'],
      adviser: json['adviser'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'timeDate': timeDate,
      'uid': uid,
      'level': level,
      'title': title,
      'desc': desc,
      'adviser': adviser
    };
  }
}
