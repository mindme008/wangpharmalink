class PatientData {
  final int patientId;
  final int patientCode;
  final String name;

  PatientData ({this.patientId, this.patientCode, this.name});

  factory PatientData .fromJson(Map<String, dynamic> json) {
    return PatientData (
      patientId: json['patient_id'],
      patientCode: json['patient_code'],
      name: json['pti_firstname'],
    );
  }
}