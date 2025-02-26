// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F() -> (i32, i32, i32);

fn G() {
  var v: {.a: (i32, i32, i32), .b: (i32, i32, i32)} = {.a = F(), .b = F()};
}

// CHECK:STDOUT: --- nested_struct_in_place.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = tuple_type (type, type, type) [template]
// CHECK:STDOUT:   %.2: type = tuple_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %.3: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: F = struct_value () [template]
// CHECK:STDOUT:   %G: type = fn_type @G [template]
// CHECK:STDOUT:   %struct.2: G = struct_value () [template]
// CHECK:STDOUT:   %.4: type = struct_type {.a: (i32, i32, i32), .b: (i32, i32, i32)} [template]
// CHECK:STDOUT:   %.5: type = ptr_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %.6: type = struct_type {.a: (i32, i32, i32)*, .b: (i32, i32, i32)*} [template]
// CHECK:STDOUT:   %.7: type = ptr_type {.a: (i32, i32, i32)*, .b: (i32, i32, i32)*} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:     .G = %G.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.1] {
// CHECK:STDOUT:     %.loc7_25.1: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:     %.loc7_25.2: type = converted %.loc7_25.1, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:     @F.%return: ref (i32, i32, i32) = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %G.decl: G = fn_decl @G [template = constants.%struct.2] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> (i32, i32, i32);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc10_29.1: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:   %.loc10_29.2: type = converted %.loc10_29.1, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:   %.loc10_50.1: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:   %.loc10_50.2: type = converted %.loc10_50.1, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:   %.loc10_51: type = struct_type {.a: (i32, i32, i32), .b: (i32, i32, i32)} [template = constants.%.4]
// CHECK:STDOUT:   %v.var: ref {.a: (i32, i32, i32), .b: (i32, i32, i32)} = var v
// CHECK:STDOUT:   %v: ref {.a: (i32, i32, i32), .b: (i32, i32, i32)} = bind_name v, %v.var
// CHECK:STDOUT:   %F.ref.loc10_61: F = name_ref F, file.%F.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc10_74.1: ref (i32, i32, i32) = struct_access %v.var, element0
// CHECK:STDOUT:   %F.call.loc10_62: init (i32, i32, i32) = call %F.ref.loc10_61() to %.loc10_74.1
// CHECK:STDOUT:   %F.ref.loc10_71: F = name_ref F, file.%F.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc10_74.2: ref (i32, i32, i32) = struct_access %v.var, element1
// CHECK:STDOUT:   %F.call.loc10_72: init (i32, i32, i32) = call %F.ref.loc10_71() to %.loc10_74.2
// CHECK:STDOUT:   %.loc10_74.3: {.a: (i32, i32, i32), .b: (i32, i32, i32)} = struct_literal (%F.call.loc10_62, %F.call.loc10_72)
// CHECK:STDOUT:   %.loc10_74.4: init {.a: (i32, i32, i32), .b: (i32, i32, i32)} = struct_init (%F.call.loc10_62, %F.call.loc10_72) to %v.var
// CHECK:STDOUT:   %.loc10_75: init {.a: (i32, i32, i32), .b: (i32, i32, i32)} = converted %.loc10_74.3, %.loc10_74.4
// CHECK:STDOUT:   assign %v.var, %.loc10_75
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
