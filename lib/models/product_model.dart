class ProductModel {
  String? docId;
  String? subcatId;
  String? catId;
  String? userId;
  List? image;
  String? productName;
  String? productCondition;
  String? startPrice;
  String? percentage;
  String? discountPrice;
  String? bidEndDate;
  String? bidEndTime;
  String? location;
  String? phone;
  String? description;
  String? productQty;
  String? moreSpec;
  bool? isApproved = false;
  bool? isBid = false;

  ProductModel({
    this.subcatId,
    this.catId,
    this.userId,
    this.productName,
    this.image,
    this.productCondition,
    this.startPrice,
    this.percentage,
    this.discountPrice,
    this.bidEndDate,
    this.bidEndTime,
    this.location,
    this.phone,
    this.description,
    this.productQty,
    this.moreSpec,
    this.isApproved,
    this.isBid,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    userId = json['userId'];
    subcatId = json['subcatId'];
    catId = json['catId'];
    productName = json['productName'];
    image = json['image'];
    productCondition = json['productCondition'];
    startPrice = json['startPrice'];
    percentage = json['percentage'];
    discountPrice = json['discountPrice'];
    bidEndDate = json['bidEndDate'];
    bidEndTime = json['bidEndTime'];
    location = json['location'];
    phone = json['phone'];
    description = json['description'];
    productQty = json['productQty'];
    moreSpec = json['moreSpec'];
    isApproved = json['isApproved'];
    isBid = json['isBid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['docId'] = docId;
    data['userId'] = userId;
    data['subcatId'] = subcatId;
    data['catId'] = catId;
    data['productName'] = productName;
    data['image'] = image;
    data['productCondition'] = productCondition;
    data['startPrice'] = startPrice;
    data['percentage'] = percentage;
    data['discountPrice'] = discountPrice;
    data['bidEndDate'] = bidEndDate;
    data['bidEndTime'] = bidEndTime;
    data['location'] = location;
    data['phone'] = phone;
    data['description'] = description;
    data['productQty'] = productQty;
    data['moreSpec'] = moreSpec;
    data['isApproved'] = isApproved;
    data['isBid'] = isBid;
    return data;
  }
}
