enum PageRouteType {pushNamed,pushReplacement,popped,goNamed}

class PageRouteArg{
  final dynamic pageData;
  final String? from;
  final String? to;
  final bool? isFromDashboardNav, isBackAction;

  final PageRouteType? pageRouteType;

  PageRouteArg({this.pageData,this.from = "",this.to = "",this.pageRouteType,this.isFromDashboardNav = true,this.isBackAction = false});

}