Return-Path: <frowand.list@gmail.com>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
References: <20200228012036.15682-1-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <da91797a-8640-12c7-8265-94586aacfa4c@gmail.com>
Date: Mon, 2 Mar 2020 11:41:39 -0600
MIME-Version: 1.0
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200302174139.CwMjwH7CLrs3PdnUT-XDZsM6Boiux6r74WT6uIA9VEI@z>

On 2/27/20 7:20 PM, Brendan Higgins wrote:
> ## TL;DR
> 
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.
> 
> Also, sorry for the delay in getting this new revision out. I have been
> really busy for the past couple weeks.
> 
> ## What am I trying to do?
> 
> Conceptually, I am trying to provide a mechanism by which test suites
> can be grouped together so that they can be reasoned about collectively.
> The last two of three patches in this series add features which depend
> on this:
> 
> PATCH 5/7 Prints out a test plan[1] right before KUnit tests are run;
>           this is valuable because it makes it possible for a test
>           harness to detect whether the number of tests run matches the
>           number of tests expected to be run, ensuring that no tests
>           silently failed. The test plan includes a count of tests that
>           will run. With the centralized executor, the tests are located
>           in a single data structure and thus can be counted.
> 
> PATCH 6/7 Add a new kernel command-line option which allows the user to
>           specify that the kernel poweroff, halt, or reboot after
>           completing all KUnit tests; this is very handy for running
>           KUnit tests on UML or a VM so that the UML/VM process exits
>           cleanly immediately after running all tests without needing a
>           special initramfs. The centralized executor provides a
>           definitive point when all tests have completed and the
>           poweroff, halt, or reboot could occur.
> 
> In addition, by dispatching tests from a single location, we can
> guarantee that all KUnit tests run after late_init is complete, which
> was a concern during the initial KUnit patchset review (this has not
> been a problem in practice, but resolving with certainty is nevertheless
> desirable).
> 
> Other use cases for this exist, but the above features should provide an
> idea of the value that this could provide.
> 
> ## Changes since last revision:
> - On patch 7/7, I added some additional wording around the
>   kunit_shutdown command line option explaining that it runs after
>   built-in tests as suggested by Frank.
> - On the coverletter, I improved some wording and added a missing link.
>   I also specified the base-commit for the series.

> - Frank asked for some changes to the documentation; however, David is
>   taking care of that in a separate patch[2], so I did not make those
>   changes here. There will be some additional changes necessary
>   after David's patch is applied.

Making the documentation changes after David's patches sounds like
a good plan to me.

-Frank

> 
> Alan Maguire (1):
>   kunit: test: create a single centralized executor for all tests
> 
> Brendan Higgins (5):
>   vmlinux.lds.h: add linker section for KUnit test suites
>   arch: um: add linker section for KUnit test suites
>   init: main: add KUnit to kernel init
>   kunit: test: add test plan to KUnit TAP format
>   Documentation: Add kunit_shutdown to kernel-parameters.txt
> 
> David Gow (1):
>   kunit: Add 'kunit_shutdown' option
> 
>  .../admin-guide/kernel-parameters.txt         |  8 ++
>  arch/um/include/asm/common.lds.S              |  4 +
>  include/asm-generic/vmlinux.lds.h             |  8 ++
>  include/kunit/test.h                          | 82 ++++++++++++-------
>  init/main.c                                   |  4 +
>  lib/kunit/Makefile                            |  3 +-
>  lib/kunit/executor.c                          | 71 ++++++++++++++++
>  lib/kunit/test.c                              | 11 ---
>  tools/testing/kunit/kunit_kernel.py           |  2 +-
>  tools/testing/kunit/kunit_parser.py           | 76 ++++++++++++++---
>  .../test_is_test_passed-all_passed.log        |  1 +
>  .../test_data/test_is_test_passed-crash.log   |  1 +
>  .../test_data/test_is_test_passed-failure.log |  1 +
>  13 files changed, 218 insertions(+), 54 deletions(-)
>  create mode 100644 lib/kunit/executor.c
> 
> 
> base-commit: a2f0b878c3ca531a1706cb2a8b079cea3b17bafc
> 
> [1] https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> [2] https://patchwork.kernel.org/patch/11383635/
> 
