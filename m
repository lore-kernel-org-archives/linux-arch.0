From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v4 00/11] kunit: create a centralized executor to dispatch all
 KUnit tests
Date: Wed, 24 Jun 2020 13:55:39 -0700
Message-ID: <20200624205550.215599-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org, Brendan Higgins <brendanhiggins@google.com>
List-Id: linux-arch.vger.kernel.org

## TL;DR

This patchset adds a centralized executor to dispatch tests rather than
relying on late_initcall to schedule each test suite separately along
with a couple of new features that depend on it.

Also, sorry for the extreme delay in getting this out. Part of the delay
came from finding that there were actually several architectures that
the previous revision of this patchset didn't work on, so I went through
and attempted to test this patchset on every architecture - more on that
later.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The last two of three patches in this series add features which depend
on this:

PATCH 8/11 Prints out a test plan[1] right before KUnit tests are run;
           this is valuable because it makes it possible for a test
           harness to detect whether the number of tests run matches the
           number of tests expected to be run, ensuring that no tests
           silently failed. The test plan includes a count of tests that
           will run. With the centralized executor, the tests are
           located in a single data structure and thus can be counted.

PATCH 9/11 Add a new kernel command-line option which allows the user to
           specify that the kernel poweroff, halt, or reboot after
           completing all KUnit tests; this is very handy for running
           KUnit tests on UML or a VM so that the UML/VM process exits
           cleanly immediately after running all tests without needing a
           special initramfs. The centralized executor provides a
           definitive point when all tests have completed and the
           poweroff, halt, or reboot could occur.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## Changes since last revision:
 - On the last revision I got some messages from 0day that showed that
   this patchset didn't work on several architectures, one issue that
   this patchset addresses is that we were aligning both memory segments
   as well as structures in the segments to specific byte boundaries
   which was incorrect.
 - The issue mentioned above also caused me to test on additional
   architectures which revealed that some architectures other than UML
   do not use the default init linker section macro that most
   architectures use. There are now several new patches (2, 3, 4, and
   6).
 - Fixed a formatting consistency issue in the kernel params
   documentation patch (9/9).
 - Add a brief blurb on how and when the kunit_test_suite macro works.

## Remaining work to be done:

The only architecture for which I was able to get a compiler, but was
apparently unable to get KUnit into a section that the executor to see
was m68k - not sure why.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (10):
  vmlinux.lds.h: add linker section for KUnit test suites
  arch: arm64: add linker section for KUnit test suites
  arch: microblaze: add linker section for KUnit test suites
  arch: powerpc: add linker section for KUnit test suites
  arch: um: add linker section for KUnit test suites
  arch: xtensa: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: Add kunit_shutdown to kernel-parameters.txt
  Documentation: kunit: add a brief blurb about kunit_test_suite

 .../admin-guide/kernel-parameters.txt         |   8 ++
 Documentation/dev-tools/kunit/usage.rst       |   5 ++
 arch/arm64/kernel/vmlinux.lds.S               |   3 +
 arch/microblaze/kernel/vmlinux.lds.S          |   4 +
 arch/powerpc/kernel/vmlinux.lds.S             |   4 +
 arch/um/include/asm/common.lds.S              |   4 +
 arch/xtensa/kernel/vmlinux.lds.S              |   4 +
 include/asm-generic/vmlinux.lds.h             |   8 ++
 include/kunit/test.h                          |  73 ++++++++++++-----
 init/main.c                                   |   4 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/executor.c                          |  63 +++++++++++++++
 lib/kunit/test.c                              |  13 +--
 tools/testing/kunit/kunit_kernel.py           |   2 +-
 tools/testing/kunit/kunit_parser.py           |  74 +++++++++++++++---
 .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
 .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
 .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
 18 files changed, 226 insertions(+), 46 deletions(-)
 create mode 100644 lib/kunit/executor.c


base-commit: 4333a9b0b67bb4e8bcd91bdd80da80b0ec151162
prerequisite-patch-id: 2d4b5aa9fa8ada9ae04c8584b47c299a822b9455
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0

These patches are available for download with dependencies here:

https://kunit-review.googlesource.com/c/linux/+/3829

[1] https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
[2] https://patchwork.kernel.org/patch/11383635/

-- 
2.27.0.212.ge8ba1cc988-goog
