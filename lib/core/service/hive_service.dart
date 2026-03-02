import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qunova/core/constants/hive_contants.dart';

class HiveService {
  final Ref ref;

  HiveService(this.ref);

  // save the first open status
  Future setFirstOpenValue({required bool value}) async {
    final appSettingsBox = Hive.box(HiveContants.appSettingsBox);
    appSettingsBox.put(HiveContants.firstOpen, value);
  }
}

final hiveStorageProvider = Provider((ref) => HiveService(ref));
