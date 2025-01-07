class Task {
  final String? id;
  final String? userId;
  final String? categoryId;
  final String? title;
  final String? description;
  final String? dueDate;
  final String? priority;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? categoryName;

  Task({
    this.id,
    this.userId,
    this.categoryId,
    this.title,
    this.description,
    this.dueDate,
    this.priority,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        userId = json['user_id'] as String?,
        categoryId = json['category_id'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        dueDate = json['due_date'] as String?,
        priority = json['priority'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        categoryName = json['category_name'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'category_id': categoryId,
        'title': title,
        'description': description,
        'due_date': dueDate,
        'priority': priority,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'category_name': categoryName
      };
}
