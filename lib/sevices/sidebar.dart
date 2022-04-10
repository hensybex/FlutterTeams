import 'package:flutter/material.dart';

class SideBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('SideMenu header'),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './home', (route) => false);
            },
          ),
          ListTile(
            title: const Text('ToDo list'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './todo', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Squad Builder'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './squad_builder', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Player list'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './player_list', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Calendar'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './calendar', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './profile', (route) => false);
            },
          ),
          ListTile(
            title: const Text('Test'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, './test', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
