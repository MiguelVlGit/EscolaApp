class User {
  final String id;
  final String roleId;
  final String registration;
  final String name;
  final String? period;
  final int? workload;
  final bool status;

  const User({
    required this.id,
    required this.roleId,
    required this.registration,
    required this.name,
    required this.status,
    this.period,
    this.workload,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      roleId: json['role_id']?.toString() ?? '',
      registration: json['registration']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      status: json['status'] is bool ? json['status'] as bool : true,
      period: json['period'] as String?,
      workload: json['workload'] is int ? json['workload'] as int : null,
    );
  }
}
