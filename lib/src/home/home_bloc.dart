import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_web/cupertino.dart';
import 'package:hasura_chat_web/src/shared/models/message_model.dart';

import 'home_repository.dart';

class HomeBloc extends BlocBase {
  final HomeRepository repository;
  final controller = TextEditingController();
  var scrollController = ScrollController();

  HomeBloc(this.repository) {
    messagesOut = repository.getMessages();
    scrollController.addListener(() {
      if(scrollController.positions?.isNotEmpty && scrollController.position.minScrollExtent <= scrollController.offset){
        repository.extendsList();
      }
    });
  }

  void sendMessage() {
    if (controller.text.trim().isNotEmpty) {
      repository.sendMessage(controller.text.trim());
      controller.clear();
    }
  }

  Stream<List<MessageModel>> messagesOut;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
