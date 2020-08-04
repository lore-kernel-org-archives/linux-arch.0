From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v6 0/5] kunit: create a centralized executor to dispatch all
 KUnit tests
Date: Tue,  4 Aug 2020 13:47:40 -0700
Message-ID: <20200804204745.987648-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

## TL;DR

This patchset adds a centralized executor to dispatch tests rather than
relying on late_initcall to schedule each test suite separately along
with a couple of new features that depend on it.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The second to last patch in this series add features which depend on
this:

PATCH 04/05 Prints out a test plan[1] right before KUnit tests are run;
            this is valuable because it makes it possible for a test
            harness to detect whether the number of tests run matches
            the number of tests expected to be run, ensuring that no
            tests silently failed. The test plan includes a count of
            tests that will run. With the centralized executor, the
            tests are located in a single data structure and thus can be
            counted.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## Changes since last revision:
 - Renamed the KUNIT_TEST_SUITES the KUNIT_TABLE section and moved it
   from INIT_DATA_SECTION to INIT_DATA; this had the additional
   consequence of making the first several architecture specific patches
   unnecessary - suggested by Kees.
 - Dropped the kunit_shutdown patches; I think it makes more sense to
   reintroduce them in a later patchset.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (4):
  vmlinux.lds.h: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: kunit: add a brief blurb about kunit_test_suite

 Documentation/dev-tools/kunit/usage.rst       |   5 ++
 include/asm-generic/vmlinux.lds.h             |  10 ++-
 include/kunit/test.h                          |  76 +++++++++++++-----
 init/main.c                                   |   4 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/executor.c                          |  43 ++++++++++
 lib/kunit/test.c                              |  13 +--
 tools/testing/kunit/kunit_parser.py           |  76 ++++++++++++++----
 .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
 .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
 .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
 11 files changed, 180 insertions(+), 50 deletions(-)
 create mode 100644 lib/kunit/executor.c


base-commit: 145ff1ec090dce9beb5a9590b5dc288e7bb2e65d
-- 
2.28.0.163.g6104cc2f0b6-goog
