class SignupModel {
  String userID;
  String username;
  String email;
  String password;

  SignupModel({
    required this.userID,
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'UserID': userID,
      "username": username,
      "email": email,
      "password": password,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      userID: map['UserID'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
}
