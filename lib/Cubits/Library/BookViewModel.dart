import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Repositories/BookRepository.dart';
import 'package:online_library_management/Repositories/CategoryRepository.dart';

import '../../Models/Responses/BooksByCategoryIdResponse.dart';
import '../States/States.dart';

class BookCubit extends Cubit<States> {
  final CategoryRepository repository;
  final AddBookRepository bookRepository;

  BookCubit(this.repository, this.bookRepository) : super(InitialState());

  List<BooksByCategoryId> booksByCategory = [];
  Map<String, List<BooksByCategoryId>> cachedBooks = {}; // categoryId → books list

  TextEditingController publisherController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController synopsisController = TextEditingController();
  TextEditingController copiesController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController editionController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  File? mainImageFile;             // صورة واحدة فقط
  final ImagePicker _picker = ImagePicker();
  String? mainImageUrl;             // URI الصورة الرئيسية
  String? selectedCategoryId;
  List<File> galleryFiles = [];     // قائمة الصور للمعرض
  String? galleryImageUrl;

  String? mainImageBase64;
  List<String> galleryBase64List = [];


  Future<void> getBookByCategoryId(String categoryId) async {
    emit(LoadingState(loadingMessage: 'Loading..')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await repository.getBookByCategoryId(categoryId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          booksByCategory = success.data?.books ?? [];
          emit(BookByCategoryIdSuccessState(book: booksByCategory));
        }
    );
  }

  Future<void> addBook() async {
    emit(LoadingState(loadingMessage: "Adding book..."));

    // تجهيز فورم الريكويست
    List<String> galleryFormatted = galleryBase64List
        .map((img) => "data:image/png;base64,$img")
        .toList();

    String? mainImageFormatted =
    mainImageBase64 != null ? "data:image/png;base64,$mainImageBase64" : null;

    final request = AddBookRequest(
      name: nameController.text,
      categoryId: selectedCategoryId,
      condition: conditionController.text,
      edition: editionController.text,
      gallery: galleryFormatted,
      language: languageController.text,
      mainImage: mainImageFormatted,
      numberInStock: int.parse(stockController.text),
      numberOfCopies: int.parse(copiesController.text),
      numPages: int.parse(pagesController.text),
      publisher: publisherController.text,
      publishYear: int.parse(yearController.text),
      synopsis: synopsisController.text,
      weight: int.parse(weightController.text),
      writer: writerController.text,
    );

    var either = await bookRepository.addBook(request);

    either.fold(
          (l) => emit(ErrorState(errorMessage: l.error?.message)),
          (response) => emit(AddBookSuccessState(book: response)),
    );
  }

  Future<void> pickMainImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile == null) {
        emit(ErrorState(errorMessage: "لم يتم اختيار أي صورة"));
        return;
      }

      final file = File(pickedFile.path);

      // تحويل لـ Base64
      final bytes = await file.readAsBytes();
      mainImageBase64 = base64Encode(bytes);

      // عشان تعرضيها في الواجهة
      mainImageFile = file;

      emit(MainImagePickedSuccessState(file.path));

    } catch (e) {
      emit(ErrorState(errorMessage: "Error picking main image: $e"));
    }
  }

  Future<void> pickGalleryImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
      );

      if (pickedFiles.isEmpty) return;

      for (var file in pickedFiles) {
        final imageFile = File(file.path);

        // منع تكرار نفس الصورة
        if (galleryFiles.any((f) => f.path == imageFile.path)) continue;

        galleryFiles.add(imageFile);

        final bytes = await imageFile.readAsBytes();
        galleryBase64List.add(base64Encode(bytes));
      }

      emit(GalleryImagesPickedSuccessState(
        galleryFiles.map((f) => f.path).toList(),
      ));
    } catch (e) {
      emit(ErrorState(errorMessage: "Error picking gallery images: $e"));
    }
  }

  void clearMainImage() {
    mainImageFile = null;
    mainImageBase64 = null;
    emit(MainImageClearedState());
  }
  void clearForm() {
    // TextFields
    publisherController.clear();
    writerController.clear();
    nameController.clear();
    synopsisController.clear();
    copiesController.clear();
    stockController.clear();
    yearController.clear();
    editionController.clear();
    languageController.clear();
    conditionController.clear();
    pagesController.clear();
    weightController.clear();

    // Images
    mainImageFile = null;
    mainImageBase64 = null;

    galleryFiles.clear();
    galleryBase64List.clear();

    selectedCategoryId = null;

    emit(BookFormClearedState());
  }


}
