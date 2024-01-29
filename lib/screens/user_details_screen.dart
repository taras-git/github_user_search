import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/repos_model/repo.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/providers/data_provider.dart';

class UserDetailsScreen extends ConsumerWidget {
  final User userDetails;

  const UserDetailsScreen({
    super.key,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repos = ref.watch(reposListProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                maxRadius: 100,
                backgroundImage:
                    NetworkImage(userDetails.avatarUrl ?? "Image error..."),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "User Name :  ${userDetails.login}",
            ),
            Text("User Type : ${userDetails.type}"),
            Text(
              "ID : ${userDetails.id}",
            ),
            const SizedBox(height: 10),
            const Divider(),
            Expanded(
              child: repos.when(
                data: (data) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ...data.map(
                        (repo) => UserCard(repo: repo),
                      ),
                    ],
                  );
                },
                error: (error, s) => Center(child: Text(s.toString())),
                loading: () => const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final Repo repo;
  const UserCard({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("name: ${repo.name}"),
            if (repo.description != null)
              Text("description: ${repo.description}")
            else
              Container(),
            Text("language: ${repo.language}"),
            if (repo.license != null)
              Text("license: ${repo.license['name']}")
            else
              Container(),
          ],
        ),
      ),
    );
  }
}
