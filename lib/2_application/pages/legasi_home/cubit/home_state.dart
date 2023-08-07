part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeILoadingState extends HomeState {}

final class HomeMoveToAdminDashboard extends HomeState {
  final String uid;
  final String email;

  HomeMoveToAdminDashboard({required this.uid, required this.email});
}

final class HomeErrorState extends HomeState {
  final String errorMesssage;

  HomeErrorState({required this.errorMesssage});
}
