import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/services/user_api_service.dart';

String endpoint = "https://api.github.com/search/users?q=";

String searchQuery = "";
final searchQueryProvider = StateProvider<String>((ref) {
  return searchQuery;
});

final usersListProvider = FutureProvider<List<User>>(
  (ref) async {
    return ref.read(userApiServiceProvider).getUsers(
          searchQuery: "$endpoint${ref.watch(searchQueryProvider)}",
        );
  },
);
