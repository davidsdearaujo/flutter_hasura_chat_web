import 'package:flutter_web/material.dart';
import 'package:hasura_chat_web/src/login/login_bloc.dart';
import 'package:hasura_chat_web/src/login/login_module.dart';
import 'package:hasura_chat_web/src/shared/models/message_model.dart';
import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var bloc = HomeModule.to.bloc<HomeBloc>();
  var loginBloc = LoginModule.to.bloc<LoginBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat da Uol"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: loginBloc.logout,
          ),
        ],
      ),
      body: StreamBuilder<List<MessageModel>>(
        stream: bloc.messagesOut,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  controller: bloc.scrollController,
                  reverse: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data[index].user.picture)),
                      title: Text(snapshot.data[index].user.name),
                      subtitle: Text(snapshot.data[index].content),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: bloc.controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: bloc.sendMessage,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
