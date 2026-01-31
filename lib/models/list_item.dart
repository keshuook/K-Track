class KListItem {
  String name;
  String id;

  KListItem({required this.name, required this.id});

  // Convert Object to Map (for JSON)
  Map<String, dynamic> toJson() => {'name': name, 'id': id};

  // Create JSON Object from Map
  factory KListItem.fromJson(Map<String, dynamic> json) => 
      KListItem(name: json['name'], id: json['id']);
}