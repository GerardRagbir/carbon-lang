// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

var x: {.a: f64, .b: i32} = {.a = 0.0, .b = 1};
var y: i32 = x.b;
var z: i32 = y;

// CHECK:STDOUT: --- member_access.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: type = struct_type {.a: f64, .b: i32} [template]
// CHECK:STDOUT:   %.2: type = ptr_type {.a: f64, .b: i32} [template]
// CHECK:STDOUT:   %.3: f64 = float_literal 0 [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %struct: {.a: f64, .b: i32} = struct_value (%.3, %.4) [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .x = %x
// CHECK:STDOUT:     .y = %y
// CHECK:STDOUT:     .z = %z
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %.loc7: type = struct_type {.a: f64, .b: i32} [template = constants.%.1]
// CHECK:STDOUT:   %x.var: ref {.a: f64, .b: i32} = var x
// CHECK:STDOUT:   %x: ref {.a: f64, .b: i32} = bind_name x, %x.var
// CHECK:STDOUT:   %y.var: ref i32 = var y
// CHECK:STDOUT:   %y: ref i32 = bind_name y, %y.var
// CHECK:STDOUT:   %z.var: ref i32 = var z
// CHECK:STDOUT:   %z: ref i32 = bind_name z, %z.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc7_35: f64 = float_literal 0 [template = constants.%.3]
// CHECK:STDOUT:   %.loc7_45: i32 = int_literal 1 [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_46.1: {.a: f64, .b: i32} = struct_literal (%.loc7_35, %.loc7_45)
// CHECK:STDOUT:   %.loc7_46.2: ref f64 = struct_access file.%x.var, element0
// CHECK:STDOUT:   %.loc7_46.3: init f64 = initialize_from %.loc7_35 to %.loc7_46.2 [template = constants.%.3]
// CHECK:STDOUT:   %.loc7_46.4: ref i32 = struct_access file.%x.var, element1
// CHECK:STDOUT:   %.loc7_46.5: init i32 = initialize_from %.loc7_45 to %.loc7_46.4 [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_46.6: init {.a: f64, .b: i32} = struct_init (%.loc7_46.3, %.loc7_46.5) to file.%x.var [template = constants.%struct]
// CHECK:STDOUT:   %.loc7_47: init {.a: f64, .b: i32} = converted %.loc7_46.1, %.loc7_46.6 [template = constants.%struct]
// CHECK:STDOUT:   assign file.%x.var, %.loc7_47
// CHECK:STDOUT:   %x.ref: ref {.a: f64, .b: i32} = name_ref x, file.%x
// CHECK:STDOUT:   %.loc8_15.1: ref i32 = struct_access %x.ref, element1
// CHECK:STDOUT:   %.loc8_15.2: i32 = bind_value %.loc8_15.1
// CHECK:STDOUT:   assign file.%y.var, %.loc8_15.2
// CHECK:STDOUT:   %y.ref: ref i32 = name_ref y, file.%y
// CHECK:STDOUT:   %.loc9: i32 = bind_value %y.ref
// CHECK:STDOUT:   assign file.%z.var, %.loc9
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
