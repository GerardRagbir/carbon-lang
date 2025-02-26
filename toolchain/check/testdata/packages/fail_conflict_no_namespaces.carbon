// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- fn.carbon

package Example library "fn";

fn Foo();

// --- var.carbon

package Example library "var";

var Foo: i32;

// --- fail_conflict.carbon

package Example library "conflict";

import library "fn";
// CHECK:STDERR: fail_conflict.carbon:[[@LINE+12]]:1: In import.
// CHECK:STDERR: import library "var";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: var.carbon:4:5: ERROR: Duplicate name being declared in the same scope.
// CHECK:STDERR: var Foo: i32;
// CHECK:STDERR:     ^~~
// CHECK:STDERR: fail_conflict.carbon:[[@LINE-7]]:1: In import.
// CHECK:STDERR: import library "fn";
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR: fn.carbon:4:1: Name is previously declared here.
// CHECK:STDERR: fn Foo();
// CHECK:STDERR: ^~~~~~~~~
import library "var";

// CHECK:STDOUT: --- fn.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Foo: type = fn_type @Foo [template]
// CHECK:STDOUT:   %.1: type = tuple_type () [template]
// CHECK:STDOUT:   %struct: Foo = struct_value () [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Foo = %Foo.decl
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Foo.decl: Foo = fn_decl @Foo [template = constants.%struct] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Foo();
// CHECK:STDOUT:
// CHECK:STDOUT: --- var.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:     .Foo = %Foo
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT:   %Foo.var: ref i32 = var Foo
// CHECK:STDOUT:   %Foo: ref i32 = bind_name Foo, %Foo.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_conflict.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Foo = %import_ref.1
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %import_ref.1 = import_ref ir1, inst+2, unloaded
// CHECK:STDOUT:   %import_ref.2 = import_ref ir2, inst+3, unloaded
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
