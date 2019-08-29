Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:42722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH2LS6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:58 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 0/7] vdso: Complete the conversion to 32bit syscalls
Date: Thu, 29 Aug 2019 12:18:36 +0100
Message-ID: <20190829111843.41003-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190829111836.jGD3qk5SKnT8HheaSJij8sXSkZsC485UYuF0NQUA10Q@z>

This patch series is a follow up to "lib/vdso, x86/vdso: Fix fallout
from generic VDSO conversion" [1].

The main purpose is to complete the 32bit vDSOs conversion to use the
legacy 32bit syscalls as a fallback. With the conversion of all the
architectures present in -next complete, this patch series removes as
well the conditional choice in between 32 and 64 bit for 32bit vDSOs.

This series has been rebased on linux-next/master.

[1] https://lkml.org/lkml/2019/7/28/86

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (7):
  arm64: compat: vdso: Expose BUILD_VDSO32
  lib: vdso: Build 32 bit specific functions in the right context
  mips: compat: vdso: Use legacy syscalls as fallback
  lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
  arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
  mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
  x86: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

 .../include/asm/vdso/compat_gettimeofday.h    |  2 +-
 arch/mips/include/asm/vdso/gettimeofday.h     | 43 +++++++++++++++++++
 arch/mips/vdso/config-n32-o32-env.c           |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h      |  2 -
 lib/vdso/gettimeofday.c                       | 14 ++----
 5 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.23.0
