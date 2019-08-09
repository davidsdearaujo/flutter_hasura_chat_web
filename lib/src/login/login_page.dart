import 'package:flutter_web/material.dart';
import 'package:hasura_chat_web/src/login/login_module.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var bloc = LoginModule.to.bloc<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: StreamBuilder<bool>(
          stream: bloc.loginOut,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: bloc.emailTextController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    suffixIcon: (snapshot.data == false)
                        ? Container(
                          padding: EdgeInsets.all(15),
                          width: 10,
                          height: 10,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                        : IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: bloc.login,
                          ),
                    border: OutlineInputBorder(),
                  ),
                ),
                if (snapshot.hasError)
                  Text(
                    "Email inválido",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
