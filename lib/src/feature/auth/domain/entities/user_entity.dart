class UserEntity {
  final String fullName;
  final String email;
  final String password;
  final String profilePhote;

  UserEntity({
    this.fullName = '',
    required this.email,
    this.password = '',
    this.profilePhote = '',
  });
}
