

import 'package:uniswap/core/utils/credentials.dart';

const String projectId = Credentials.projectID;
const String bucketId = Credentials.productBucketId;
const String url = Credentials.apiEndpoint;

String appwriteImageUrl(String fileId) {
  return 'url/storage/buckets/$bucketId/files/$fileId/view?project=$projectId&mode=admin';
}
