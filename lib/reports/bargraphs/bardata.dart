class IndividualBar {
  int x;
  double y;
  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  late double sunAmount;
  late double monAmount;
  late double tueAmount;
  late double wedAmount;
  late double thurAmount;
  late double friAmount;
  late double satAmount;

  // BarData({
  //   required this.sunAmount,
  //   required this.monAmount,
  //   required this.tueAmount,
  //   required this.wedAmount,
  //   required this.thurAmount,
  //   required this.friAmount,
  //   required this.satAmount,
  // });
  BarData(double sunAmount, double monAmount, double tueAmount,
      double wedAmount, double thurAmount, double friAmount, double satAmount) {
    this.sunAmount = sunAmount;
    this.monAmount = monAmount;
    this.tueAmount = tueAmount;
    this.wedAmount = wedAmount;
    this.thurAmount = thurAmount;
    this.friAmount = friAmount;
    this.satAmount = satAmount;
    initializeBarData();
  }
  List<IndividualBar> barData = [
    // IndividualBar(x: 0, y: 50.0),
  ];
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: sunAmount),
      IndividualBar(x: 1, y: monAmount),
      IndividualBar(x: 2, y: tueAmount),
      IndividualBar(x: 3, y: wedAmount),
      IndividualBar(x: 4, y: thurAmount),
      IndividualBar(x: 5, y: friAmount),
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
