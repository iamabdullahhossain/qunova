import 'package:flutter/material.dart';
import 'package:qunova/gen/assets.gen.dart';

class TopBarSection extends StatefulWidget {
  const TopBarSection({
    super.key,
    this.showSearchField = false,
    this.searchText = '',
    this.onSearchChanged,
    this.onSearchToggle,
  });

  final bool showSearchField;
  final String searchText;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchToggle;

  @override
  State<TopBarSection> createState() => _TopBarSectionState();
}

class _TopBarSectionState extends State<TopBarSection> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchText);
  }

  @override
  void didUpdateWidget(TopBarSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchText != oldWidget.searchText) {
      _searchController.text = widget.searchText;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: widget.showSearchField
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: _searchController,
                onChanged: widget.onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF2E7D67)),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: widget.onSearchToggle,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: const Icon(Icons.close, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Recent",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onSearchToggle,
                      child: Image.asset(
                        Assets.png.search.path,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Image.asset(Assets.png.menu.path, height: 20, width: 20),
                  ],
                ),
              ],
            ),
    );
  }
}
