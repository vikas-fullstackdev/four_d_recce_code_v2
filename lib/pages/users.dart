// import 'package:flutter/material.dart';
// import '/backend/supabase/supabase.dart';
// import 'user_chat_page.dart';

// class UsersWidget extends StatefulWidget {
// 	const UsersWidget({Key? key}) : super(key: key);

// 	@override
// 	State<UsersWidget> createState() => _UsersWidgetState();
// }

// class _UsersWidgetState extends State<UsersWidget> {
// 	@override
// 	Widget build(BuildContext context) {
// 		return Scaffold(
// 			appBar: AppBar(title: const Text('Users')),
// 			body: FutureBuilder<List<UsersRow>>(
// 				future: UsersTable().queryRows(),
// 				builder: (context, snapshot) {
// 					if (snapshot.connectionState != ConnectionState.done) {
// 						return const Center(child: CircularProgressIndicator());
// 					}
// 					if (snapshot.hasError) {
// 						return Center(child: Text('Error: ${snapshot.error}'));
// 					}
// 					final users = snapshot.data ?? [];
// 					if (users.isEmpty) {
// 						return const Center(child: Text('No users found'));
// 					}
// 					return ListView.separated(
// 						itemCount: users.length,
// 						separatorBuilder: (_, __) => const Divider(height: 1),
// 						itemBuilder: (context, index) {
// 							final u = users[index];
// 							final profile = {
// 								'userId': u.userid ?? '',
// 								'name': u.name ?? '',
// 							};
// 							return ListTile(
// 								title: Text(u.name ?? 'Unnamed'),
// 								subtitle: Text(u.email ?? ''),
// 								onTap: () {
// 									Navigator.push(
// 										context,
// 										MaterialPageRoute(
// 											builder: (_) => UserChatPage(profile: profile),
// 										),
// 									);
// 								},
// 							);
// 						},
// 					);
// 				},
// 			),
// 		);
// 	}
// }

import 'package:flutter/material.dart';
import '/backend/supabase/supabase.dart';
import 'user_chat_page.dart';

class UsersWidget extends StatefulWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<UsersRow>>(
        future: UsersTable().queryRows(
          queryFn: (q) => q, // ✅ REQUIRED
        ),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final users = snapshot.data ?? [];

          // Empty state
          if (users.isEmpty) {
            return const Center(
              child: Text('No users found'),
            );
          }

          // User list
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final user = users[index];

              final profile = {
                'userId': user.userid ?? '',
                'name': user.name ?? '',
                'email': user.email ?? '',
              };

              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(user.name ?? 'Unnamed'),
                subtitle: Text(user.email ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserChatPage(profile: profile),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
