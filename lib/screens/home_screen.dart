import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_user_search/model/user_moder/user.dart';
import 'package:github_user_search/providers/data_provider.dart';
import 'package:github_user_search/screens/user_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<User>> users = ref.watch(usersListProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            const Text("Github User"),
            TextField(
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search user nickname...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              controller: controller,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                users = ref.watch(usersListProvider);
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
                      child: ListTile(
                        title: Text(user.login ?? "No Username..."),
                        trailing: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatarUrl ?? ""),
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserDetailsScreen(
                            userDetails: user,
                          ),
                        ),
                      ),
                    ),
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
