import 'package:flutter/material.dart';
import '../models/conversion_history.dart';

class HistoryScreen extends StatelessWidget {
  final List<ConversionHistory> history;

  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion History'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'No conversions yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[history.length - 1 - index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text(item.toString()),
                    subtitle: Text(
                      '${item.conversionType} • ${_formatDate(item.timestamp)}',
                    ),
                    leading: const Icon(Icons.history),
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
