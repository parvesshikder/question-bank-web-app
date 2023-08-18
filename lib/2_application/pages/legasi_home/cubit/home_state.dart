part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

 class HomeInitial extends HomeState {
  
}

 class HomeILoadingState extends HomeState {}

 class HomeMoveToAdminDashboard extends HomeState {
  final String uid;
  final String email;
  final String userType;
  final String name;

  HomeMoveToAdminDashboard({required this.uid, required this.email,required this.userType, required this.name});
}

 class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState({required this.errorMessage});
}

 class HomeRegisterVarification extends HomeState {
  final String status;

  HomeRegisterVarification({required this.status});
}

