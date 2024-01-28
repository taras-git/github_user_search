import 'package:flutter/material.dart';
import 'package:github_user_search/model/user_moder/user.dart';

class UserDetailsScreen extends StatelessWidget {
  final User userDetails;

  const UserDetailsScreen({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                maxRadius: 100,
                backgroundImage:
                    NetworkImage(userDetails.avatarUrl ?? "Image error..."),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "User Name :  ${userDetails.login}",
            ),
            Text("User Type : ${userDetails.type}"),
            Text(
              "ID : ${userDetails.id}",
            ),
          ],
        ),
      ),
    );
  }
}
