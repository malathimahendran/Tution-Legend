final String baseUrl = 'http://www.cviacserver.tk/tuitionlegend/';

final String chooseBoardCall = baseUrl + 'register/get_boards';
final String gettingClassesCall =
    baseUrl + 'register/get_classes?filter=board_id&data=';
final String registerApiCall = baseUrl + 'register/sign_up';
final String loginApiCall = baseUrl + 'register/sign_in';
final String apiGoogleCall = baseUrl + 'register/google_login';
final String searchApiCall = baseUrl + 'home/class_wise_lectures/title/';
final String getSubjectListApiCall = baseUrl + 'register/get_subjects/';
final String getWishListCall = baseUrl + 'home/wish_list';
final String likeVideoCall = baseUrl + 'home/like';
final String unLikeVideoCall = baseUrl + 'home/dislike';
final String allVideoApiCall = baseUrl + 'home/class_wise_lectures/title/All';
final String getPlanDetailsCall = baseUrl + 'home/get_payment';
final String profileUpdateApiCall = baseUrl + 'home/update_user_profile';
final String planUpdateApiIsExpiredOrNot = baseUrl + 'home/update_active';
final String paymentPostApiCall = baseUrl + 'home/payment';
final String getPaymentApiCall = baseUrl + 'home/get_subscription';
// final String getPlanDetailsCall = baseUrl + 'home/get_payment';
