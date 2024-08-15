import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  const User.empty()
      : this(id: '1', createdAt: '_empty.createdAt', name: '_empty.name');

  final String id;
  final String name;
  final String createdAt;

  @override
  List<Object> get props => [id, name, createdAt];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['username'],
        createdAt: json['createdAt']);
  }
}
