class Holiday {
  Holiday({
    required this.response,
  });
  late final Response response;

  Holiday.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['response'] = response.toJson();
    return data;
  }
}

class Response {
  Response({
    required this.holidays,
  });
  late final List<Holidays> holidays;

  Response.fromJson(Map<String, dynamic> json) {
    holidays =
        List.from(json['holidays']).map((e) => Holidays.fromJson(e)).toList();
  }

  get statusCode => null;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['holidays'] = holidays.map((e) => e.toJson()).toList();
    return data;
  }
}

class Holidays {
  Holidays({
    required this.name,
    required this.description,
    required this.country,
    required this.date,
    required this.type,
    required this.primaryType,
    required this.canonicalUrl,
    required this.urlid,
    required this.locations,
    required this.states,
  });
  late final String name;
  late final String description;
  late final Country country;
  late final Date date;
  late final List<String> type;
  late final String primaryType;
  late final String canonicalUrl;
  late final String urlid;
  late final String locations;
  late final List<States> states;

  Holidays.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    country = Country.fromJson(json['country']);
    date = Date.fromJson(json['date']);
    type = List.castFrom<dynamic, String>(json['type']);
    primaryType = json['primary_type'];
    canonicalUrl = json['canonical_url'];
    urlid = json['urlid'];
    locations = json['locations'];
    states = json['states'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['country'] = country.toJson();
    data['date'] = date.toJson();
    data['type'] = type;
    data['primary_type'] = primaryType;
    data['canonical_url'] = canonicalUrl;
    data['urlid'] = urlid;
    data['locations'] = locations;
    data['states'] = states;
    return data;
  }
}

class Country {
  Country({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Date {
  Date({
    required this.iso,
    required this.datetime,
  });
  late final String iso;
  late final Datetime datetime;

  Date.fromJson(Map<String, dynamic> json) {
    iso = json['iso'];
    datetime = Datetime.fromJson(json['datetime']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso'] = iso;
    data['datetime'] = datetime.toJson();
    return data;
  }
}

class Datetime {
  Datetime({
    required this.year,
    required this.month,
    required this.day,
  });
  late final int year;
  late final int month;
  late final int day;

  Datetime.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}

class States {
  States({
    required this.id,
    required this.abbrev,
    required this.name,
    this.exception,
    required this.iso,
  });
  late final int id;
  late final String abbrev;
  late final String name;
  late final void exception;
  late final String iso;

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbrev = json['abbrev'];
    name = json['name'];
    exception = null;
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['abbrev'] = abbrev;
    data['name'] = name;
    data['exception'] = exception;
    data['iso'] = iso;
    return data;
  }
}
