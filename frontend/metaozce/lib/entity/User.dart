// Kullanıcı sınıfı, JSON dönüşümü için toJson() metodu içermelidir
class User {
  final String fullname;
  final String username;
  final String password;

  User({
    required this.fullname,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'username': username,
        'password': password,
      };
}
