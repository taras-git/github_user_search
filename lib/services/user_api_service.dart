import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/model/user_moder/user_response.dart';
import 'package:http/http.dart';

final userApiServiceProvider =
    Provider<UserApiService>((ref) => UserApiService());

class UserApiService {
  Future<List<User>> getUsers({
    required String searchQuery,
  }) async {
    final requestHeaders = {
      'Accept': 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28'
    };

    final response = await get(
      Uri.parse(searchQuery),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final items = UserResponse.fromJson(
        jsonDecode(response.body),
      ).users;

      if (items != null //
          &&
          items.isEmpty) {
        throw Exception(">>> result!= null && result.isEmpty");
      } else {
        return items!;
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
