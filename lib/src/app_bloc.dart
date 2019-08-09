import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_chat_web/src/shared/models/user_model.dart';
import 'package:rxdart/subjects.dart';

class AppBloc extends BlocBase {
  var userController = BehaviorSubject<UserModel>();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    userController.close();
    super.dispose();
  }
}
