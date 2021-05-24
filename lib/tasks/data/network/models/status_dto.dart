class StatusDto {
  final String status;
  StatusDto(this.status);
  Map<String, dynamic> toJson() => {'status': this.status};
}
