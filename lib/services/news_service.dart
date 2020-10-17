import 'dart:convert';

import 'package:bloc_state_management/globals/env.dart';
import 'package:bloc_state_management/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client
          .get('${Env.urlNews}everything?domains=wsj.com&apiKey=${Env.apiKey}');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
