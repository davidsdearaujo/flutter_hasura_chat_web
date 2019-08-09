import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:hasura_chat_web/src/app_bloc.dart';
import 'package:hasura_chat_web/src/app_module.dart';
import 'package:hasura_chat_web/src/shared/models/message_model.dart';
import 'package:hasura_chat_web/src/shared/models/user_model.dart';
import 'package:rxdart/subjects.dart';

class HomeRepository extends Disposable {
  final HasuraConnect connection;
  var appBloc = AppModule.to.bloc<AppBloc>();
  var countController = BehaviorSubject.seeded(20);
  
  Snapshot currentSnapshot;

  HomeRepository(this.connection);

  void extendsList() {
    currentSnapshot.close();
    countController.value += 20;
    getMessages();
  }

  Stream<List<MessageModel>> getMessages() {
    var query = """
      subscription {
      messages(order_by: {id: desc}, limit: ${countController.value}) {
        user {
          email
          id
          name
          picture
        }
        content
        id
      }
    }
    """;
    var currentSnapshot = connection.subscription(query);
    return currentSnapshot.stream
        .map((json) => MessageModel.fromJsonList(json["data"]["messages"]));
  }

  Future<void> sendMessage(String message) async {
    var query = """
      sendchat(\$id:Int!,\$message:String!){
        insert_messages(objects: {content: \$message, user_id: \$id}) {
          affected_rows
        }
      }
    """;

    await connection.mutation(query,
        variables: {"id": appBloc.userController.value.id, "message": message});
  }

  Future<UserModel> login(String email) async {
    var query = """
    login(\$email:String!){
      users(where: {email: {_eq: \$email}}) {
        id
        name
        picture
      }
    }
    """;

    var response = await connection.query(
      query,
      variables: {"email": email},
    );
    return UserModel.fromJsonList(response["data"]["users"]).last;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
