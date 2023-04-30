import 'package:currency_converter/views/screens/all_currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controllers/api_controller.dart';
import '../../controllers/google_ads_helper.dart';
import '../../models/currency_model.dart';
import '../../res/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Currency?> getData;

  @override
  void initState() {
    super.initState();
    getData = ApiHelper.apiHelper.fetchData();
  }

  int currentIndex = 0;
  IconData change = Icons.currency_exchange_sharp;
  IconData all = Icons.all_inbox_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: FutureBuilder(
          future: getData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Data not found",
                  style: GoogleFonts.arya(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: (Global.isDark) ? Colors.white : Colors.black,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              Currency? data = snapshot.data;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 160,
                    toolbarHeight: 80,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(25)),
                        color: (Global.isDark == false)
                            ? const Color(0xff35313f)
                            : const Color(0xffe9e2f1),
                      ),
                      child: FlexibleSpaceBar(
                        expandedTitleScale: 1,
                        background: Align(
                          alignment: const Alignment(-0.73, -0.4),
                          child: Text(
                            "Currency Converter",
                            style: GoogleFonts.arya(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Global.isDark == false
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              flex: 11,
                              child: SizedBox(
                                height: 50,
                                width: 200,
                                child: Text(
                                  "Currency",
                                  style: GoogleFonts.arya(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color: Global.isDark == false
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  Get.changeThemeMode(
                                    (Get.isDarkMode == true)
                                        ? ThemeMode.light
                                        : ThemeMode.dark,
                                  );
                                  setState(() {
                                    Global.isDark = !Global.isDark;
                                  });
                                },
                                child: const Icon(Icons.light_mode_outlined),
                              ),
                            ),
                          ],
                        ),
                        titlePadding:
                            const EdgeInsets.only(left: 20, bottom: 20),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 5,
                            shadowColor: Colors.grey.shade300,
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                color: Colors.blue,
                                shape: NeumorphicShape.convex,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10)),
                                shadowLightColor: Colors.transparent,
                                surfaceIntensity:
                                    Get.isDarkMode == true ? 0.9 : 0.5,
                                lightSource: LightSource.bottomLeft,
                                oppositeShadowLightSource: true,
                              ),
                              child: Container(
                                height: 310,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Select your currency type",
                                      style: GoogleFonts.arya(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.indigo.shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        icon: const Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: Colors.white,
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        dropdownColor: Colors.indigo.shade300,
                                        menuMaxHeight: 500,
                                        underline: Container(),
                                        value: Global.selectedFrom,
                                        onChanged: (val) {
                                          setState(() {
                                            Global.selectedFrom = val;
                                            Global.indexValue = Global
                                                .currencyName
                                                .indexOf(val);
                                          });
                                        },
                                        items: Global.currencyName
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Text(
                                      "Select Converted Currency type",
                                      style: GoogleFonts.arya(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.indigo.shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.centerRight,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        icon: const Icon(
                                          Icons.arrow_drop_down_outlined,
                                          color: Colors.white,
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                        dropdownColor: Colors.indigo.shade300,
                                        menuMaxHeight: 500,
                                        underline: Container(),
                                        value: Global.selectedTo,
                                        onChanged: (val) {
                                          setState(() {
                                            Global.selectedTo = val;
                                            Global.indexValue = Global
                                                .currencyName
                                                .indexOf(val);
                                          });
                                        },
                                        items: Global.currencyName
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Text(
                                      "Enter Rate",
                                      style: GoogleFonts.arya(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo.shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: Global.amount,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.indigo, width: 0),
                                          ),
                                          hintText: Global.rate.toString(),
                                          hintStyle: TextStyle(
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            Global.rate = int.parse(val);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Card(
                            elevation: 5,
                            shadowColor: Colors.grey.shade300,
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                color: Colors.blue,
                                shape: NeumorphicShape.convex,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10)),
                                shadowLightColor: Colors.transparent,
                                surfaceIntensity:
                                    Get.isDarkMode == true ? 0.9 : 0.5,
                                lightSource: LightSource.bottomLeft,
                                oppositeShadowLightSource: true,
                              ),
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Your Converted currency",
                                      style: GoogleFonts.arya(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                      return Text(
                                        "${data!.result}",
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 23,
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Card(
                            elevation: 5,
                            shadowColor: Colors.grey.shade300,
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                color: Colors.blue,
                                shape: NeumorphicShape.convex,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(10)),
                                shadowLightColor: Colors.transparent,
                                surfaceIntensity:
                                    Get.isDarkMode == true ? 0.9 : 0.5,
                                lightSource: LightSource.bottomLeft,
                                oppositeShadowLightSource: true,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    getData = ApiHelper.apiHelper.fetchData(
                                      amount: Global.rate,
                                      to: Global.selectedTo,
                                      from: Global.selectedFrom,
                                    );
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Convert",
                                    style: GoogleFonts.arya(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                color: Global.isDark ? Colors.white : Colors.black,
                size: 30,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            currentIndex = val;
            if (currentIndex == 0) {
              change = Icons.currency_exchange_sharp;
              all = Icons.all_inbox_outlined;
            } else if (currentIndex == 1) {
              if (AdHelper.adHelper.interstitialAd != null) {
                AdHelper.adHelper.interstitialAd!.show();
                AdHelper.adHelper.loadInterstitialAd();
              }
              change = Icons.currency_exchange_outlined;
              all = Icons.all_inbox_sharp;
              Get.off(
                () => const AllCurrency(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            }
          });
        },
        backgroundColor:
            (Global.isDark) ? const Color(0xffe9e2f1) : const Color(0xff35313f),
        selectedItemColor: (Global.isDark) ? Colors.black : Colors.white,
        unselectedItemColor: Colors.grey.shade600,
        items: [
          BottomNavigationBarItem(
              icon: Icon(change, size: 30), label: 'change currency'),
          BottomNavigationBarItem(
              icon: Icon(all, size: 30), label: 'all currency'),
        ],
        currentIndex: 0,
      ),
    );
  }
}
