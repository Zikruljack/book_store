import 'package:flutter/material.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key});

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('TRAKSAKSI'),
    );
  }
}
