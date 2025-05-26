class ProductModel {
  String? docId;
  String? subcatId;
  String? catId;
  String? userId;
  String? username;
  List? image;
  String? productName;
  String? productCondition;
  String? categoryName;
  String? subcategoryName;
  String? startPrice;
  // String? percentage;
  // String? discountPrice;
  String? bidEndDate;
  String? bidEndTime;
  String? location;
  String? phone;
  String? description;
  // String? productQty;
  String? moreSpec;
  bool? isApproved = false;
  bool? status = false;
  bool? isBid = false;

  ProductModel({
    this.subcatId,
    this.catId,
    this.userId,
    this.username,
    this.productName,
    this.image,
    this.productCondition,
    this.startPrice,
    this.categoryName,
    this.subcategoryName,
    // this.percentage,
    // this.discountPrice,
    this.bidEndDate,
    this.bidEndTime,
    this.location,
    this.phone,
    this.description,
    // this.productQty,
    this.moreSpec,
    this.isApproved,
    this.status,
    this.isBid,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    userId = json['userId'];
    username = json['username'];
    subcatId = json['subcatId'];
    catId = json['catId'];
    productName = json['productName'];
    image = json['image'];
    productCondition = json['productCondition'];
    startPrice = json['startPrice'];
    categoryName = json['categoryName'];
    subcategoryName = json['subcategoryName'];
    // percentage = json['percentage'];
    // discountPrice = json['discountPrice'];
    bidEndDate = json['bidEndDate'];
    bidEndTime = json['bidEndTime'];
    location = json['location'];
    phone = json['phone'];
    description = json['description'];
    // productQty = json['productQty'];
    moreSpec = json['moreSpec'];
    isApproved = json['isApproved'];
    status = json['status'];
    isBid = json['isBid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['docId'] = docId;
    data['userId'] = userId;
    data['username'] = username;
    data['subcatId'] = subcatId;
    data['catId'] = catId;
    data['productName'] = productName;
    data['image'] = image;
    data['productCondition'] = productCondition;
    data['startPrice'] = startPrice;
    data['subcategoryName'] = subcategoryName;
    data['categoryName'] = categoryName;
    // data['percentage'] = percentage;
    // data['discountPrice'] = discountPrice;
    data['bidEndDate'] = bidEndDate;
    data['bidEndTime'] = bidEndTime;
    data['location'] = location;
    data['phone'] = phone;
    data['description'] = description;
    // data['productQty'] = productQty;
    data['moreSpec'] = moreSpec;
    data['isApproved'] = isApproved;
    data['status'] = status;
    data['isBid'] = isBid;
    return data;
  }

    factory ProductModel.empty() {
    return ProductModel(
      // docId: '',
      userId: '',
      username: '',
      subcatId: '',
      catId: '',
      productName: '',
      image: [],
      productCondition: '',
      phone: '',
      startPrice: "",
      subcategoryName: '',
      categoryName: '',
      // percentage: "",
      // discountPrice: "",
      bidEndDate: "",
      bidEndTime: "",
      location: "",
      // productQty:"",
      description: "",
      moreSpec: "",
      status: false,
      isApproved: false,
      isBid: false,
    );
  }
}
