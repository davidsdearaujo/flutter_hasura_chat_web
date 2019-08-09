import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_web/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:hasura_chat_web/src/app_widget.dart';
import 'package:hasura_chat_web/src/app_bloc.dart';

import 'home/home_repository.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => HomeRepository(i.get<HasuraConnect>())),
        Dependency((i) => HasuraConnect(
            "https://test-hasura-connect.herokuapp.com/v1/graphql")),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
