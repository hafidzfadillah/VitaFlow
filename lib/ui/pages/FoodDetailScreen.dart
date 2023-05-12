import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/FoodRatingCard.dart';
import 'package:vitaflow/ui/widgets/NutrientChart.dart';
import 'package:vitaflow/ui/widgets/NutrionSummary.dart';
import 'package:vitaflow/ui/widgets/button.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
    const List<String> listUnitDummy = <String>['gram', ' porsi'];
    String dropdownValue = listUnitDummy.first;
    return Scaffold(
        backgroundColor: lightModeBgColor,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: 70,
          child: FloatingActionButton.extended(
             backgroundColor: const Color(0xff18B279),
              onPressed: () {
                // show snack bacr

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Dalam pengembangan"),
                    duration: Duration(seconds: 1),
                  ),
                );

              },
              label: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Tambahkan ke asupan" , style: normalText.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight:  FontWeight.w600
                  ))])),
        ),
        appBar: AppBar(
          backgroundColor: lightModeBgColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Ayam Bakar',
            style: normalText.copyWith(
                fontSize: 16,
                color: const Color(0xff333333),
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: Color(0xff333333)),
            ),
          ],
          leading: CustomBackButton(
            onClick: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ayam Goreng",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff333333)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1 Serving",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff333333)),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("100 gram"),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const FoodRating(
                rating: 'A',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Pilih Porsi',
                style: normalText.copyWith(
                    fontSize: 16,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xffEAE7E7),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color(0xffEAE7E7),
                          ),
                        ),
                        hintText: '100',
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xffEAE7E7))),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        elevation: 0,
                        style: const TextStyle(color: Color(0xff454545)),
                        borderRadius: BorderRadius.circular(16),
                        isExpanded: false,
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: listUnitDummy
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                ],
              ),
              const NutrientChart(
                carbsPercentage: 75,
                fatPercentage: 20,
                proteinPercentage: 5,
              ),

              const SizedBox(
                height: 16,
              ),

              //Nutrition Summary

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mikronutrisi',
                    style: normalText.copyWith(
                        fontSize: 16,
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        "Buka Info",
                        style: normalText.copyWith(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/images/arrow_down.png',
                        width: 12,
                        height: 12,
                        color: const Color(0xff333333),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
