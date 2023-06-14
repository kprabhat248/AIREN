import 'package:chat_gpt_02/map.dart';
import 'package:chat_gpt_02/search_page.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'profile_dashboard.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required Null Function(dynamic index) onTap,
    required currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      borderRadius: 40,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 243, 98, 50).withAlpha(10),
          Color.fromARGB(255, 230, 126, 126).withAlpha(15),
        ],
        stops: [0.0, 1.0], // set stops to [0.0, 1.0]
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 240, 242, 240).withAlpha(20),
          Color.fromARGB(255, 252, 252, 252).withAlpha(20),
        ],
      ),
      height: 70,
      width: 30,
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width - 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchPage()));
                // Handle search icon press here
              },
            ),
            IconButton(
              icon: Icon(Icons.map),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MapScreen()));
              }, // Handle the button press here
            ),
            IconButton(
              icon: Icon(Icons.person_outline_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDashboard(
                      username: 'Sakura',
                      phoneNumber: '+91777777777',
                      photoUrl: 'https://picsum.photos/200/300',
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileDashboard(
                      username: 'Itachi',
                      phoneNumber: '+1 123 456 7890',
                      photoUrl: 'https://picsum.photos/200',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
