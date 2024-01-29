import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/model/user_moder/user_response.dart';
import 'package:github_user_search/services/api_utils.dart';
import 'package:http/http.dart';

final userApiServiceProvider =
    Provider<UserApiService>((ref) => UserApiService());

class UserApiService {
  Future<List<User>> getUsers({
    required String endpoint,
  }) async {
    final response = await get(
      Uri.parse(endpoint),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final users = UserResponse.fromJson(
        jsonDecode(response.body),
      ).users;

      if (users != null //
          &&
          users.isEmpty) {
        throw Exception(">>> result!= null && result.isEmpty");
      } else {
        return users!;
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
