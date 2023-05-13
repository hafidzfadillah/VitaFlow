import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/exercise/exercise_model.dart';
import 'package:vitaflow/core/viewmodels/classify/classify_provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/core/viewmodels/exercise/exercie_provider.dart';
import 'package:vitaflow/core/viewmodels/food/food_provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/main_pages.dart';
import 'package:vitaflow/ui/pages/record_sport_screen.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/FoodItem.dart';
import 'package:vitaflow/ui/widgets/SearchHistoryItem.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/input_costume.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:vitaflow/ui/widgets/picker_image.dart';
import 'package:vitaflow/ui/widgets/workout_item.dart';

class InputWorkoutScreen extends StatefulWidget {

  const InputWorkoutScreen({Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputWorkoutScreen createState() => _InputWorkoutScreen();
}

class _InputWorkoutScreen extends State<InputWorkoutScreen>
    with TickerProviderStateMixin {
  TextEditingController? search = TextEditingController(text: "");
  TextEditingController? search2 = TextEditingController(text: "");

  String? foodPrediction;
  @override
  Map<ExerciseModel, bool> selectedExercise = {};
  void _updateSelectedExercise(Map<ExerciseModel, bool> selectedExercise) {
    setState(() {
      this.selectedExercise = selectedExercise;
    });
  }

  // didupdate

  /// Image result from picker image
  File? image;

  /// Pick some pictures
  /// and scan the images
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButton: selectedExercise.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                List<ExerciseModel> selected = selectedExercise.entries
                    .where((element) => element.value)
                    .map((e) => e.key)
                    .toList();

                final UserProvider userProvider = UserProvider();

                userProvider.storeExercise(selected);
                // delay
                Future.delayed(const Duration(seconds: 1), () {
                 Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPages()))
                      .then((value) {
                    if (value != null && value == true) {
                      // Refresh widget disini
                    }
                  });
                });
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.check),
            )
          : const FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.grey,
              child: Icon(Icons.check),
            ),
      appBar: AppBar(
        backgroundColor: lightModeBgColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Kegiatan latihan",
          style: normalText.copyWith(
              fontSize: 16,
              color: const Color(0xff333333),
              fontWeight: FontWeight.w600),
        ),

        leading: CustomBackButton(
          onClick: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ExerciseProvider(),
        child: ExerciseBody(
          search: search,
          search2: search2,
          selectedExercise: selectedExercise,
          updateSelectedFoods: _updateSelectedExercise,
          predictFood: foodPrediction,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ExerciseBody extends StatefulWidget {
  ExerciseBody({
    super.key,
    required this.search,
    required this.search2,
    required this.selectedExercise,
    required this.updateSelectedFoods,
    required this.predictFood,
  });

  final TextEditingController? search;
  final TextEditingController? search2;
  final String? predictFood;
  Map<ExerciseModel, bool> selectedExercise = {};
  final Function(Map<ExerciseModel, bool> selectedExercise) updateSelectedFoods;

  @override
  State<ExerciseBody> createState() => _ExerciseBody();
}

class _ExerciseBody extends State<ExerciseBody> {
  Future<void> refreshHome(BuildContext context) async {
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(builder: (context, connectionProv, _) {
      if (connectionProv.internetConnected == false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tidak Ada Koneksi Internet"),
              ElevatedButton(
                onPressed: () => refreshHome(context),
                child: const Text("Refresh"),
              )
            ],
          ),
        );
      }

      return SafeArea(
        child: DefaultTabController(
          length: 2, // Jumlah tabs
          child: Column(
            children: [
              const TabBar(
                labelStyle: TextStyle(fontSize: 14, color: Color(0xff333333)),
                labelColor: Color(0xff333333),
                indicatorColor:
                    Colors.green, // Warna indicator untuk tab yang aktif
                tabs: [
                  Tab(text: 'Terakhir dicari'),
                  Tab(text: 'Olahraga Populer'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Konten untuk tab 'Makanan yang terakhir dicari'
                    _ExerciseSearch(
                        search: widget.search,
                        selectedExercise: widget.selectedExercise,
                        updateSelectedFoods: widget.updateSelectedFoods,
                        predictFood: widget.predictFood),
                    // Konten untuk tab 'Terakhir dimakan'

                    _PopulerExercise(
                        search: widget.search2,
                        selectedExercise: widget.selectedExercise,
                        updateSelectedFoods: widget.updateSelectedFoods),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ExerciseSearch extends StatefulWidget {
  const _ExerciseSearch({
    required this.search,
    required this.selectedExercise,
    required this.updateSelectedFoods,
    required this.predictFood,
  });

  final TextEditingController? search;
  final Map<ExerciseModel, bool> selectedExercise;
  final Function updateSelectedFoods;
  final String? predictFood;
  @override
  State<_ExerciseSearch> createState() => _ExerciseSearchState();
}

class _ExerciseSearchState extends State<_ExerciseSearch> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ExerciseProvider, UserProvider>(
      builder: (context, exerciseProv, userProv, _) {
        if (userProv.searchHistory.isEmpty) {
          // if the categories have been loaded, show the category chips
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (value) {
                      ExerciseProvider.instance(context).searchLastSearch(value);
                      userProv.searchLastSearch(value);
                    },
                    controller: widget.search,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xffB8B8B8)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      hintText: 'Cari Kegiatan olahraga  ',
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                  const SizedBox(height: 20),
                 
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text('Tidak ada riwayat pencarian'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            TextField(
              controller: widget.search,
              onSubmitted: (value) {
                ExerciseProvider.instance(context).searchLastSearch(value);
                userProv.searchLastSearch(value);
              },
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Color(0xffB8B8B8)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Color(0xffEAE7E7),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Color(0xffEAE7E7),
                  ),
                ),
                hintText: 'Makan apa yah',
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
            const SizedBox(height: 16),
            if (exerciseProv.searchExercises?.isEmpty ?? true)
              SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: userProv.searchHistory.map((e) {
                    return GestureDetector(
                      onTap: () {
                        widget.search!.text = e;
                        ExerciseProvider.instance(context).searchLastSearch(e);
                      },
                      child: SearchHistoryItem(title: e),
                    );
                  }).toList(),
                ),
              ),
            
       
            SizedBox(
              height: 16,
            ),
            if (exerciseProv.searchExercises?.isNotEmpty ?? false)
              SingleChildScrollView(
                child: Column(
                  children: exerciseProv.searchExercises
                          ?.map((e) =>  WorkoutItem(
                                title: e.exerciseName,
                                durasiDetik: 3600,
                                jmlKkal: e.caloriesBurnedEstimate,
                                
                            
                                isChecked: widget.selectedExercise[e] ?? false,
                                onSelect: (value) {
                                  setState(() {
                                    widget.selectedExercise[e] = value;
                                    if (!value) {
                                      widget.selectedExercise.remove(e);
                                    }
                                  });
                                  widget.updateSelectedFoods(
                                      widget.selectedExercise);
                                }, // update value isChecked dari parent screen
                              ))
                          .toList() ??
                      [], // add null check operator and default empty list
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PopulerExercise extends StatefulWidget {
  const _PopulerExercise({
    Key? key,
    required this.search,
    required this.selectedExercise,
    required this.updateSelectedFoods,
  }) : super(key: key);

  final TextEditingController? search;
  final Map<ExerciseModel, bool> selectedExercise;
  final Function updateSelectedFoods;

  @override
  State<_PopulerExercise> createState() => _PopulerExerciseState();
}

class _PopulerExerciseState extends State<_PopulerExercise> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Consumer2<ExerciseProvider, ClassifyProvider>(
              builder: (context, exerciseProv, classifyProvider, _) {
                if (exerciseProv.exercises == null && !exerciseProv.onSearch) {
                  exerciseProv.getExercises();

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (exerciseProv.exercises == null && exerciseProv.onSearch) {
                  // if the categories are being searched, show a skeleton loading
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (exerciseProv.exercises!.isEmpty) {
                  // if the categories have been loaded, show the category chips
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Center(
                      child: Column(
                        children: [
                          TextField(
                            onSubmitted: (value) {
                              ExerciseProvider.instance(context).search(value);
                            },
                            controller: widget.search,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              prefixIcon: const Icon(Icons.search,
                                  color: Color(0xffB8B8B8)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: Color(0xffEAE7E7),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: Color(0xffEAE7E7),
                                ),
                              ),
                              hintText: 'Cari makanan terakhir dimakan',
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child:
                                const Text('Tidak ada produk yang ditemukan'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // di dalam widget
                if (classifyProvider.scanState == ClassifyState.Scanning) {
                  print(classifyProvider.productResult?.substring(2));
                  // ExerciseProvider.instance(context).search(
                  //     classifyProvider.productResult?.substring(2) ?? "");
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const CircularProgressIndicator(),
                  );
                }

                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    TextField(
                      onSubmitted: (value) {
                        ExerciseProvider.instance(context).search(value);
                      },
                      controller: widget.search,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xffB8B8B8)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Color(0xffEAE7E7),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Color(0xffEAE7E7),
                          ),
                        ),
                        hintText: 'Cari kegiatan olahraga',
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      child: Column(
                        children: exerciseProv.exercises
                                ?.map((e) => WorkoutItem(
                                      title: e.exerciseName,
                                      durasiDetik: e.exerciseDuration,
                                      jmlKkal: e.caloriesBurnedEstimate,

                                      isChecked:
                                          widget.selectedExercise[e] ?? false,
                                      onSelect: (value) {
                                        setState(() {
                                          widget.selectedExercise[e] = value;
                                          if (!value) {
                                            widget.selectedExercise.remove(e);
                                          }
                                        });
                                        widget.updateSelectedFoods(
                                            widget.selectedExercise);
                                      }, // update value isChecked dari parent screen
                                    ))
                                .toList() ??
                            [], // add null check operator and default empty list
                      ),
                    ),
                  ],
                );
              },
            ));
  }
}
