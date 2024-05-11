import 'package:bytechef/data/user.dart';

class UserRepository {
  static List<User> users = [];

  // add user to the repository
  static void addUser(User user) {
    users.add(user);
  }

  static void deleteUser(User user) {
    users.remove(user);
  }
}
