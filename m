From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 0/8] vdso: Complete the conversion to 32bit syscalls
Date: Fri, 30 Aug 2019 14:58:54 +0100
Message-ID: <20190830135902.20861-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
List-Id: linux-arch.vger.kernel.org

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

Vincenzo Frascino (8):
  arm64: compat: vdso: Expose BUILD_VDSO32
  lib: vdso: Build 32 bit specific functions in the right context
  mips: compat: vdso: Use legacy syscalls as fallback
  lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
  lib: vdso: Remove checks on return value for 32 bit vDSO
  arm64: compat: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
  mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
  x86: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK

 .../include/asm/vdso/compat_gettimeofday.h    |  2 +-
 arch/mips/include/asm/vdso/gettimeofday.h     | 43 +++++++++++++++++++
 arch/mips/vdso/config-n32-o32-env.c           |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h      |  2 -
 lib/vdso/gettimeofday.c                       | 30 ++++++-------
 5 files changed, 57 insertions(+), 21 deletions(-)

-- 
2.23.0
