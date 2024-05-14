import 'package:bytechef/constants/colors.dart';
import 'package:bytechef/data/user.dart';
import 'package:bytechef/view/home/home.dart';
import 'package:bytechef/view/add/add.dart';
import 'package:bytechef/view/bookmarks/bookmarks.dart';
import 'package:bytechef/view/notifications/notifications.dart';
import 'package:bytechef/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key, required this.user});

  @override
  State<NavBar> createState() => _NavBarState();
  final User user;
}

class _NavBarState extends State<NavBar> {
  var tabIndex = 0;
  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: tabIndex, children: [
        HomeScreen(user: widget.user),
        const Bookmarks(),
        Add(
          user: widget.user,
        ),
        Notifications(
          user: widget.user,
        ),
        Profile(
          user: widget.user,
        )
      ]),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            currentIndex: tabIndex,
            onTap: changeTabIndex,
            selectedItemColor: tPrimaryColor,
            unselectedItemColor: Colors.grey,
            items: [
              itemBar(Iconsax.home4, ""),
              itemBar(Iconsax.heart, ""),
              const BottomNavigationBarItem(
                  icon: Icon(
                    Iconsax.home,
                    color: Colors.transparent,
                  ),
                  label: ""),
              itemBar(Iconsax.notification, ""),
              itemBar(Iconsax.user, "")
            ],
          )),
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: tPrimaryColor,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Add(
                  user: widget.user,
                ))),
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

itemBar(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
