// To parse this JSON data, do
//
//     final suscriptionResponse = suscriptionResponseFromJson(jsonString);

import 'dart:convert';

SuscriptionResponse suscriptionResponseFromJson(String str) => SuscriptionResponse.fromJson(json.decode(str));

String suscriptionResponseToJson(SuscriptionResponse data) => json.encode(data.toJson());

class SuscriptionResponse {
  final String? identifier;
  final String? serverDescription;
  final Metadata? metadata;
  final List<Annual>? availablePackages;
  final dynamic lifetime;
  final Annual? annual;
  final dynamic sixMonth;
  final dynamic threeMonth;
  final dynamic twoMonth;
  final Annual? monthly;
  final dynamic weekly;

  SuscriptionResponse({
    this.identifier,
    this.serverDescription,
    this.metadata,
    this.availablePackages,
    this.lifetime,
    this.annual,
    this.sixMonth,
    this.threeMonth,
    this.twoMonth,
    this.monthly,
    this.weekly,
  });

  factory SuscriptionResponse.fromJson(Map<String, dynamic> json) => SuscriptionResponse(
    identifier: json["identifier"],
    serverDescription: json["serverDescription"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    availablePackages: json["availablePackages"] == null ? [] : List<Annual>.from(json["availablePackages"]!.map((x) => Annual.fromJson(x))),
    lifetime: json["lifetime"],
    annual: json["annual"] == null ? null : Annual.fromJson(json["annual"]),
    sixMonth: json["sixMonth"],
    threeMonth: json["threeMonth"],
    twoMonth: json["twoMonth"],
    monthly: json["monthly"] == null ? null : Annual.fromJson(json["monthly"]),
    weekly: json["weekly"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "serverDescription": serverDescription,
    "metadata": metadata?.toJson(),
    "availablePackages": availablePackages == null ? [] : List<dynamic>.from(availablePackages!.map((x) => x.toJson())),
    "lifetime": lifetime,
    "annual": annual?.toJson(),
    "sixMonth": sixMonth,
    "threeMonth": threeMonth,
    "twoMonth": twoMonth,
    "monthly": monthly?.toJson(),
    "weekly": weekly,
  };
}

class Annual {
  final String? identifier;
  final String? packageType;
  final Product? product;
  final PresentedOfferingContext? presentedOfferingContext;

  Annual({
    this.identifier,
    this.packageType,
    this.product,
    this.presentedOfferingContext,
  });

  factory Annual.fromJson(Map<String, dynamic> json) => Annual(
    identifier: json["identifier"],
    packageType: json["packageType"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    presentedOfferingContext: json["presentedOfferingContext"] == null ? null : PresentedOfferingContext.fromJson(json["presentedOfferingContext"]),
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "packageType": packageType,
    "product": product?.toJson(),
    "presentedOfferingContext": presentedOfferingContext?.toJson(),
  };
}

class PresentedOfferingContext {
  final String? offeringIdentifier;
  final dynamic placementIdentifier;
  final dynamic targetingContext;

  PresentedOfferingContext({
    this.offeringIdentifier,
    this.placementIdentifier,
    this.targetingContext,
  });

  factory PresentedOfferingContext.fromJson(Map<String, dynamic> json) => PresentedOfferingContext(
    offeringIdentifier: json["offeringIdentifier"],
    placementIdentifier: json["placementIdentifier"],
    targetingContext: json["targetingContext"],
  );

  Map<String, dynamic> toJson() => {
    "offeringIdentifier": offeringIdentifier,
    "placementIdentifier": placementIdentifier,
    "targetingContext": targetingContext,
  };
}

class Product {
  final String? identifier;
  final String? description;
  final String? title;
  final double? price;
  final String? priceString;
  final String? currencyCode;
  final IntroPrice? introPrice;
  final List<dynamic>? discounts;
  final String? productCategory;
  final dynamic defaultOption;
  final dynamic subscriptionOptions;
  final dynamic presentedOfferingContext;
  final String? subscriptionPeriod;

  Product({
    this.identifier,
    this.description,
    this.title,
    this.price,
    this.priceString,
    this.currencyCode,
    this.introPrice,
    this.discounts,
    this.productCategory,
    this.defaultOption,
    this.subscriptionOptions,
    this.presentedOfferingContext,
    this.subscriptionPeriod,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    identifier: json["identifier"],
    description: json["description"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    priceString: json["priceString"],
    currencyCode: json["currencyCode"],
    introPrice: json["introPrice"] == null ? null : IntroPrice.fromJson(json["introPrice"]),
    discounts: json["discounts"] == null ? [] : List<dynamic>.from(json["discounts"]!.map((x) => x)),
    productCategory: json["productCategory"],
    defaultOption: json["defaultOption"],
    subscriptionOptions: json["subscriptionOptions"],
    presentedOfferingContext: json["presentedOfferingContext"],
    subscriptionPeriod: json["subscriptionPeriod"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "description": description,
    "title": title,
    "price": price,
    "priceString": priceString,
    "currencyCode": currencyCode,
    "introPrice": introPrice?.toJson(),
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x)),
    "productCategory": productCategory,
    "defaultOption": defaultOption,
    "subscriptionOptions": subscriptionOptions,
    "presentedOfferingContext": presentedOfferingContext,
    "subscriptionPeriod": subscriptionPeriod,
  };
}

class IntroPrice {
  final int? price;
  final String? priceString;
  final String? period;
  final int? cycles;
  final String? periodUnit;
  final int? periodNumberOfUnits;

  IntroPrice({
    this.price,
    this.priceString,
    this.period,
    this.cycles,
    this.periodUnit,
    this.periodNumberOfUnits,
  });

  factory IntroPrice.fromJson(Map<String, dynamic> json) => IntroPrice(
    price: json["price"],
    priceString: json["priceString"],
    period: json["period"],
    cycles: json["cycles"],
    periodUnit: json["periodUnit"],
    periodNumberOfUnits: json["periodNumberOfUnits"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "priceString": priceString,
    "period": period,
    "cycles": cycles,
    "periodUnit": periodUnit,
    "periodNumberOfUnits": periodNumberOfUnits,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}
