import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/repos_model/repo.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/providers/data_provider.dart';
import 'package:github_user_search/screens/user_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final userSearchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          children: [
            const Text("Github User"),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.white,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                hintText: 'Search user nickname...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    ref.read(userSearchQueryProvider.notifier).state =
                        userSearchFieldController.text;
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
              controller: userSearchFieldController,
              onChanged: (value) {
                userSearchFieldController.text = value;
              },
              onSubmitted: (value) {
                ref.read(userSearchQueryProvider.notifier).state = value;
              },
            ),
          ],
        ),
      ),
      body: users.when(
        data: (data) {
          return ListView(
            children: [
              ...data.map(
                (user) => Column(
                  children: [
                    InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            child: ListTile(
                              title: Text(user.login ?? "No Username..."),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                        onTap: () {
                          ref.read(reposSearchQueryProvider.notifier).state =
                              user.login!;

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(
                                userDetails: user,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, s) => const Column(
          children: [
            Center(child: Text("No users found")),
            Text("please enter user name to the Search field"),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
