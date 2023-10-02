import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

DocumentNode createOrUpdateUserApiDocument() => gql("""
mutation UpsertUserMut(\$_username: String,\$_walletAddress: String!) {
  upsertUser(username: \$_username, walletAddress: \$_walletAddress) {
    username
    walletAddress
  }
}
""");
