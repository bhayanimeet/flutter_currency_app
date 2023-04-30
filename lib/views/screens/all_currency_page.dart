import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/global.dart';
import 'homepage.dart';

class AllCurrency extends StatefulWidget {
  const AllCurrency({Key? key}) : super(key: key);

  @override
  State<AllCurrency> createState() => _AllCurrencyState();
}

class _AllCurrencyState extends State<AllCurrency> {
  int currentIndex = 1;
  IconData change = Icons.currency_exchange_outlined;
  IconData all = Icons.all_inbox_sharp;
  List apiData = [];

  void fetchData() async {
    String api = "https://restcountries.com/v2/all";

    http.Response result = await http.get(Uri.parse(api));

    if (result.statusCode == 200) {
      List decodedData = jsonDecode(result.body);

      setState(() {
        apiData = decodedData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            toolbarHeight: 80,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25)),
                color: (Global.isDark == false)
                    ? const Color(0xff35313f)
                    : const Color(0xffe9e2f1),
              ),
              child: FlexibleSpaceBar(
                expandedTitleScale: 1,
                background: Align(
                  alignment: const Alignment(-0.9, -0.4),
                  child: Text(
                    "Currency Converter",
                    style: GoogleFonts.arya(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color:
                          Global.isDark == false ? Colors.white : Colors.black,
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
                          "All Currency",
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
                titlePadding: const EdgeInsets.only(left: 10, bottom: 20),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: apiData.length,
              itemBuilder: (context, i) => Card(
                elevation: 3,
                child: ListTile(
                  isThreeLine: true,
                  leading: Container(
                    height: 70,
                    width: 70,
                    color: Global.isDark==true? Colors.black54 : Colors.white30,
                    child: Image.network(
                      apiData[i]['flags']['png'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "${apiData[i]['name']} id :- $i",
                      style: GoogleFonts.arya(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (apiData[i]['capital'] != null)
                              ? "Capital :- ${apiData[i]['capital']}"
                              : 'Not found in data',
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          (i == 8)
                              ? 'information not available'
                              : "Currency :- ${apiData[i]['currencies'][0]['code']}",
                          style: GoogleFonts.play(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            currentIndex = val;
            if (currentIndex == 0) {
              change = Icons.currency_exchange_sharp;
              all = Icons.all_inbox_outlined;
              Get.off(
                () => const HomePage(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            } else if (currentIndex == 1) {
              change = Icons.currency_exchange_outlined;
              all = Icons.all_inbox_sharp;
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
        currentIndex: 1,
      ),
    );
  }
}
