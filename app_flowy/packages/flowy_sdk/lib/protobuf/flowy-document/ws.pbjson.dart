///
//  Generated code. Do not modify.
//  source: ws.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use wsDataTypeDescriptor instead')
const WsDataType$json = const {
  '1': 'WsDataType',
  '2': const [
    const {'1': 'Acked', '2': 0},
    const {'1': 'PushRev', '2': 1},
    const {'1': 'PullRev', '2': 2},
    const {'1': 'Conflict', '2': 3},
    const {'1': 'NewDocUser', '2': 4},
  ],
};

/// Descriptor for `WsDataType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List wsDataTypeDescriptor = $convert.base64Decode('CgpXc0RhdGFUeXBlEgkKBUFja2VkEAASCwoHUHVzaFJldhABEgsKB1B1bGxSZXYQAhIMCghDb25mbGljdBADEg4KCk5ld0RvY1VzZXIQBA==');
@$core.Deprecated('Use wsDocumentDataDescriptor instead')
const WsDocumentData$json = const {
  '1': 'WsDocumentData',
  '2': const [
    const {'1': 'doc_id', '3': 1, '4': 1, '5': 9, '10': 'docId'},
    const {'1': 'ty', '3': 2, '4': 1, '5': 14, '6': '.WsDataType', '10': 'ty'},
    const {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `WsDocumentData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List wsDocumentDataDescriptor = $convert.base64Decode('Cg5Xc0RvY3VtZW50RGF0YRIVCgZkb2NfaWQYASABKAlSBWRvY0lkEhsKAnR5GAIgASgOMgsuV3NEYXRhVHlwZVICdHkSEgoEZGF0YRgDIAEoDFIEZGF0YQ==');
