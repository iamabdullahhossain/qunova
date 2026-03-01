import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qunova/feature/home/controller/home_controller.dart';
import 'package:qunova/feature/home/views/sections/category_section.dart';
import 'package:qunova/feature/home/views/sections/contacts_section.dart';
import 'package:qunova/feature/home/views/sections/top_bar_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2E7D67),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: data.when(
          data: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarSection(),
              CategorySection(category: data.data?.categories),
              const SizedBox(height: 10),
              Expanded(child: ContactsSection(contacts: data.data?.contacts)),
            ],
          ),
          error: (error, stackTracer) => Text("Something went wrong"),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
