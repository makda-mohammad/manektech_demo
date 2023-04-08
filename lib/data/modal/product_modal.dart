class ProductModal {
  int id;
  String slug;
  String title;
  String description;
  int price;
  String featuredImage;
  String status;
  String createdAt;

  ProductModal(this.id, this.slug, this.title, this.description, this.price, this.featuredImage, this.status, this.createdAt);

  factory ProductModal.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String slug = json['slug'];
    String title = json['title'];
    String description = json['description'];
    int price = json['price'];
    String featuredImage = json['featured_image'];
    String status = json['status'];
    String createdAt = json['created_at'];
    return ProductModal(id, slug, title, description, price, featuredImage, status, createdAt);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['description'] = description;
    map['price'] = price;
    map['featured_image'] = featuredImage;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }
}
