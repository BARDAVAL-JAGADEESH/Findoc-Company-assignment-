part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photo> photos;

  const PhotosLoaded({required this.photos});

  @override
  List<Object> get props => [photos];
}

class PhotosError extends PhotosState {
  final String message;

  const PhotosError({required this.message});

  @override
  List<Object> get props => [message];
}