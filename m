Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWPdw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 10:33:52 -0500
From: Will Deacon <will@kernel.org>
Subject: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Thu, 23 Jan 2020 15:33:31 +0000
Message-ID: <20200123153341.19947-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20200123153331.jMcuM0ZhTolblbeTg4NADJqGAd2Z5RFv75kR4BhM_P4@z>

Hi folks,

This is version two of the patches I previously posted as an RFC here:

https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org

Changes since then include:

  * Adopted a less vomit-inducing series of macros for __unqual_scalar_typeof

  * Cast to 'const' in READ_ONCE() to prevent assignment to the resulting
    expression

  * Only warn once at build-time if GCC prior to 4.8 is detected...

  * ... and then raise the minimum GCC version to 4.8, with an error for
    older versions of the compiler

  * Remove some dead gcov code so that the resulting diffstat can distract
    from those less vomit-inducing macros I mentioned earlier on

Failing the build for older compilers is always a contentious topic, so
I've done that as a separate couple of patches on the end in case we end
up dropping or reverting them.

Cheers,

Will

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>

--->8

Will Deacon (10):
  compiler/gcc: Emit build-time warning for GCC prior to version 4.8
  netfilter: Avoid assigning 'const' pointer to non-const pointer
  fault_inject: Don't rely on "return value" from WRITE_ONCE()
  READ_ONCE: Simplify implementations of {READ,WRITE}_ONCE()
  READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses
  READ_ONCE: Drop pointer qualifiers when reading from scalar types
  locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
  arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release
    macros
  compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
  gcov: Remove old GCC 3.4 support

 Documentation/process/changes.rst |   2 +-
 arch/arm/crypto/Kconfig           |  12 +-
 arch/arm64/include/asm/barrier.h  |  16 +-
 crypto/Kconfig                    |   1 -
 drivers/xen/time.c                |   2 +-
 include/asm-generic/barrier.h     |  16 +-
 include/linux/compiler-gcc.h      |   5 +-
 include/linux/compiler.h          | 129 +++----
 include/linux/compiler_types.h    |  21 ++
 init/Kconfig                      |   5 +-
 kernel/gcov/Kconfig               |  24 --
 kernel/gcov/Makefile              |   3 +-
 kernel/gcov/gcc_3_4.c             | 573 ------------------------------
 lib/fault-inject.c                |   4 +-
 net/netfilter/core.c              |   2 +-
 net/xdp/xsk_queue.h               |   2 +-
 scripts/Kconfig.include           |   3 +
 scripts/gcc-plugins/Kconfig       |   4 +-
 18 files changed, 111 insertions(+), 713 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

-- 
2.25.0.341.g760bfbb309-goog
