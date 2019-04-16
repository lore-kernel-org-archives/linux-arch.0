Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfDPQOw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Apr 2019 12:14:52 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 0/5] Fix vDSO clock_getres()
Date: Tue, 16 Apr 2019 17:14:29 +0100
Message-ID: <20190416161434.32691-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190416161429.4ds1kr-tEs_XROLN7wbitd6FeR4hOfGEd2KtiOwaLpI@z>

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

A possible fix is to change the vdso implementation of clock_getres,
keeping a copy of hrtimer_resolution in vdso data and using that
directly [1].

This patchset implements the proposed fix for arm64, powerpc, s390,
nds32 and adds a test to verify that the syscall and the vdso library
implementation of clock_getres return the same values.

Even if these patches are unified by the same topic, there is no
dependency between them, hence they can be merged singularly by each
arch maintainer.

[1] https://marc.info/?l=linux-arm-kernel&m=155110381930196&w=2

Changes:
--------
v2:
  - Rebased on 5.1-rc5.
  - Addressed review comments.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (5):
  arm64: Fix vDSO clock_getres()
  powerpc: Fix vDSO clock_getres()
  s390: Fix vDSO clock_getres()
  nds32: Fix vDSO clock_getres()
  kselftest: Extend vDSO selftest to clock_getres

 arch/arm64/include/asm/vdso_datapage.h        |   1 +
 arch/arm64/kernel/asm-offsets.c               |   2 +-
 arch/arm64/kernel/vdso.c                      |   2 +
 arch/arm64/kernel/vdso/gettimeofday.S         |  22 ++--
 arch/nds32/include/asm/vdso_datapage.h        |   1 +
 arch/nds32/kernel/vdso.c                      |   1 +
 arch/nds32/kernel/vdso/gettimeofday.c         |   4 +-
 arch/powerpc/include/asm/vdso_datapage.h      |   2 +
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/time.c                    |   1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S     |   7 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S     |   7 +-
 arch/s390/include/asm/vdso.h                  |   1 +
 arch/s390/kernel/asm-offsets.c                |   2 +-
 arch/s390/kernel/time.c                       |   1 +
 arch/s390/kernel/vdso32/clock_getres.S        |  12 +-
 arch/s390/kernel/vdso64/clock_getres.S        |  10 +-
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_clock_getres.c        | 108 ++++++++++++++++++
 19 files changed, 159 insertions(+), 29 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

-- 
2.21.0
