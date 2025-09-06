class Follower {
  final int id;
  final String name;
  final String username;
  final String avatarUrl;

  Follower({required this.id, required this.name, required this.username, required this.avatarUrl});

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      avatarUrl: json['avatar_url'],
    );
  }
}