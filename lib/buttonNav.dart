import 'package:flutter/material.dart';
import 'package:tips_hidup_sehat/home.dart';
import 'profile.dart';

class ButtonNav extends StatefulWidget {
  const ButtonNav({Key? key}) : super(key: key);

  @override
  State<ButtonNav> createState() => _ButtonNavState();
}

class _ButtonNavState extends State<ButtonNav> {
  int selectedindex = 0;
  static const List<Widget> WidgetOptions = <Widget>[
    MyHome(),
    Profile(),
  ];
  void _onTaped(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "MyProfile"),
        ],
        currentIndex: selectedindex,
        selectedItemColor: Color(0xff25251f),
        onTap: _onTaped,
      ),
      body: Center(
        child: WidgetOptions.elementAt(selectedindex),
      ),
    );
  }
}
