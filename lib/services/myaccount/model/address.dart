
class AddressDetails {
  final String? name;
  final String? location;
  final int? phoneNumber;

  AddressDetails({
    this.name,
    this.location,
    this.phoneNumber,
  });
  static List<AddressDetails> CreateAddressDetailsCard() {
    return [
      AddressDetails(
        name: 'Fatma Alzhraa Esmail',
        location: '18-123 Latona Ave NE, ashington, United states',
        phoneNumber: 01065576124,
      ),
      AddressDetails(
        name: 'Fatma Alzhraa Esmail',
        location: '18-123 Latona Ave NE, ashington, United states',
        phoneNumber: 01065576124,
      ),
      AddressDetails(
        name: 'Fatma Alzhraa Esmail',
        location: '18-123 Latona Ave NE, ashington, United states',
        phoneNumber: 01065576124,
      ),
    ];
  }
}
