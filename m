Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f74.google.com ([209.85.128.74]:55005 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391724AbfJPIlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:12 -0400
Received: by mail-wm1-f74.google.com with SMTP id g67so664722wmg.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:09 -0700 (PDT)
Date: Wed, 16 Oct 2019 10:39:51 +0200
Message-ID: <20191016083959.186860-1-elver@google.com>
Mime-Version: 1.0
Subject: [PATCH 0/8] Add Kernel Concurrency Sanitizer (KCSAN)
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191016083951.Qu5SRhTagIwRxkaMPAAS6IlNChW_ilUAneDovScDJbo@z>

This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
KCSAN is a sampling watchpoint-based data-race detector. More details
are included in Documentation/dev-tools/kcsan.rst. This patch-series
only enables KCSAN for x86, but we expect adding support for other
architectures is relatively straightforward (we are aware of
experimental ARM64 and POWER support).

To gather early feedback, we announced KCSAN back in September, and
have integrated the feedback where possible:
http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com

We want to point out and acknowledge the work surrounding the LKMM,
including several articles that motivate why data-races are dangerous
[1, 2], justifying a data-race detector such as KCSAN.
[1] https://lwn.net/Articles/793253/
[2] https://lwn.net/Articles/799218/

The current list of known upstream fixes for data-races found by KCSAN
can be found here:
https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan

Marco Elver (8):
  kcsan: Add Kernel Concurrency Sanitizer infrastructure
  objtool, kcsan: Add KCSAN runtime functions to whitelist
  build, kcsan: Add KCSAN build exceptions
  seqlock, kcsan: Add annotations for KCSAN
  seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
  asm-generic, kcsan: Add KCSAN instrumentation for bitops
  locking/atomics, kcsan: Add KCSAN instrumentation
  x86, kcsan: Enable KCSAN for x86

 Documentation/dev-tools/kcsan.rst         | 202 ++++++++++
 MAINTAINERS                               |  11 +
 Makefile                                  |   3 +-
 arch/x86/Kconfig                          |   1 +
 arch/x86/boot/Makefile                    |   1 +
 arch/x86/boot/compressed/Makefile         |   1 +
 arch/x86/entry/vdso/Makefile              |   1 +
 arch/x86/include/asm/bitops.h             |   2 +-
 arch/x86/kernel/Makefile                  |   6 +
 arch/x86/kernel/cpu/Makefile              |   3 +
 arch/x86/lib/Makefile                     |   2 +
 arch/x86/mm/Makefile                      |   3 +
 arch/x86/purgatory/Makefile               |   1 +
 arch/x86/realmode/Makefile                |   1 +
 arch/x86/realmode/rm/Makefile             |   1 +
 drivers/firmware/efi/libstub/Makefile     |   1 +
 include/asm-generic/atomic-instrumented.h | 192 ++++++++-
 include/asm-generic/bitops-instrumented.h |  18 +
 include/linux/compiler-clang.h            |   9 +
 include/linux/compiler-gcc.h              |   7 +
 include/linux/compiler.h                  |  35 +-
 include/linux/kcsan-checks.h              | 116 ++++++
 include/linux/kcsan.h                     |  85 ++++
 include/linux/sched.h                     |   7 +
 include/linux/seqlock.h                   |  51 ++-
 init/init_task.c                          |   6 +
 init/main.c                               |   2 +
 kernel/Makefile                           |   6 +
 kernel/kcsan/Makefile                     |  14 +
 kernel/kcsan/atomic.c                     |  21 +
 kernel/kcsan/core.c                       | 458 ++++++++++++++++++++++
 kernel/kcsan/debugfs.c                    | 225 +++++++++++
 kernel/kcsan/encoding.h                   |  94 +++++
 kernel/kcsan/kcsan.c                      |  81 ++++
 kernel/kcsan/kcsan.h                      | 140 +++++++
 kernel/kcsan/report.c                     | 307 +++++++++++++++
 kernel/kcsan/test.c                       | 117 ++++++
 kernel/sched/Makefile                     |   6 +
 lib/Kconfig.debug                         |   2 +
 lib/Kconfig.kcsan                         |  88 +++++
 lib/Makefile                              |   3 +
 mm/Makefile                               |   8 +
 scripts/Makefile.kcsan                    |   6 +
 scripts/Makefile.lib                      |  10 +
 scripts/atomic/gen-atomic-instrumented.sh |   9 +-
 tools/objtool/check.c                     |  17 +
 46 files changed, 2364 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/dev-tools/kcsan.rst
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.c
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.c
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan

-- 
2.23.0.700.g56cf767bdb-goog
