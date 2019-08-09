import 'package:hasura_chat_web/src/app_module.dart';
import 'package:hasura_chat_web/src/home/home_repository.dart';
import 'package:hasura_chat_web/src/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_web/material.dart';
import 'package:hasura_chat_web/src/home/home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(AppModule.to.get<HomeRepository>())),
      ];

  @override
  List<Dependency> get dependencies => [
      ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
