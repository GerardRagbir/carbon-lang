// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- fail_default_api.carbon

package A;

// CHECK:STDERR: fail_default_api.carbon:[[@LINE+4]]:1: ERROR: File cannot import itself.
// CHECK:STDERR: import library default;
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR:
import library default;

// --- fail_default.impl.carbon

impl package A;

// CHECK:STDERR: fail_default.impl.carbon:[[@LINE+4]]:1: ERROR: Explicit import of `api` from `impl` file is redundant with implicit import.
// CHECK:STDERR: import library default;
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR:
import library default;

// --- fail_main_import_default.carbon

// CHECK:STDERR: fail_main_import_default.carbon:[[@LINE+4]]:1: ERROR: Explicit import of `api` from `impl` file is redundant with implicit import.
// CHECK:STDERR: import library default;
// CHECK:STDERR: ^~~~~~
// CHECK:STDERR:
import library default;

// --- fail_main_lib_import_default.carbon

library "lib";

// CHECK:STDERR: fail_main_lib_import_default.carbon:[[@LINE+3]]:1: ERROR: Cannot import `Main//default`.
// CHECK:STDERR: import library default;
// CHECK:STDERR: ^~~~~~
import library default;

// CHECK:STDOUT: --- fail_default_api.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_default.impl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_main_import_default.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- fail_main_lib_import_default.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace [template] {
// CHECK:STDOUT:     .Core = %Core
// CHECK:STDOUT:   }
// CHECK:STDOUT:   %Core: <namespace> = namespace [template] {}
// CHECK:STDOUT: }
// CHECK:STDOUT:
