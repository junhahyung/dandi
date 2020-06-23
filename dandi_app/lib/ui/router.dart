import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider_architecture/core/models/post.dart';
import 'package:provider_architecture/ui/views/home_view.dart';
import 'package:provider_architecture/ui/views/login_view.dart';
import 'package:provider_architecture/ui/views/post_view.dart';
import 'package:provider_architecture/ui/views/detail_view.dart';

import 'package:provider_architecture/models/Record.dart';
import 'package:provider_architecture/models/RecordList.dart';
import 'package:provider_architecture/models/RecordService.dart';
import 'package:provider_architecture/helpers/Constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/post':
        //var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView());
      case '/details':
          var record = settings.arguments as Record;
        return MaterialPageRoute(builder: (_) => DetailPage(record: record));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
              ),
        ));

    }
  }
}