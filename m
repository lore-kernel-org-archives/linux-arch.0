From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 00/12] Rework READ_ONCE() to improve codegen
Date: Wed, 15 Apr 2020 17:52:06 +0100
Message-ID: <20200415165218.20251-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410478AbgDOQwt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:52:49 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

Hi everyone,

This is version three of the patches I previously posted for improving
the code generation of READ_ONCE() and moving the minimum GCC version
to 4.8:

RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org

Although v2 was queued up by Peter in -tip, it was found to break the
build for m68k and sparc32. We fixed m68k during the merge window and
I've since posted patches to fix sparc32 here:

  https://lore.kernel.org/lkml/20200414214011.2699-1-will@kernel.org

This series is a refresh on top of 5.7-rc1, the main changes being:

  * Fix another issue where 'const' is assigned to non-const via
    WRITE_ONCE(), this time in the tls code

  * Fix READ_ONCE_NOCHECK() abuse in arm64 checksum code

  * Added Reviewed-bys and Acks from v2

Hopefully this can be considered for 5.8, along with the sparc32 changes.

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

Will Deacon (12):
  compiler/gcc: Emit build-time warning for GCC prior to version 4.8
  netfilter: Avoid assigning 'const' pointer to non-const pointer
  net: tls: Avoid assigning 'const' pointer to non-const pointer
  fault_inject: Don't rely on "return value" from WRITE_ONCE()
  arm64: csum: Disable KASAN for do_csum()
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
 arch/arm64/lib/csum.c             |  20 +-
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
 net/tls/tls_main.c                |   2 +-
 scripts/Kconfig.include           |   6 +
 scripts/gcc-plugins/Kconfig       |   2 +-
 19 files changed, 126 insertions(+), 719 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

-- 
2.26.0.110.g2183baf09c-goog
