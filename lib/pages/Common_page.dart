import 'package:flutter/material.dart';

class CommonPage extends StatelessWidget {
  String appbartitle;
  String title;

  CommonPage({required this.appbartitle, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appbartitle),
        ),
        body: Column(
          children: [
            TextField(
                decoration: InputDecoration(
              hintText: 'Enter $title type',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            )),
            SizedBox(height: 20),
            TextField(
                decoration: InputDecoration(
              hintText: 'Enter $title Amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            )),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Save $title'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            )
          ],
        ));
  }
}
