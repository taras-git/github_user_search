import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/repos_model/repo.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/services/repos_api_service.dart';
import 'package:github_user_search/services/user_api_service.dart';

String baseEndpoint = "https://api.github.com";

/// Users
String usersEndpoint = "$baseEndpoint/search/users?q=";

String userSearchQuery = "";
final userSearchQueryProvider = StateProvider<String>((ref) {
  return userSearchQuery;
});

final usersListProvider = FutureProvider<List<User>>(
  (ref) async {
    return ref.read(userApiServiceProvider).getUsers(
          searchQuery: "$usersEndpoint${ref.watch(userSearchQueryProvider)}",
        );
  },
);

/// User Repos
///
String reposEndpoint = "$baseEndpoint/users";

String reposSearchQuery = "";
final reposSearchQueryProvider = StateProvider<String>((ref) {
  return reposSearchQuery;
});

final reposListProvider = FutureProvider<List<Repo>>(
  (ref) async {
    return ref.read(reposApiServiceProvider).getRepos(
          searchQuery:
              "$reposEndpoint/${ref.watch(reposSearchQueryProvider)}/repos",
        );
  },
);
