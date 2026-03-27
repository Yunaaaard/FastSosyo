class BrandCategory {
  final String brand;
  final String image;
  final String logo;
  final String amount;
  final String count;

  const BrandCategory({
    required this.brand,
    required this.image,
    required this.logo,
    required this.amount,
    required this.count,
  });

  factory BrandCategory.empty() {
    return const BrandCategory(
      brand: '',
      image: '',
      logo: '',
      amount: '0.00',
      count: '0',
    );
  }

}
