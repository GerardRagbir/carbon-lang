// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

fn Mismatch() -> i32 {
  // CHECK:STDERR: fail_returned_var_type.carbon:[[@LINE+6]]:19: ERROR: Type `f64` of `returned var` does not match return type of enclosing function.
  // CHECK:STDERR:   returned var v: f64 = 0.0;
  // CHECK:STDERR:                   ^~~
  // CHECK:STDERR: fail_returned_var_type.carbon:[[@LINE-4]]:15: Return type of function is `i32`.
  // CHECK:STDERR: fn Mismatch() -> i32 {
  // CHECK:STDERR:               ^~~~~~
  returned var v: f64 = 0.0;
  return var;
}

// CHECK:STDOUT: --- fail_returned_var_type.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Mismatch: type = fn_type @Mismatch [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Mismatch = struct_value () [template]
// CHECK:STDOUT:   %.2: f64 = float_literal 0 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Mismatch = %Mismatch.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Mismatch.decl: Mismatch = fn_decl @Mismatch [template = constants.%struct] {
// CHECK:STDOUT:     @Mismatch.%return: ref i32 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Mismatch() -> i32 {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %v: f64 = bind_name v, <error>
// CHECK:STDOUT:   %.loc14: f64 = float_literal 0 [template = constants.%.2]
// CHECK:STDOUT:   assign <error>, <error>
// CHECK:STDOUT:   return <error>
// CHECK:STDOUT: }
// CHECK:STDOUT:
