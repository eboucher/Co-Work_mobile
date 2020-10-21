class User {
  String id;
  String username;
  String email;
  String firstName;
  String lastName;
  String token;

  User({this.id, this.username, this.email, this.firstName, this.lastName,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      username: json['user']['username'],
      firstName: json['user']['FirstName'],
      lastName: json['user']['LastName'],
      email: json['user']['email'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, token: $token}';
  }
}

