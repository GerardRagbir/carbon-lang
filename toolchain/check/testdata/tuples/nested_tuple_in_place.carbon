// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn F() -> (i32, i32, i32);

fn G() {
  var v: ((i32, i32, i32), (i32, i32, i32)) = (F(), F());
}

fn H() {
  var v: (i32, (i32, i32, i32), i32) = (1, F(), 2);
}

// CHECK:STDOUT: --- nested_tuple_in_place.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = tuple_type (type, type, type) [template]
// CHECK:STDOUT:   %.2: type = tuple_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %.3: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: F = struct_value () [template]
// CHECK:STDOUT:   %G: type = fn_type @G [template]
// CHECK:STDOUT:   %struct.2: G = struct_value () [template]
// CHECK:STDOUT:   %.4: type = tuple_type ((type, type, type), (type, type, type)) [template]
// CHECK:STDOUT:   %.5: type = tuple_type ((i32, i32, i32), (i32, i32, i32)) [template]
// CHECK:STDOUT:   %.6: type = ptr_type (i32, i32, i32) [template]
// CHECK:STDOUT:   %.7: type = tuple_type ((i32, i32, i32)*, (i32, i32, i32)*) [template]
// CHECK:STDOUT:   %.8: type = ptr_type ((i32, i32, i32)*, (i32, i32, i32)*) [template]
// CHECK:STDOUT:   %H: type = fn_type @H [template]
// CHECK:STDOUT:   %struct.3: H = struct_value () [template]
// CHECK:STDOUT:   %.9: type = tuple_type (type, (type, type, type), type) [template]
// CHECK:STDOUT:   %.10: type = tuple_type (i32, (i32, i32, i32), i32) [template]
// CHECK:STDOUT:   %.11: type = tuple_type (i32, (i32, i32, i32)*, i32) [template]
// CHECK:STDOUT:   %.12: type = ptr_type (i32, (i32, i32, i32)*, i32) [template]
// CHECK:STDOUT:   %.13: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.14: i32 = int_literal 2 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:     .G = %G.decl
// CHECK:STDOUT:     .H = %H.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.1] {
// CHECK:STDOUT:     %.loc7_25.1: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:     %.loc7_25.2: type = converted %.loc7_25.1, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:     @F.%return: ref (i32, i32, i32) = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %G.decl: G = fn_decl @G [template = constants.%struct.2] {}
// CHECK:STDOUT:   %H.decl: H = fn_decl @H [template = constants.%struct.3] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F() -> (i32, i32, i32);
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc10_25: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:   %.loc10_42: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:   %.loc10_43.1: ((type, type, type), (type, type, type)) = tuple_literal (%.loc10_25, %.loc10_42)
// CHECK:STDOUT:   %.loc10_43.2: type = converted %.loc10_25, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:   %.loc10_43.3: type = converted %.loc10_42, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:   %.loc10_43.4: type = converted %.loc10_43.1, constants.%.5 [template = constants.%.5]
// CHECK:STDOUT:   %v.var: ref ((i32, i32, i32), (i32, i32, i32)) = var v
// CHECK:STDOUT:   %v: ref ((i32, i32, i32), (i32, i32, i32)) = bind_name v, %v.var
// CHECK:STDOUT:   %F.ref.loc10_48: F = name_ref F, file.%F.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc10_56.1: ref (i32, i32, i32) = tuple_access %v.var, element0
// CHECK:STDOUT:   %F.call.loc10_49: init (i32, i32, i32) = call %F.ref.loc10_48() to %.loc10_56.1
// CHECK:STDOUT:   %F.ref.loc10_53: F = name_ref F, file.%F.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc10_56.2: ref (i32, i32, i32) = tuple_access %v.var, element1
// CHECK:STDOUT:   %F.call.loc10_54: init (i32, i32, i32) = call %F.ref.loc10_53() to %.loc10_56.2
// CHECK:STDOUT:   %.loc10_56.3: ((i32, i32, i32), (i32, i32, i32)) = tuple_literal (%F.call.loc10_49, %F.call.loc10_54)
// CHECK:STDOUT:   %.loc10_56.4: init ((i32, i32, i32), (i32, i32, i32)) = tuple_init (%F.call.loc10_49, %F.call.loc10_54) to %v.var
// CHECK:STDOUT:   %.loc10_57: init ((i32, i32, i32), (i32, i32, i32)) = converted %.loc10_56.3, %.loc10_56.4
// CHECK:STDOUT:   assign %v.var, %.loc10_57
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @H() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc14_30: (type, type, type) = tuple_literal (i32, i32, i32)
// CHECK:STDOUT:   %.loc14_36.1: (type, (type, type, type), type) = tuple_literal (i32, %.loc14_30, i32)
// CHECK:STDOUT:   %.loc14_36.2: type = converted %.loc14_30, constants.%.2 [template = constants.%.2]
// CHECK:STDOUT:   %.loc14_36.3: type = converted %.loc14_36.1, constants.%.10 [template = constants.%.10]
// CHECK:STDOUT:   %v.var: ref (i32, (i32, i32, i32), i32) = var v
// CHECK:STDOUT:   %v: ref (i32, (i32, i32, i32), i32) = bind_name v, %v.var
// CHECK:STDOUT:   %.loc14_41: i32 = int_literal 1 [template = constants.%.13]
// CHECK:STDOUT:   %F.ref: F = name_ref F, file.%F.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc14_50.1: ref (i32, i32, i32) = tuple_access %v.var, element1
// CHECK:STDOUT:   %F.call: init (i32, i32, i32) = call %F.ref() to %.loc14_50.1
// CHECK:STDOUT:   %.loc14_49: i32 = int_literal 2 [template = constants.%.14]
// CHECK:STDOUT:   %.loc14_50.2: (i32, (i32, i32, i32), i32) = tuple_literal (%.loc14_41, %F.call, %.loc14_49)
// CHECK:STDOUT:   %.loc14_50.3: ref i32 = tuple_access %v.var, element0
// CHECK:STDOUT:   %.loc14_50.4: init i32 = initialize_from %.loc14_41 to %.loc14_50.3 [template = constants.%.13]
// CHECK:STDOUT:   %.loc14_50.5: ref i32 = tuple_access %v.var, element2
// CHECK:STDOUT:   %.loc14_50.6: init i32 = initialize_from %.loc14_49 to %.loc14_50.5 [template = constants.%.14]
// CHECK:STDOUT:   %.loc14_50.7: init (i32, (i32, i32, i32), i32) = tuple_init (%.loc14_50.4, %F.call, %.loc14_50.6) to %v.var
// CHECK:STDOUT:   %.loc14_51: init (i32, (i32, i32, i32), i32) = converted %.loc14_50.2, %.loc14_50.7
// CHECK:STDOUT:   assign %v.var, %.loc14_51
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
