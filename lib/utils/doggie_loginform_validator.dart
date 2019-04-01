class DoggieLoginFormValidator {

  static String validateUsername(String username) =>
      username.isEmpty ? 'Kindly ensure you enter your username' : null;

  static String validatePassword(String password) =>
      password.isEmpty ? 'Kindly ensure you enter your password' : null;
}