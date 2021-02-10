// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postsFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postsToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    this.id,
    this.userId,
    this.userName,
    this.name,
    this.detail,
    this.futuresList,
    this.categoryList,
    this.imageList,
    this.reportCount,
    this.address,
    this.showPost,
    this.likeCount,
  });

  int id;
  int userId;
  String userName;
  String name;
  String detail;
  List<dynamic> futuresList;
  List<dynamic> categoryList;
  List<ImageList> imageList;
  int reportCount;
  Address address;
  bool showPost;
  int likeCount;
  int alreadyLiked;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    userId: json["userID"],
    userName: json["userName"],
    name: json["name"],
    detail: json["detail"],
    futuresList: List<dynamic>.from(json["futuresList"].map((x) => x)),
    categoryList: List<dynamic>.from(json["categoryList"].map((x) => x)),
    imageList: List<ImageList>.from(json["imageList"].map((x) => ImageList.fromJson(x))),
    reportCount: json["reportCount"],
    address: Address.fromJson(json["address"]),
    showPost: json["showPost"],
    likeCount: json["likeCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userID": userId,
    "userName": userName,
    "name": name,
    "detail": detail,
    "futuresList": List<dynamic>.from(futuresList.map((x) => x)),
    "categoryList": List<dynamic>.from(categoryList.map((x) => x)),
    "imageList": List<dynamic>.from(imageList.map((x) => x.toJson())),
    "reportCount": reportCount,
    "address": address.toJson(),
    "showPost": showPost,
    "likeCount": likeCount,
  };
}

class Address {
  Address({
    this.id,
    this.addressDto,
    this.detail,
    this.latitude,
    this.longitude,
  });

  int id;
  AddressDto addressDto;
  String detail;
  double latitude;
  double longitude;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    addressDto: AddressDto.fromJson(json["addressDTO"]),
    detail: json["detail"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "addressDTO": addressDto.toJson(),
    "detail": detail,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class AddressDto {
  AddressDto({
    this.id,
    this.countryName,
    this.region,
    this.cityName,
    this.districtName,
    this.plate,
  });

  int id;
  String countryName;
  String region;
  String cityName;
  String districtName;
  int plate;

  factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
    id: json["id"],
    countryName: json["countryName"],
    region: json["region"],
    cityName: json["cityName"],
    districtName: json["districtName"],
    plate: json["plate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "countryName": countryName,
    "region": region,
    "cityName": cityName,
    "districtName": districtName,
    "plate": plate,
  };
}

class ImageList {
  ImageList({
    this.id,
    this.created,
    this.modified,
    this.name,
    this.url,
  });

  int id;
  int created;
  int modified;
  String name;
  String url;

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    id: json["id"],
    created: json["created"],
    modified: json["modified"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created": created,
    "modified": modified,
    "name": name,
    "url": url,
  };
}
