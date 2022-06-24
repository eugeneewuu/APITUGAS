class User {
  final String nama;
  final String id;
  final String telpon;

  const User({
    required this.nama,
    required this.id,
    required this.telpon,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nama: json['nama'],
      id: json['id'],
      telpon: json['telpon'],
    );
  }
}