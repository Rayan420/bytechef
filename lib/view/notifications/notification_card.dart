import 'package:bytechef/constants/colors.dart';
import 'package:flutter/material.dart';

Widget NotificationCard({
  required String title,
  required String body,
  required String time,
  required bool isRead,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isRead ? Colors.white : Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              // ADD A DOCUMENT ICON WITH NOTIFICATION DOT
              Icon(
                Icons.document_scanner_outlined,
                color: isRead ? Colors.grey : tAccentColor,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
