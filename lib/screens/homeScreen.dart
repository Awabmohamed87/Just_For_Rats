// ignore_for_file: file_names

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selectedIndex,
        backgroundColor: const Color.fromARGB(255, 153, 27, 18),
        items: [
          FlashyTabBarItem(
              activeColor: Colors.white,
              icon: const Icon(Icons.sports_gymnastics),
              title: const Text('Exercises')),
          FlashyTabBarItem(
              activeColor: Colors.white,
              icon: const Icon(Icons.sports_gymnastics),
              title: const Text('Exercises')),
        ],
        onItemSelected: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(0, 0, 0, 0.4),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: deviceSize.height * 0.015),
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
