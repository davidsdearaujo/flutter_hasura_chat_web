import 'package:flutter_web/material.dart';
import 'package:hasura_chat_web/src/app_module.dart';
import 'package:hasura_chat_web/src/home/home_module.dart';
import 'package:hasura_chat_web/src/login/login_module.dart';
import 'package:hasura_chat_web/src/shared/models/user_model.dart';

import 'app_bloc.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AppModule.to.bloc<AppBloc>();
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<UserModel>(
          stream: bloc.userController,
          builder: (context, snapshot) {
            return snapshot.hasData ? HomeModule() : LoginModule();
          }),
    );
  }
}
