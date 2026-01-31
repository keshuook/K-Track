class TodoItem {
  String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});

  // Convert Object to Map (for JSON)
  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};

  // Create Object from Map
  factory TodoItem.fromJson(Map<String, dynamic> json) => 
      TodoItem(title: json['title'], isDone: json['isDone']);
}