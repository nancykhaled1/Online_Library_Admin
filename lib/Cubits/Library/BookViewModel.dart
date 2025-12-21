import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:online_library_management/Models/Requests/AddBookRequest.dart';
import 'package:online_library_management/Models/Responses/UpdateBookResponse.dart';
import 'package:online_library_management/Repositories/BookRepository.dart';
import 'package:online_library_management/Repositories/CategoryRepository.dart';

import '../../Models/Requests/UpdateBookRequest.dart';
import '../../Models/Responses/BookByIdResponse.dart';
import '../../Models/Responses/BooksByCategoryIdResponse.dart';
import '../States/States.dart';

class BookCubit extends Cubit<States> {
  final CategoryRepository repository;
  final AddBookRepository bookRepository;

  BookCubit(this.repository, this.bookRepository) : super(InitialState());

  List<BooksByCategoryId> booksByCategory = [];
  Map<String, List<BooksByCategoryId>> cachedBooks = {}; // categoryId → books list
  String? mainImageNetwork;
  List<String> galleryNetworkImages = [];


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

    String clean(String text) => text.trim();

    final request = AddBookRequest(
      name: clean(nameController.text),
      writer: clean(writerController.text),
      synopsis: clean(synopsisController.text),
      publisher: clean(publisherController.text),
      language: clean(languageController.text),
      condition: clean(conditionController.text),
      edition: clean(editionController.text),

      categoryId: selectedCategoryId,

      numberInStock: int.parse(stockController.text.trim()),
      numberOfCopies: int.parse(copiesController.text.trim()),
      numPages: int.parse(pagesController.text.trim()),
      publishYear: int.parse(yearController.text.trim()),
      weight: int.parse(weightController.text.trim()),

      mainImage: mainImageFormatted,
      gallery: galleryFormatted,
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

  Future<void> getBookDetails(String bookId) async {
    emit(LoadingState(loadingMessage: 'جارى التحميل')); // ⬅️ عشان يمسح القديم ويعرض loader

    var either = await bookRepository.getBookById(bookId);
    either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (success) {
          emit(BookDetailsSuccessState(book: success.data!.book!));
        }

    );
  }

  Future<void> editBook(UpdateBookRequest request, String bookId) async {
    emit(LoadingState(loadingMessage: "Editing book..."));

    try {
      final either = await bookRepository.editBook(request, bookId);

      either.fold(
            (l) {
          emit(ErrorState(errorMessage: l.error?.message));
        },
            (response) {
          emit(EditBookSuccessState(book: response.data!.book!));
         // loadHomeData();
        },
      );
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void initEditBook( BookById book) {
    nameController.text = book.name ?? '';
    writerController.text = book.writer ?? '';
    synopsisController.text = book.synopsis ?? '';
    copiesController.text = book.numberOfCopies.toString();
    stockController.text = book.numberInStock.toString();
    publisherController.text = book.publisher ?? '';
    yearController.text = book.publishYear.toString();
    editionController.text = book.edition ?? '';
    languageController.text = book.language ?? '';
    conditionController.text = book.condition ?? '';
    pagesController.text = book.numPages.toString();
    weightController.text = book.weight.toString();

    //selectedCategoryId = book.categoryId as String?;

    // الصور
    mainImageNetwork = book.mainImage;
    galleryNetworkImages = List.from(book.gallery ?? []);
  }

  UpdateBookRequest buildUpdateRequest() {
    List<String> gallery = [];

    // الصور القديمة (network)
    gallery.addAll(galleryNetworkImages);

    // الصور الجديدة (base64)
    gallery.addAll(
      galleryBase64List.map((img) => "data:image/png;base64,$img"),
    );

    return UpdateBookRequest(
      name: nameController.text,
      writer: writerController.text,
      synopsis: synopsisController.text,
      publisher: publisherController.text,
      language: languageController.text,
      edition: editionController.text,
      condition: conditionController.text,

      publishYear: int.tryParse(yearController.text),
      numPages: int.tryParse(pagesController.text),
      weight: int.tryParse(weightController.text),
      numberOfCopies: int.tryParse(copiesController.text),
      numberInStock: int.tryParse(stockController.text),

      // هنا التعديل المهم
      mainImage: mainImageBase64 != null
          ? "data:image/png;base64,$mainImageBase64"
          : mainImageNetwork ?? "",

      gallery: gallery.isEmpty ? null : gallery,
    );
  }


  Future<void> deleteBook(String bookId) async {
    emit(LoadingState(loadingMessage: 'Loading...'));

    final either = await bookRepository.deleteBook(bookId);

    await either.fold(
          (failure) {
        emit(ErrorState(errorMessage: failure.error?.message ?? "try again later!"));
      },
          (response) async {
        emit(DeleteBookSuccessState(response: response));

      },
    );
  }




}
