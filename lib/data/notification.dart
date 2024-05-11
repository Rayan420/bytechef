import 'package:bytechef/data/recipe.dart';

class UserNotification {
  final String title;
  final String body;
  final String time;
  bool isRead;
  final Recipe recipe;

  UserNotification({
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.recipe,
  });

  void markAsRead() {
    isRead = true;
  }
}
