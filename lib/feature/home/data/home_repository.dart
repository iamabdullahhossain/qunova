import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qunova/core/constants/app_constants.dart';
import 'package:qunova/core/network/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepositoryImp(ref);
}

abstract class HomeRepository {
  Future<Response> getData();
}

class HomeRepositoryImp implements HomeRepository {
  HomeRepositoryImp(this.ref);

  final Ref ref;

  @override
  Future<Response<dynamic>> getData() {
    return ref.read(apiClientProvider).get(AppConstants.url);
  }
}
