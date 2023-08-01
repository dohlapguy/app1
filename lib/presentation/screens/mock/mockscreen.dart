import 'package:flutter/material.dart';
import 'package:app1/data/mock/mock.dart';

class MockScreen extends StatelessWidget {
  const MockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => addShopIdToProducts(),
              child: const Text('Mock '),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Mock'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Button 3'),
            ),
          ],
        ),
      ),
    );
  }
}
