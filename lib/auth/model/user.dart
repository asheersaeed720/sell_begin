class UserModel {
  String email;
  String userName;
  String phoneNo;
  String password;
  String confirmPassword;

  UserModel({
    this.email = '',
    this.userName = '',
    this.phoneNo = '',
    this.password = '',
    this.confirmPassword = '',
  });

  @override
  String toString() {
    return 'UserModel(email: $email, userName: $userName, phoneNo: $phoneNo, password: $password, confirmPassword: $confirmPassword)';
  }
}
