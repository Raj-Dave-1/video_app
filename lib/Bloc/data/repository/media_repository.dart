// Dada Ki Jay HO

import 'dart:convert';

import 'package:video_app/Bloc/constants/utils.dart';
import 'package:video_app/Bloc/data/model/api_result_model.dart';

import 'package:http/http.dart' as http;

abstract class MediaRepository {
  Future<List<Media>> getMedias();
}

class MediaRepositoryImpl implements MediaRepository {
  @override
  Future<List<Media>> getMedias() async {
    var response = await http.get(Uri.parse(AppStrings.resUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Media> medias = ApiResultModel.fromJson(data).slides;
      print("Medias are ready: $medias");
      return medias;
    } else {
      throw Exception();
    }
  }
}

class NetworkError extends Error {}
