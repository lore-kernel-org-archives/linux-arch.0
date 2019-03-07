Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:59207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfCGQFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 11:05:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/4] vdso fixups
Date: Thu,  7 Mar 2019 17:05:28 +0100
Message-Id: <20190307160532.3328288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Hi Vincento,

Here are a couple more patches that I had to apply on top of your series
to get the combined vdso to build cleanly in all randconfig configurations.

Unfortunately, I haven't managed to build the arm64 compat vdso at
all here, so there may be additional patches needed for that.

      Arnd

Arnd Bergmann (4):
  vdso: ARM: fix building without ARM_ARCH_TIMER
  x86: vdso: fix compat_vdso build
  vdso: arm: use __iter_div_u64_rem() for 64-bit division
  arm64: vdso: turn off profiling etc

 arch/arm/include/asm/vdso/gettimeofday.h |  4 ++
 arch/arm/kernel/vdso.c                   |  7 +--
 arch/arm64/kernel/vdso/Makefile          |  6 ++
 arch/x86/include/asm/mshyperv-tsc.h      | 76 ++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h          | 70 +---------------------
 arch/x86/include/asm/pvclock.h           |  2 +-
 arch/x86/include/asm/vdso/gettimeofday.h |  2 +-
 arch/x86/include/asm/vgtod.h             |  2 +-
 arch/x86/kernel/pvclock.c                |  1 +
 include/linux/hrtimer.h                  | 15 +----
 include/linux/hrtimer_defs.h             | 25 ++++++++
 lib/vdso/gettimeofday.c                  |  3 +-
 12 files changed, 121 insertions(+), 92 deletions(-)
 create mode 100644 arch/x86/include/asm/mshyperv-tsc.h
 create mode 100644 include/linux/hrtimer_defs.h

-- 
2.20.0
