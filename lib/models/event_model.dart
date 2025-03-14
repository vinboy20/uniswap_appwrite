class EventModel {
  String? docId;
  String? userId;
  List? image;
  String? name;
  String? owner;
  String? price;
  String? quantity;
  String? percentage;
  String? discountPrice;
  String? startTime;
  String? endTime;
  String? date;
  String? location;
  String? phone;
  String? description;
  String? ticketType;
  String? eventType;
  bool? isApproved = false;

  EventModel({
    this.docId,
    this.userId,
    this.image,
    this.name,
    this.owner,
    this.price,
    this.quantity,
    this.percentage,
    this.discountPrice,
    this.startTime,
    this.endTime,
    this.date,
    this.location,
    this.phone,
    this.description,
    this.ticketType,
    this.eventType,
    this.isApproved,
  });

  EventModel.fromJson(Map<String, dynamic> json) {
    docId = json['\$id'];
    userId = json['userId'];
    owner = json['owner'];
    name = json['name'];
    image = json['image'];
    ticketType = json['ticketType'];
    price = json['price'];
    percentage = json['percentage'];
    discountPrice = json['discountPrice'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    location = json['location'];
    phone = json['phone'];
    description = json['description'];
    quantity = json['quantity'];
    eventType = json['eventType'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['docId'] = docId;
    data['userId'] = userId;
    data['owner'] = owner;
    data['name'] = name;
    data['image'] = image;
    data['ticketType'] = ticketType;
    data['price'] = price;
    data['percentage'] = percentage;
    data['discountPrice'] = discountPrice;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['date'] = date;
    data['location'] = location;
    data['phone'] = phone;
    data['description'] = description;
    data['quantity'] = quantity;
    data['eventType'] = eventType;
    data['isApproved'] = isApproved;
    return data;
  }
}
