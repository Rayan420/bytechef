// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:bytechef/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomSheetFilter extends StatefulWidget {
  final Function(List<String>) onFiltersApplied;

  const BottomSheetFilter(
      {Key? key, required this.onFiltersApplied, required this.selectedFilters})
      : super(key: key);

  final List<String> selectedFilters;

  @override
  _BottomSheetFilterState createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  String? selectedTimeFilter;
  String? selectedRatingFilter;
  String? selectedCategoryFilter;
  late List<String> selectedFilters;

  @override
  void initState() {
    super.initState();

    // Check if selectedFilters is not empty before accessing its elements
    if (widget.selectedFilters.isNotEmpty) {
      selectedFilters = List.from(widget.selectedFilters);
      selectedTimeFilter =
          selectedFilters.contains('All') ? null : selectedFilters[0];
      selectedRatingFilter =
          selectedFilters.contains('All') ? null : selectedFilters[1];
      selectedCategoryFilter =
          selectedFilters.contains('All') ? null : selectedFilters[2];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterRow(
            title: 'Time',
            options: ['All', 'Fastet', 'Medium', 'Slowest'],
            selectedOption: selectedTimeFilter,
            onChanged: (value) {
              setState(() {
                selectedTimeFilter = value;
              });
            },
          ),
          _buildFilterRow(
            title: 'Rating',
            options: ['5', '4', '3', '2', '1'],
            selectedOption: selectedRatingFilter,
            onChanged: (value) {
              setState(() {
                selectedRatingFilter = value;
              });
            },
            isRatingFilter: true, // Flag to enable star icon
          ),
          _buildFilterRow(
            title: 'Category',
            options: [
              "chicken",
              "curry",
              "spicy",
              "indian",
              "flavorful",
              "comfort food",
              "grilled",
              "pasta",
              "creamy",
              "vegetables",
              "quick",
              "easy",
              "beef",
              "stew",
              "family-friendly"
            ],
            selectedOption: selectedCategoryFilter,
            onChanged: (value) {
              setState(() {
                selectedCategoryFilter = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(tPrimaryColor),
                ),
                onPressed: () {
                  // Create a list of selected filters
                  List<String> selectedFilters = [
                    selectedTimeFilter ?? 'All',
                    selectedRatingFilter ?? '5',
                    selectedCategoryFilter ?? 'All',
                  ];
                  // Call the callback function with the selected filters
                  widget.onFiltersApplied(selectedFilters);
                  // Close the bottom sheet
                  Navigator.pop(context);
                },
                child: const Text('Apply Filters',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 16)
        ],
      ),
    );
  }

  Widget _buildFilterRow({
    required String title,
    required List<String> options,
    required String? selectedOption,
    required ValueChanged<String?> onChanged,
    bool isRatingFilter = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          children: options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: ElevatedButton(
                onPressed: () {
                  onChanged(option == selectedOption ? null : option);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                    (states) {
                      return const BorderSide(
                        color: tPrimaryColor, // Adjust border color as needed
                        width: 1,
                      );
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      return option == selectedOption
                          ? tPrimaryColor // Change the color based on selection
                          : null;
                    },
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      option,
                      style: TextStyle(
                        color: option == selectedOption
                            ? Colors.white
                            : tPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 2),
                    if (isRatingFilter && option != 'All') ...[
                      Icon(Iconsax.star5,
                          color: option == selectedOption
                              ? Colors.white
                              : tPrimaryColor,
                          size: 20),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
