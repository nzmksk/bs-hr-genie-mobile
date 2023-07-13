class Holiday {
  Holiday({
    required this.response,
  });
  late final Response response;

  Holiday.fromJson(Map<String, dynamic> json) {
    response = Response.fromJson(json['response']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['response'] = response.toJson();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['holidays'] = holidays.map((e) => e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['description'] = description;
    _data['country'] = country.toJson();
    _data['date'] = date.toJson();
    _data['type'] = type;
    _data['primary_type'] = primaryType;
    _data['canonical_url'] = canonicalUrl;
    _data['urlid'] = urlid;
    _data['locations'] = locations;
    _data['states'] = states;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['iso'] = iso;
    _data['datetime'] = datetime.toJson();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['year'] = year;
    _data['month'] = month;
    _data['day'] = day;
    return _data;
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
  late final Null exception;
  late final String iso;

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbrev = json['abbrev'];
    name = json['name'];
    exception = null;
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['abbrev'] = abbrev;
    _data['name'] = name;
    _data['exception'] = exception;
    _data['iso'] = iso;
    return _data;
  }
}
