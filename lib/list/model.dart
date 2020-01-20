class Item {
  final int id;

  final String title;

  final String description;

  final String url;

  final bool selected;

  Item(this.id, this.title, this.description, this.url, this.selected);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['id'] as int, json['title'] as String,
        json['description'] as String, json['url'] as String, false);
  }
}

class ListOfItems {
  final List<Item> items;

  final String errorMessage;

  ListOfItems(this.items, this.errorMessage);
}
