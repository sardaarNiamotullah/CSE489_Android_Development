import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'form_screen.dart';
import 'list_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'App Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('Form'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
