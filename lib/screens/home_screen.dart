import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            const Text("Github User Search"),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black45,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                hintText: 'Enter user name:',
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
                              title: Text("${user.login}"),
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
        //
        error: (error, s) => const Column(
          children: [
            Center(child: Text("No users found...")),
            Text("Please enter user name in the Search field"),
          ],
        ),
        //
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
