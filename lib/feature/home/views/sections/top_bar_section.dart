import 'package:flutter/material.dart';

class TopBarSection extends StatefulWidget {
  const TopBarSection({super.key});

  @override
  State<TopBarSection> createState() => _TopBarSectionState();
}

class _TopBarSectionState extends State<TopBarSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Text(
                "Contact",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              Text(
                "Recent",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.search, color: Colors.black54),
              SizedBox(width: 15),
              Icon(Icons.menu, color: Colors.black54),
            ],
          ),
        ],
      ),
    );
  }
}
