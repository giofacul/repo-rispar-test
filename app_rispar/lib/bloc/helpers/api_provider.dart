import 'dart:convert';

import 'package:app_rispar/bloc/helpers/user_solicitation_model.dart';
import 'package:http/http.dart';

class ApiProvider {
  Client client = Client();

  fetchPosts() async {
    final response = await client
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));

    UserSolicitationModel itemModel = UserSolicitationModel.fromJson(
      jsonDecode(response.body)
    );
    return itemModel;
  }

}
