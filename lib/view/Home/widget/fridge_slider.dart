// ignore_for_file: library_private_types_in_public_api

import 'package:bytechef/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FridgeItems extends StatefulWidget {
  final void Function(String selectedItem)? onItemSelected;

  const FridgeItems({super.key, this.onItemSelected});

  @override
  _FridgeItemsState createState() => _FridgeItemsState();
}

class _FridgeItemsState extends State<FridgeItems> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var item in [
                  'chicken',
                  'beef',
                  'shrimp',
                  'eggplant',
                  'noodles',
                  'cheese'
                ])
                  FridgeItemButton(
                    text: item,
                    item: item,
                    isSelected: selectedItem == item,
                    onPressed: () {
                      _toggleSelectedItem(item);
                    },
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var item in [
                  'fish',
                  'tomato',
                  'cucumber',
                  'egg',
                  'milk',
                  'octopus',
                  'bread',
                  'rice'
                ])
                  FridgeItemButton(
                    text: item,
                    item: item,
                    isSelected: selectedItem == item,
                    onPressed: () {
                      _toggleSelectedItem(item);
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _toggleSelectedItem(String item) {
    setState(() {
      if (selectedItem == item) {
        selectedItem = selectedItem; // Deselect if already selected
      } else {
        selectedItem = item; // Select the new item
        if (kDebugMode) {
          print('Selected item: $selectedItem');
        }
      }
    });

    // Call the callback function if provided
    if (widget.onItemSelected != null) {
      widget.onItemSelected!(selectedItem!);
    }
  }
}

class FridgeItemButton extends StatelessWidget {
  final String text;
  final String item;
  final bool isSelected;
  final VoidCallback onPressed;

  const FridgeItemButton({super.key, 
    required this.text,
    required this.item,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: isSelected
              ? MaterialStateProperty.all<Color>(tPrimaryColor)
              : null,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('assets/images/$item.png'),
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 5),
            Text(
              text[0].toUpperCase() + text.substring(1),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
