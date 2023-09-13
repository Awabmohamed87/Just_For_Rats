import 'package:flutter/material.dart';

class ProgramTile extends StatefulWidget {
  const ProgramTile({super.key});

  @override
  State<ProgramTile> createState() => _ProgramTileState();
}

class _ProgramTileState extends State<ProgramTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100]!.withOpacity(0.6)),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          children: [
            Text(
              'Program 1',
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
