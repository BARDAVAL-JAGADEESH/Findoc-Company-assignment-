import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/api_client.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/photos/photos_bloc.dart';
import '../models/photo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          PhotosBloc(apiClient: ApiClient())..add(FetchPhotosEvent()),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBar(
                backgroundColor: Colors.white.withOpacity(0.1),
                elevation: 0,
                title: Text(
                  'Gallery',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,  // Semi-Bold
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4A00E0),
                Color(0xFF8E2DE2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<PhotosBloc, PhotosState>(
              builder: (context, state) {
                if (state is PhotosLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PhotosError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (state is PhotosLoaded) {
                  return _buildPhotoList(state.photos);
                }
                return const Center(
                  child: Text(
                    'No photos to display',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoList(List<Photo> photos) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: photo.downloadUrl,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, size: 48),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / photo.aspectRatio,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Photo by ${photo.author}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600, // Semi-Bold
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${photo.width} × ${photo.height}',
                      style: GoogleFonts.montserrat(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
