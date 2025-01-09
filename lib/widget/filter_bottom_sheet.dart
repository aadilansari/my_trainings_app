import 'package:flutter/material.dart';

import '../core/constants.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> selectedLocations;
  final List<String> selectedTrainings;
  final List<String> selectedTrainers;
  final List<String> availableLocations;
  final List<String> availableTrainings;
  final List<String> availableTrainers;
  final void Function(List<String>, List<String>, List<String>) onApplyFilters;

  const FilterBottomSheet({
    super.key,
    required this.selectedLocations,
    required this.selectedTrainings,
    required this.selectedTrainers,
    required this.availableLocations,
    required this.availableTrainings,
    required this.availableTrainers,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late List<String> selectedLocations;
  late List<String> selectedTrainings;
  late List<String> selectedTrainers;
  String selectedCategory = "Location";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedLocations = List.from(widget.selectedLocations);
    selectedTrainings = List.from(widget.selectedTrainings);
    selectedTrainers = List.from(widget.selectedTrainers);
  }

  @override
  Widget build(BuildContext context) {
    final categories = ["Sort by", "Location", "Training Name", "Trainer"];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sort and Filters",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 160,
                  color: Colors.grey[200],
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;

                      return Stack(
                        children: [
                          Container(
                            color: isSelected ? Colors.white : null,
                            child: ListTile(
                              title: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.black54,
                                  fontWeight: isSelected
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                ),
                              ),
                              onTap: () =>
                                  setState(() => selectedCategory = category),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 4,
                                color: AppColors.mainColor,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (selectedCategory != "Sort by")
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _getCurrentOptions().length,
                          itemBuilder: (context, index) {
                            final option = _getCurrentOptions()[index];
                            final isSelected = _isOptionSelected(option);

                            return ListTile(
                              title: Text(option),
                              leading: Checkbox(
                                value: isSelected,
                                onChanged: (value) => _toggleOption(option),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                widget.onApplyFilters(
                  selectedLocations,
                  selectedTrainings,
                  selectedTrainers,
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
              ),
              child: const Text('Apply filter'),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getCurrentOptions() {
    switch (selectedCategory) {
      case "Location":
        return widget.availableLocations;
      case "Training Name":
        return widget.availableTrainings;
      case "Trainer":
        return widget.availableTrainers;
      default:
        return [];
    }
  }

  bool _isOptionSelected(String option) {
    switch (selectedCategory) {
      case "Location":
        return selectedLocations.contains(option);
      case "Training Name":
        return selectedTrainings.contains(option);
      case "Trainer":
        return selectedTrainers.contains(option);
      default:
        return false;
    }
  }

  void _toggleOption(String option) {
    setState(() {
      switch (selectedCategory) {
        case "Location":
          if (selectedLocations.contains(option)) {
            selectedLocations.remove(option);
          } else {
            selectedLocations.add(option);
          }
          break;
        case "Training Name":
          if (selectedTrainings.contains(option)) {
            selectedTrainings.remove(option);
          } else {
            selectedTrainings.add(option);
          }
          break;
        case "Trainer":
          if (selectedTrainers.contains(option)) {
            selectedTrainers.remove(option);
          } else {
            selectedTrainers.add(option);
          }
          break;
      }
    });
  }
}

void showFilterBottomSheet(
  BuildContext context, {
  required List<String> selectedLocations,
  required List<String> selectedTrainings,
  required List<String> selectedTrainers,
  required List<String> availableLocations,
  required List<String> availableTrainings,
  required List<String> availableTrainers,
  required void Function(List<String>, List<String>, List<String>)
      onApplyFilters,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => FilterBottomSheet(
      selectedLocations: selectedLocations,
      selectedTrainings: selectedTrainings,
      selectedTrainers: selectedTrainers,
      availableLocations: availableLocations,
      availableTrainings: availableTrainings,
      availableTrainers: availableTrainers,
      onApplyFilters: onApplyFilters,
    ),
  );
}
