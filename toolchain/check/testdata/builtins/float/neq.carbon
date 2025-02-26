// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- float_neq.carbon

fn Neq(a: f64, b: f64) -> bool = "float.neq";

class True {}
class False {}

fn F(true_: True, false_: False) {
  true_ as (if Neq(1.0, 2.0) then True else False);
  false_ as (if Neq(1.0, 1.0) then True else False);
}

fn RuntimeCall(a: f64, b: f64) -> bool {
  return Neq(a, b);
}

// --- fail_bad_decl.carbon

package FailBadDecl;

// CHECK:STDERR: fail_bad_decl.carbon:[[@LINE+3]]:1: ERROR: Invalid signature for builtin function "float.neq".
// CHECK:STDERR: fn WrongResult(a: f64, b: f64) -> f64 = "float.neq";
// CHECK:STDERR: ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fn WrongResult(a: f64, b: f64) -> f64 = "float.neq";

// CHECK:STDOUT: --- float_neq.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Neq: type = fn_type @Neq [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct.1: Neq = struct_value () [template]
// CHECK:STDOUT:   %True: type = class_type @True [template]
// CHECK:STDOUT:   %.2: type = struct_type {} [template]
// CHECK:STDOUT:   %False: type = class_type @False [template]
// CHECK:STDOUT:   %F: type = fn_type @F [template]
// CHECK:STDOUT:   %struct.2: F = struct_value () [template]
// CHECK:STDOUT:   %.3: type = ptr_type {} [template]
// CHECK:STDOUT:   %.4: f64 = float_literal 1 [template]
// CHECK:STDOUT:   %.5: f64 = float_literal 2 [template]
// CHECK:STDOUT:   %.6: bool = bool_literal true [template]
// CHECK:STDOUT:   %.7: f64 = float_literal 1 [template]
// CHECK:STDOUT:   %.8: f64 = float_literal 1 [template]
// CHECK:STDOUT:   %.9: bool = bool_literal false [template]
// CHECK:STDOUT:   %RuntimeCall: type = fn_type @RuntimeCall [template]
// CHECK:STDOUT:   %struct.3: RuntimeCall = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Neq = %Neq.decl
// CHECK:STDOUT:     .True = %True.decl
// CHECK:STDOUT:     .False = %False.decl
// CHECK:STDOUT:     .F = %F.decl
// CHECK:STDOUT:     .RuntimeCall = %RuntimeCall.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Neq.decl: Neq = fn_decl @Neq [template = constants.%struct.1] {
// CHECK:STDOUT:     %a.loc2_8.1: f64 = param a
// CHECK:STDOUT:     @Neq.%a: f64 = bind_name a, %a.loc2_8.1
// CHECK:STDOUT:     %b.loc2_16.1: f64 = param b
// CHECK:STDOUT:     @Neq.%b: f64 = bind_name b, %b.loc2_16.1
// CHECK:STDOUT:     @Neq.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %True.decl: type = class_decl @True [template = constants.%True] {}
// CHECK:STDOUT:   %False.decl: type = class_decl @False [template = constants.%False] {}
// CHECK:STDOUT:   %F.decl: F = fn_decl @F [template = constants.%struct.2] {
// CHECK:STDOUT:     %True.ref: type = name_ref True, %True.decl [template = constants.%True]
// CHECK:STDOUT:     %true_.loc7_6.1: True = param true_
// CHECK:STDOUT:     @F.%true_: True = bind_name true_, %true_.loc7_6.1
// CHECK:STDOUT:     %False.ref: type = name_ref False, %False.decl [template = constants.%False]
// CHECK:STDOUT:     %false_.loc7_19.1: False = param false_
// CHECK:STDOUT:     @F.%false_: False = bind_name false_, %false_.loc7_19.1
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %RuntimeCall.decl: RuntimeCall = fn_decl @RuntimeCall [template = constants.%struct.3] {
// CHECK:STDOUT:     %a.loc12_16.1: f64 = param a
// CHECK:STDOUT:     @RuntimeCall.%a: f64 = bind_name a, %a.loc12_16.1
// CHECK:STDOUT:     %b.loc12_24.1: f64 = param b
// CHECK:STDOUT:     @RuntimeCall.%b: f64 = bind_name b, %b.loc12_24.1
// CHECK:STDOUT:     @RuntimeCall.%return: ref bool = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @True {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%True
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @False {
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .Self = constants.%False
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Neq(%a: f64, %b: f64) -> bool = "float.neq";
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F(%true_: True, %false_: False) {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %true_.ref: True = name_ref true_, %true_
// CHECK:STDOUT:   %Neq.ref.loc8: Neq = name_ref Neq, file.%Neq.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc8_20: f64 = float_literal 1 [template = constants.%.4]
// CHECK:STDOUT:   %.loc8_25: f64 = float_literal 2 [template = constants.%.5]
// CHECK:STDOUT:   %float.neq.loc8: init bool = call %Neq.ref.loc8(%.loc8_20, %.loc8_25) [template = constants.%.6]
// CHECK:STDOUT:   %.loc8_13.1: bool = value_of_initializer %float.neq.loc8 [template = constants.%.6]
// CHECK:STDOUT:   %.loc8_13.2: bool = converted %float.neq.loc8, %.loc8_13.1 [template = constants.%.6]
// CHECK:STDOUT:   if %.loc8_13.2 br !if.expr.then.loc8 else br !if.expr.else.loc8
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc8:
// CHECK:STDOUT:   %True.ref.loc8: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc8(%True.ref.loc8)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc8:
// CHECK:STDOUT:   %False.ref.loc8: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc8(%False.ref.loc8)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc8:
// CHECK:STDOUT:   %.loc8_13.3: type = block_arg !if.expr.result.loc8 [template = constants.%True]
// CHECK:STDOUT:   %false_.ref: False = name_ref false_, %false_
// CHECK:STDOUT:   %Neq.ref.loc9: Neq = name_ref Neq, file.%Neq.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %.loc9_21: f64 = float_literal 1 [template = constants.%.7]
// CHECK:STDOUT:   %.loc9_26: f64 = float_literal 1 [template = constants.%.8]
// CHECK:STDOUT:   %float.neq.loc9: init bool = call %Neq.ref.loc9(%.loc9_21, %.loc9_26) [template = constants.%.9]
// CHECK:STDOUT:   %.loc9_14.1: bool = value_of_initializer %float.neq.loc9 [template = constants.%.9]
// CHECK:STDOUT:   %.loc9_14.2: bool = converted %float.neq.loc9, %.loc9_14.1 [template = constants.%.9]
// CHECK:STDOUT:   if %.loc9_14.2 br !if.expr.then.loc9 else br !if.expr.else.loc9
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.then.loc9:
// CHECK:STDOUT:   %True.ref.loc9: type = name_ref True, file.%True.decl [template = constants.%True]
// CHECK:STDOUT:   br !if.expr.result.loc9(%True.ref.loc9)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.else.loc9:
// CHECK:STDOUT:   %False.ref.loc9: type = name_ref False, file.%False.decl [template = constants.%False]
// CHECK:STDOUT:   br !if.expr.result.loc9(%False.ref.loc9)
// CHECK:STDOUT:
// CHECK:STDOUT: !if.expr.result.loc9:
// CHECK:STDOUT:   %.loc9_14.3: type = block_arg !if.expr.result.loc9 [template = constants.%False]
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @RuntimeCall(%a: f64, %b: f64) -> bool {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Neq.ref: Neq = name_ref Neq, file.%Neq.decl [template = constants.%struct.1]
// CHECK:STDOUT:   %a.ref: f64 = name_ref a, %a
// CHECK:STDOUT:   %b.ref: f64 = name_ref b, %b
// CHECK:STDOUT:   %float.neq: init bool = call %Neq.ref(%a.ref, %b.ref)
// CHECK:STDOUT:   %.loc13_19.1: bool = value_of_initializer %float.neq
// CHECK:STDOUT:   %.loc13_19.2: bool = converted %float.neq, %.loc13_19.1
// CHECK:STDOUT:   return %.loc13_19.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_bad_decl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %WrongResult: type = fn_type @WrongResult [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: WrongResult = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .WrongResult = %WrongResult.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %WrongResult.decl: WrongResult = fn_decl @WrongResult [template = constants.%struct] {
// CHECK:STDOUT:     %a.loc7_16.1: f64 = param a
// CHECK:STDOUT:     @WrongResult.%a: f64 = bind_name a, %a.loc7_16.1
// CHECK:STDOUT:     %b.loc7_24.1: f64 = param b
// CHECK:STDOUT:     @WrongResult.%b: f64 = bind_name b, %b.loc7_24.1
// CHECK:STDOUT:     @WrongResult.%return: ref f64 = var <return slot>
// CHECK:STDOUT:   }
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @WrongResult(%a: f64, %b: f64) -> f64;
// CHECK:STDOUT:
