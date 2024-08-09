import 'package:flutter/material.dart';
import '../services/github_service.dart';

class FollowerScreen extends StatefulWidget {
  final String username;

  FollowerScreen({required this.username});

  @override
  _FollowerScreenState createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  final _githubService = GithubService();
  Map<String, dynamic> _userInfo = {};

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    final userInfo = await _githubService.getUserInfo(widget.username);
    setState(() {
      _userInfo = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Follower Details')),
      body: _userInfo.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(_userInfo['avatar_url']),
                      ),
                      SizedBox(height: 20),
                      _buildInfoRow('Username:', _userInfo['login']),
                      SizedBox(height: 10),
                      _buildInfoRow(
                          'Name:', _userInfo['name'] ?? 'Not available'),
                      SizedBox(height: 10),
                      _buildInfoRow(
                          'Bio:', _userInfo['bio'] ?? 'No bio available'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
