class InvestmentType {
  static final List<String> stocks = [
    "AOT.BK",
    "SCC.BK",
    "CPALL.BK",
    "SCB.BK",
    "BBL.BK",
    "NIO",
    "AMD",
    "AAPL",
    "TSLA",
    "F",
  ];

  static final List<String> crypto = [
    "BTC-USD",
    "ETH-USD",
    "USDT-USD",
    "BNB-USD",
    "ADA-USD",
    "DOGE-USD",
    "XRP-USD",
    "USDC-USD",
    "BCH-USD",
    "HEX-USD",
  ];

  static final List<String> funds = [
    "JLVMX",
    "JLVZX",
    "OLVCX",
    "OLVAX",
    "MSGAX",
    "HFMDX",
    "MSGCX",
    "FEGOX",
    "PFPFX",
    "IPFPX",
  ];

  static final List<String> investmentType = [
    ...stocks,
    ...crypto,
    ...funds,
  ];

  static List<String> getInvestmentTypeList(String query) =>
      List.of(investmentType).where((investmentType) {
        final investmentTypeUpper = investmentType.toUpperCase();
        final queryUpper = query.toUpperCase();

        return investmentTypeUpper.contains(queryUpper);
      }).toList();
}
