import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';
import 'package:uniswap/core/utils/credentials.dart';
import 'package:uniswap/models/event_model.dart';
import 'package:uniswap/models/product_model.dart';

class TicketController extends GetxController {
  final Databases _databases = Databases(Get.find<Client>());
  final Storage _storage = Storage(Get.find<Client>());

  // Reactive list to hold categories
  RxList<EventModel> events = <EventModel>[].obs; // Reactive list for products

  // Collection and database IDs from credentials
  final String databaseId = Credentials.databaseId;
  final String userCollectionId = Credentials.usersCollectonId;
  final String eventCollectionId = Credentials.eventCollectionId;

    // Loading state
  RxBool isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();

    fetchEvents();
    // final userId = SavedData.getUserId();

    // ]);
  }

  // Fetch all products or by category ID
  Future<void> fetchEvents() async {
    try {
      isLoading(true);
      // Fetch documents from Appwrite database
      final response = await _databases.listDocuments(
        databaseId: databaseId,
        collectionId: eventCollectionId,
      );
      // Map the fetched documents to ProductModel
      events.value = response.documents.map((doc) => EventModel.fromJson(doc.data)).toList();
    } catch (e) {
      print('Error fetching Event: $e');
    } finally {
      isLoading(false);
    }
  }
}
