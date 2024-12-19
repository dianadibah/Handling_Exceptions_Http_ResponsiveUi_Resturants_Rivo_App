// To parse this JSON data, do
//
//     final resturantsResponse = resturantsResponseFromJson(jsonString);

import 'dart:convert';

ResturantsResponse resturantsResponseFromJson(String str) => ResturantsResponse.fromJson(json.decode(str));

String resturantsResponseToJson(ResturantsResponse data) => json.encode(data.toJson());

class ResturantsResponse {
    bool? success;
    String? message;
    Data? data;

    ResturantsResponse({
        this.success,
        this.message,
        this.data,
    });

    ResturantsResponse copyWith({
        bool? success,
        String? message,
        Data? data,
    }) => 
        ResturantsResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory ResturantsResponse.fromJson(Map<String, dynamic> json) => ResturantsResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    List<Resturant>? resturants;
    int? total;

    Data({
        this.resturants,
        this.total,
    });

    Data copyWith({
        List<Resturant>? resturants,
        int? total,
    }) => 
        Data(
            resturants: resturants ?? this.resturants,
            total: total ?? this.total,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        resturants: json["resturants"] == null ? [] : List<Resturant>.from(json["resturants"]!.map((x) => Resturant.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "resturants": resturants == null ? [] : List<dynamic>.from(resturants!.map((x) => x.toJson())),
        "total": total,
    };
}

class Resturant {
    int? id;
    String? name;
    String? color;
    BannerImage? bannerImage;

    Resturant({
        this.id,
        this.name,
        this.color,
        this.bannerImage,
    });

    Resturant copyWith({
        int? id,
        String? name,
        String? color,
        BannerImage? bannerImage,
    }) => 
        Resturant(
            id: id ?? this.id,
            name: name ?? this.name,
            color: color ?? this.color,
            bannerImage: bannerImage ?? this.bannerImage,
        );

    factory Resturant.fromJson(Map<String, dynamic> json) => Resturant(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        bannerImage: json["banner_image"] == null ? null : BannerImage.fromJson(json["banner_image"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "banner_image": bannerImage?.toJson(),
    };
}

class BannerImage {
    int? id;
    String? mediaUrl;
    String? thumbUrl;
    int? mediaType;
    String? hash;
    int? order;

    BannerImage({
        this.id,
        this.mediaUrl,
        this.thumbUrl,
        this.mediaType,
        this.hash,
        this.order,
    });

    BannerImage copyWith({
        int? id,
        String? mediaUrl,
        String? thumbUrl,
        int? mediaType,
        String? hash,
        int? order,
    }) => 
        BannerImage(
            id: id ?? this.id,
            mediaUrl: mediaUrl ?? this.mediaUrl,
            thumbUrl: thumbUrl ?? this.thumbUrl,
            mediaType: mediaType ?? this.mediaType,
            hash: hash ?? this.hash,
            order: order ?? this.order,
        );

    factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        id: json["id"],
        mediaUrl: json["media_url"],
        thumbUrl: json["thumb_url"],
        mediaType: json["media_type"],
        hash: json["hash"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "media_url": mediaUrl,
        "thumb_url": thumbUrl,
        "media_type": mediaType,
        "hash": hash,
        "order": order,
    };
}
