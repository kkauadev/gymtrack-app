import 'package:uuid/uuid.dart';

abstract class Default {
  Default({
    String? id,
    DateTime? createdAt,
    this.deletedAt,
    this.updatedAt,
  }) {
    this.id = id ?? Uuid().v7();
    this.createdAt = createdAt ?? DateTime.now();
  }

  late String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
}
