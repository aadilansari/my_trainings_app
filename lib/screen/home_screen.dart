import 'package:flutter/material.dart';
import 'package:my_trainings_app/core/constants.dart';
import 'package:my_trainings_app/widget/filter_bottom_sheet.dart';
import 'package:my_trainings_app/model/training.dart';
import 'package:my_trainings_app/widget/training_card.dart';
import 'package:my_trainings_app/widget/training_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  List<String> selectedLocations = [];
  List<String> selectedTrainings = [];
  List<String> selectedTrainers = [];
  late List<Training> trainings;

  @override
  void initState() {
    super.initState();
    trainings = Training.getSampleData();
  }

  List<Training> get filteredTrainings {
    return trainings.where((training) {
      bool matchesLocation = selectedLocations.isEmpty ||
          selectedLocations.contains(training.location);
      bool matchesTraining = selectedTrainings.isEmpty ||
          selectedTrainings.contains(training.title);
      bool matchesTrainer = selectedTrainers.isEmpty ||
          selectedTrainers.contains(training.trainerName);
      return matchesLocation && matchesTraining && matchesTrainer;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trainings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCarousel(),
          const SizedBox(height: 16),
          _buildFilterSection(),
          const SizedBox(height: 10),
          _buildTrainingsList(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 150,
              color: AppColors.mainColor,
            ),
            Container(
              height: 100,
              color: Colors.white,
            ),
          ],
        ),
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Text(
                    'Highlights',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: trainings.length,
                    itemBuilder: (context, index) {
                      final training = trainings[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: GestureDetector(
                              onTap: () => _showTrainingDetails(training),
                              child: Stack(
                                children: [
                                  Image.network(
                                    training.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          training.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${training.location} - ${training.date}',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${training.price + 150}',
                                                  style: const TextStyle(
                                                    color: AppColors.mainColor,
                                                    fontSize: 13,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '\$${training.price}',
                                                  style: const TextStyle(
                                                    color: AppColors.mainColor,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  _showTrainingDetails(
                                                      training),
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: const Size(0, 0),
                                              ),
                                              child: const Text(
                                                'View Details →',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              left: 2,
              top: 110,
              child: Container(
                height: 80,
                width: 40,
                color: const Color.fromARGB(255, 99, 99, 99).withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: _currentPage > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
              ),
            ),
            Positioned(
              right: 2,
              top: 110,
              child: Container(
                height: 80,
                width: 40,
                color: const Color.fromARGB(255, 99, 99, 99).withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: _currentPage < trainings.length - 1
                      ? () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          OutlinedButton.icon(
            onPressed: _showFilterBottomSheet,
            icon: const Icon(Icons.filter_list),
            label: Text(
              'Filter${_hasActiveFilters ? ' (Active)' : ''}',
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black54,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10), 
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrainingsList() {
    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.05),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          itemCount: filteredTrainings.length,
          itemBuilder: (context, index) {
            return TrainingCard(
              training: filteredTrainings[index],
              onTap: () => _showTrainingDetails(filteredTrainings[index]),
            );
          },
        ),
      ),
    );
  }

  void _showTrainingDetails(Training training) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrainingDetailsScreen(training: training),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        selectedLocations: selectedLocations,
        selectedTrainings: selectedTrainings,
        selectedTrainers: selectedTrainers,
        availableLocations: trainings.map((t) => t.location).toSet().toList(),
        availableTrainings: trainings.map((t) => t.title).toSet().toList(),
        availableTrainers: trainings.map((t) => t.trainerName).toSet().toList(),
        onApplyFilters: (locations, trainings, trainers) {
          setState(() {
            selectedLocations = locations;
            selectedTrainings = trainings;
            selectedTrainers = trainers;
          });
        },
      ),
    );
  }

  bool get _hasActiveFilters =>
      selectedLocations.isNotEmpty ||
      selectedTrainings.isNotEmpty ||
      selectedTrainers.isNotEmpty;
}
