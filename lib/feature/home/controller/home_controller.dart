import 'package:qunova/core/utils/global_function.dart';
import 'package:qunova/feature/home/data/home_repository.dart';
import 'package:qunova/feature/home/models/data_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  Future<DataModel> build() async {
    final response = await ref.read(homeRepositoryProvider).getData();

    try {
      if (response.statusCode == 200) {
        DataModel dataModel = DataModel.fromJson(response.data);

        return dataModel;
      }
      return DataModel.fromJson(response.data);
    } catch (error, stackTracer) {
      AppGlobalFunctions.logDebug(error.toString());
      AppGlobalFunctions.logDebug(stackTracer.toString());
      rethrow;
    }
  }
}
