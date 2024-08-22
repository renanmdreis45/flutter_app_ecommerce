import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,

  });

  const User.empty()
      : this(id: '', name: '', email: '');

  final String id;
  final String email;
  final String name;

  @override
  List<Object> get props => [id, email, name];
}
