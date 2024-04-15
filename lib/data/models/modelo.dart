class Trip {
  final int id;
  final String name;
  final String date;
  final String status;
  final Facility facility;
  final Vehicle vehicle;
  final Responsible responsible;

  Trip({
    required this.id,
    required this.name,
    required this.date,
    required this.status,
    required this.facility,
    required this.vehicle,
    required this.responsible,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      name: json['name'],
      date: json['date'],
      status: json['status'],
      facility: Facility.fromJson(json['facility']),
      vehicle: Vehicle.fromJson(json['vehicle']),
      responsible: Responsible.fromJson(json['responsible']),
    );
  }
}

class Facility {
  final int id;
  final String name;
  final String phone;
  final String address;

  Facility({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}

class Vehicle {
  final int id;
  final String economicNumber;
  final String plates;
  final String brand;
  final String model;
  final String year;

  Vehicle({
    required this.id,
    required this.economicNumber,
    required this.plates,
    required this.brand,
    required this.model,
    required this.year,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      economicNumber: json['economic_number'],
      plates: json['plates'],
      brand: json['brand'],
      model: json['modelo'],
      year: json['year'],
    );
  }
}

class Responsible {
  final int id;
  final String name;
  final String phone;
  final String address;

  Responsible({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory Responsible.fromJson(Map<String, dynamic> json) {
    return Responsible(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
