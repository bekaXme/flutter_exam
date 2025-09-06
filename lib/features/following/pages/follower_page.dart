import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import '../managers/follower_view_model.dart';

class FollowerPage extends StatefulWidget {
  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  final FollowerViewModel _viewModel = FollowerViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text('Followers'),
      ),
      body: ListView.builder(
        itemCount: _viewModel.followers.length,
        itemBuilder: (context, index) {
          final follower = _viewModel.followers[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(follower.avatarUrl),
                ),
                title: Text(follower.name),
                subtitle: Text('@${follower.username}'),
                trailing: Icon(Icons.more_vert),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Manage notifications'),
                          onTap: () {
                            // Handle manage notifications
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.block),
                          title: Text('Block account'),
                          onTap: () {
                            _viewModel.removeFollower(follower.id);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.report),
                          title: Text('Report'),
                          onTap: () {
                            // Handle report
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              if (index == _viewModel.followers.length - 1)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle follow action (example id: 1)
                      _viewModel.follow(1);
                    },
                    child: Text('Follow'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
