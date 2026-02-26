import 'package:flutter/material.dart';

class TestFeaturePage extends StatelessWidget {
  const TestFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestFeature'),
      ),
      body: const Center(
        child: Text('TestFeature Feature'),
      ),
    );
  }
}
