import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/notifications/notification_card.dart';
import 'package:bytechef/view/notifications/tab_item.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: tWhiteColor,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: const BoxDecoration(
                    color: tPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: tPrimaryColor,
                  tabs: [
                    TabItem(title: 'All', count: user.notifications.length),
                    TabItem(
                        title: 'Read',
                        count: user.getReadNotifications().length),
                    TabItem(
                        title: 'Unread',
                        count: user.getUnreadNotifications().length),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // build notification card from newest to oldest
            ListView.builder(
              itemCount: user.notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: user.notifications[index].title,
                  body: user.notifications[index].body,
                  time: user.notifications[index].time,
                  isRead: user.notifications[index].isRead,
                  onTap: () => user.notifications[index].markAsRead(),
                );
              },
            ),
            // build read notification card from newest to oldest
            ListView.builder(
              itemCount: user.getReadNotifications().length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: user.getReadNotifications()[index].title,
                  body: user.getReadNotifications()[index].body,
                  time: user.getReadNotifications()[index].time,
                  isRead: user.getReadNotifications()[index].isRead,
                  onTap: () => user.getReadNotifications()[index].markAsRead(),
                );
              },
            ),
            // build unread notification card from newest to oldest
            ListView.builder(
              itemCount: user.getUnreadNotifications().length,
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: user.getUnreadNotifications()[index].title,
                  body: user.getUnreadNotifications()[index].body,
                  time: user.getUnreadNotifications()[index].time,
                  isRead: user.getUnreadNotifications()[index].isRead,
                  onTap: () =>
                      user.getUnreadNotifications()[index].markAsRead(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
