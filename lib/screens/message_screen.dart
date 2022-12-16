import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments ?? 'No data';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Center(
        child: Text(
          '$arguments',
          style: Theme.of(context).textTheme.headline4,
        ),
    ),
    );
  }
}
