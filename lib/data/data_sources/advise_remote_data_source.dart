import 'dart:convert';

import 'package:advicer_app/data/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import '../models/advise_model.dart';

abstract class AdviseRemoteDataSource {
  ///returns `AdviseModel` for status code 200
  ///
  ///returns ServerException for other status codes
  Future<AdviseModel> getRandomAdvice();
}

class AdviseRemoteDataSourceImpl implements AdviseRemoteDataSource {
  final http.Client client;

  AdviseRemoteDataSourceImpl({required this.client});

  @override
  Future<AdviseModel> getRandomAdvice() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw (ServerException());
    } else {
      final body = json.decode(response.body);
      return AdviseModel.fromJson(body);
    }
  }
}
