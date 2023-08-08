part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  
}

final class HomeILoadingState extends HomeState {}

final class HomeMoveToAdminDashboard extends HomeState {
  final String uid;
  final String email;
  final String userType;
  final String name;

  HomeMoveToAdminDashboard({required this.uid, required this.email,required this.userType, required this.name});
}

final class HomeErrorState extends HomeState {
  final String errorMesssage;

  HomeErrorState({required this.errorMesssage});
}

final class HomeRegisterVarification extends HomeState {
  final String status;

  HomeRegisterVarification({required this.status});
}

