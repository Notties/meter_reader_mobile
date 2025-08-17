import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ผู้ใช้')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('ชื่อผู้ใช้'),
            subtitle: Text('user@example.com'),
          ),
          Divider(),
          ListTile(leading: Icon(Icons.settings), title: Text('การตั้งค่า')),
          ListTile(leading: Icon(Icons.logout), title: Text('ออกจากระบบ')),
        ],
      ),
    );
  }
}
