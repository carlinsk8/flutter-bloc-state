import 'dart:async';

import 'package:bloc_state_management/models/news_model.dart';
import 'package:bloc_state_management/services/news_service.dart';

enum NewsAction { Fetch, Delete }

class NewsBloc {
  final newsService = NewsService();
  final _stateStreamController = StreamController<List<Article>>();

  StreamSink<List<Article>> get _stateSink => _stateStreamController.sink;
  Stream<List<Article>> get stateStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();

  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await newsService.getNews();
          if (news != null)
            _stateSink.add(news.articles);
          else
            _stateSink.addError('Something went wrong');
        } on Exception catch (_) {
          _stateSink.addError('Something went wrong');
        }
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
