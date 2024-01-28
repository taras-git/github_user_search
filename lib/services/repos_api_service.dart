import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/repos_model/repo.dart';
import 'package:github_user_search/model/user_moder/user_response.dart';
import 'package:http/http.dart';

final reposApiServiceProvider =
    Provider<ReposApiService>((ref) => ReposApiService());

class ReposApiService {
  Future<List<Repo>> getRepos({
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
      final List<Repo> reposList = jsonDecode(response.body);

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
