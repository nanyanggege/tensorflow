/* Copyright 2020 The TensorFlow Authors. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
==============================================================================*/

// This is the operation interface definition file for TensorFlow.

#ifndef TF_OP_INTERFACES
#define TF_OP_INTERFACES

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// TensorFlow interfaces
//===----------------------------------------------------------------------===//

def TF_LayoutSensitiveInterface : OpInterface<"LayoutSensitiveInterface"> {
  let description = [{
    A layout sensitive operation is one that depends on a `data_format` string
    attribute, that gives a meaning to the data inside arguments and results.

    Currently supported data formats (layouts):
      - NHWC : channels last  [batch, height, width, channels]
      - NCHW : channels first [batch, channels, height, width]

    Layout sensitive ops might have different preferred (and supported) layouts
    depending on arguments shape/type and execution device (CPU or GPU).
  }];

  let methods = [
    InterfaceMethod<
      [{Returns current operation data format (data layout).}],
      "StringRef", "data_format", (ins)
    >,
    InterfaceMethod<
      [{Returns indices of layout dependent arguments.}],
      "SmallVector<int64_t, 4>", "GetLayoutDependentArgs", (ins)
    >,
    InterfaceMethod<
      [{Returns indices of layout dependent results.}],
      "SmallVector<int64_t, 4>", "GetLayoutDependentResults", (ins)
    >,
  ];

  let verify = [{
    return VerifyLayoutSensitiveInterface($_op);
  }];
}

#endif // TF_OP_INTERFACES
