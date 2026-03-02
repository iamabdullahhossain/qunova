import 'package:flutter/material.dart';
import 'package:qunova/feature/home/models/data_model.dart';

class CategorySection extends StatefulWidget {
  CategorySection({
    super.key,
    required this.category,
    this.selectedCategoryId,
    this.onCategorySelected,
  });

  List<Category>? category;
  final String? selectedCategoryId;
  final ValueChanged<String?>? onCategorySelected;

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
          final cat = widget.category![index];
          final isSelected =
              (cat.id ?? 'all') == (widget.selectedCategoryId ?? 'all');

          return GestureDetector(
            onTap: () {
              widget.onCategorySelected?.call(cat.id ?? 'all');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: isSelected ? 30 : 28,
                    backgroundColor: isSelected
                        ? const Color(0xFF2E7D67)
                        : Colors.grey.shade300,
                    child: Text(
                      cat.name![0],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat.name!,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF2E7D67)
                          : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
