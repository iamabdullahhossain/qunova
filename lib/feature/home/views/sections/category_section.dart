import 'package:flutter/material.dart';
import 'package:qunova/feature/home/models/data_model.dart';

class CategorySection extends StatefulWidget {
  CategorySection({super.key, required this.category});

  List<Category>? category;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.category!.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    widget.category![index].name![0],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.category![index].name!,
                  style: TextStyle(
                    color: index == 0
                        ? const Color(0xFF2E7D67)
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
