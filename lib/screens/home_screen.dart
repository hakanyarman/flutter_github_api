import 'package:flutter/material.dart';
import '../services/github_service.dart';
import 'follower_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _usernameController = TextEditingController();
  final _githubService = GithubService();
  List<dynamic> _followers = [];
  String _currentUsername = '';
  String _errorMessage = '';

  final Color backgroundColor = Colors.grey[100]!;
  final Color cardColor = Colors.grey[300]!;

  void _getFollowers() async {
    setState(() {
      _errorMessage = ''; // Hata mesajını sıfırla
      _followers = []; // Takipçi listesini temizle
      _currentUsername = ''; // Mevcut kullanıcı adını temizle
    });

    if (_usernameController.text.isNotEmpty) {
      try {
        final followers =
            await _githubService.getFollowers(_usernameController.text);
        setState(() {
          _followers = followers;
          _currentUsername = _usernameController.text;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'User not found';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text('GitHub Followers')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Enter GitHub Username to get followers',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _getFollowers,
                ),
                fillColor: Colors.white, // TextField arka plan rengi
                filled: true,
              ),
            ),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          if (_currentUsername.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Followers of $_currentUsername',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _followers.length,
              itemBuilder: (context, index) {
                final follower = _followers[index];
                return Card(
                  color: cardColor,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(follower['avatar_url']),
                    ),
                    title: Text(follower['login']),
                    trailing: ElevatedButton(
                      child: Text('See Details'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FollowerScreen(username: follower['login']),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
