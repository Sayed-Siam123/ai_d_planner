abstract class AppRoutes {
  AppRoutes._();

  static const splash = _Paths.splash;
  static const authentication = _Paths.authentication;
  static const otpVerification = _Paths.otpVerification;
  static const installmentPayment = _Paths.installmentPayment;
  static const beneficiaryManagementCreate = _Paths.beneficiaryManagementCreate;
  static const beneficiaryManagementList = _Paths.beneficiaryManagementList;

  static const dashboard = _Paths.dashboard;
  static const homeBottomNav = _Paths.homeBottomNav;
  static const settingsBottomNav = _Paths.settingsBottomNav;

  static const beneficiaryBottomNav = _Paths.beneficiaryBottomNav;
  static const transactionBottomNav = _Paths.transactionBottomNav;
  static const notification = _Paths.notification;
  static const notificationDetails = _Paths.notificationDetails;
  static const balanceInquiry = _Paths.balanceInquiry;
  static const statement = _Paths.statement;
  static const statementDetails = _Paths.statementDetails;
  static const calculateRate = _Paths.calculateRate;
  static const branchLocation = _Paths.branchLocation;
  static const profilePage = _Paths.profilePage;

  static const balanceTransferInitial = _Paths.balanceTransferInitial;
  static const balanceTransferAnother = _Paths.balanceTransferAnother;
  static const balanceTransferOwn = _Paths.balanceTransferOwn;
  static const balanceTransferSaveBeneficiary = _Paths.balanceTransferSaveBeneficiary;
  static const balanceTransferCompletePage = _Paths.balanceTransferCompletePage;
  static const fundTransfer = _Paths.fundTransfer;
}

abstract class _Paths {
  _Paths._();

  static const splash = '/splash';
  static const authentication = '/authentication';
  static const otpVerification = '/otpVerification';
  static const installmentPayment = '/installmentPayment';
  static const beneficiaryManagementCreate = '/beneficiaryManagementCreate';
  static const beneficiaryManagementList = '/beneficiaryManagementList';

  static const dashboard = '/dashboard';
  static const homeBottomNav = '/homeBottomNav';
  static const profilePage = '/profile';
  static const settingsBottomNav = '/settingsBottomNav';
  static const beneficiaryBottomNav = '/beneficiaryBottomNav';
  static const transactionBottomNav = '/transactionBottomNav';
  static const notification = '/notification';
  static const notificationDetails = '/notificationDetails';
  static const balanceInquiry = '/balanceInquiry';
  static const statement = '/statement';
  static const statementDetails = '/statementDetails';
  static const calculateRate = '/calculateRate';
  static const branchLocation = '/branch-location';

  static const balanceTransferInitial = '/balanceTransferInitial';
  static const balanceTransferAnother = '/balanceTransferAnother';
  static const balanceTransferOwn = '/balanceTransferOwn';
  static const balanceTransferSaveBeneficiary = '/balanceTransferSaveBeneficiary';
  static const balanceTransferCompletePage = '/balanceTransferCompletePage';

  static const fundTransfer = '/fundTransfer';
}