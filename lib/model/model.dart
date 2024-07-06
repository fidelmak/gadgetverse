class ShopData {
  int page;
  int size;
  int total;

  dynamic previousPage;
  dynamic nextPage;
  List<Item> items;

  ShopData({
    required this.page,
    required this.size,
    required this.total,
    this.previousPage,
    this.nextPage,
    required this.items,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) {
    return ShopData(
      page: json['page'],
      size: json['size'],
      total: json['total'],
      previousPage: json['previous_page'],
      nextPage: json['next_page'],
      items: List<Item>.from(json['items'].map((item) => Item.fromJson(item))),
    );
  }
}

class Item {
  String name;
  String? description;
  String uniqueId;
  String urlSlug;
  bool isAvailable;
  bool isService;
  dynamic previousUrlSlugs;
  bool unavailable;
  dynamic unavailableStart;
  dynamic unavailableEnd;
  String id;
  dynamic parentProductId;
  dynamic parent;
  String organizationId;
  dynamic stockId;
  List<dynamic> productImage;
  List<dynamic> categories;
  String dateCreated;
  String lastUpdated;
  String userId;
  List<Photo> photos;
  dynamic prices;
  dynamic stocks;
  List<Map<String, dynamic>> currentPrice;
  bool isDeleted;
  dynamic availableQuantity;
  dynamic sellingPrice;
  dynamic discountedPrice;
  dynamic buyingPrice;
  dynamic extraInfos;
  dynamic featuredReviews;
  List<dynamic> unavailability;

  Item({
    required this.name,
    this.description,
    required this.uniqueId,
    required this.urlSlug,
    required this.isAvailable,
    required this.isService,
    this.previousUrlSlugs,
    required this.unavailable,
    this.unavailableStart,
    this.unavailableEnd,
    required this.id,
    this.parentProductId,
    this.parent,
    required this.organizationId,
    this.stockId,
    required this.productImage,
    required this.categories,
    required this.dateCreated,
    required this.lastUpdated,
    required this.userId,
    required this.photos,
    this.prices,
    this.stocks,
    required this.currentPrice,
    required this.isDeleted,
    this.availableQuantity,
    this.sellingPrice,
    this.discountedPrice,
    this.buyingPrice,
    this.extraInfos,
    this.featuredReviews,
    required this.unavailability,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'],
      uniqueId: json['unique_id'],
      urlSlug: json['url_slug'],
      isAvailable: json['is_available'],
      isService: json['is_service'],
      previousUrlSlugs: json['previous_url_slugs'],
      unavailable: json['unavailable'],
      unavailableStart: json['unavailable_start'],
      unavailableEnd: json['unavailable_end'],
      id: json['id'],
      parentProductId: json['parent_product_id'],
      parent: json['parent'],
      organizationId: json['organization_id'],
      stockId: json['stock_id'],
      productImage: List<dynamic>.from(json['product_image']),
      categories: List<dynamic>.from(json['categories']),
      dateCreated: json['date_created'],
      lastUpdated: json['last_updated'],
      userId: json['user_id'],
      photos: List<Photo>.from(
          json['photos'].map((photo) => Photo.fromJson(photo))),
      prices: json['prices'],
      stocks: json['stocks'],
      currentPrice: List<Map<String, dynamic>>.from(json['current_price']),
      isDeleted: json['is_deleted'],
      availableQuantity: json['available_quantity'],
      sellingPrice: json['selling_price'],
      discountedPrice: json['discounted_price'],
      buyingPrice: json['buying_price'],
      extraInfos: json['extra_infos'],
      featuredReviews: json['featured_reviews'],
      unavailability: List<dynamic>.from(json['unavailability']),
    );
  }
}

class Photo {
  String modelName;
  String modelId;
  String organizationId;
  String filename;
  String url;
  bool isFeatured;
  bool saveAsJpg;
  bool isPublic;
  bool fileRename;
  int position;

  Photo({
    required this.modelName,
    required this.modelId,
    required this.organizationId,
    required this.filename,
    required this.url,
    required this.isFeatured,
    required this.saveAsJpg,
    required this.isPublic,
    required this.fileRename,
    required this.position,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      modelName: json['model_name'],
      modelId: json['model_id'],
      organizationId: json['organization_id'],
      filename: json['filename'],
      url: json['url'],
      isFeatured: json['is_featured'],
      saveAsJpg: json['save_as_jpg'],
      isPublic: json['is_public'],
      fileRename: json['file_rename'],
      position: json['position'],
    );
  }
}
