import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grosseries/components/add_bottom_sheet.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        GoRouter.of(context).go("/");
      } else if (_selectedIndex == 1) {
        // GoRouter.of(context).go("/add_item");
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 300,
                decoration: BoxDecoration(color: Colors.yellow[100]),
                padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
                child: const AddBottomSheet(),
              );
            });
      } else if (_selectedIndex == 2) {
        // GoRouter.of(context).go("/login");
        GoRouter.of(context).go("/profile");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.yellow[800],
        backgroundColor: Colors.yellow[100],
        onTap: _onItemTapped,
      ),
      body: widget.child,
    );
  }
}
