import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/repos_model/repo.dart';
import 'package:github_user_search/services/api_utils.dart';
import 'package:http/http.dart';

final reposApiServiceProvider =
    Provider<ReposApiService>((ref) => ReposApiService());

class ReposApiService {
  Future<List<Repo>> getRepos({
    required String endpoint,
  }) async {
    debugPrint(">>> ReposApiService searchQuery : $endpoint");

    final response = await get(
      Uri.parse(endpoint),
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      final reposList = (jsonDecode(response.body) as List)
          .map((e) => Repo.fromJson(e))
          .toList();

      if (reposList.isEmpty) {
        throw Exception(">>> result!= null && result.isEmpty");
      } else {
        return reposList;
      }
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
