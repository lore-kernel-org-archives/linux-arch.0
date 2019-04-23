Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:57403 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfDWDWf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Apr 2019 23:22:35 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 00/10] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Date: Tue, 23 Apr 2019 12:20:56 +0900
Message-ID: <20190423032106.11960-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Mathieu Malaterre <malat@debian.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20190423032056.RmtWz2ypIXSixXNpzEfA7D5OWD-B24JGCidnKibRtsQ@z>

Major changes in v3:
 - Fix link error for arch/mips/configs/ci20_defconfig

Major changes in v2:
 - Eliminate more errors and warnings
 - Delete 'depends on !MIPS'
 - Split into separate patches

Masahiro Yamada (10):
  arm64: mark (__)cpus_have_const_cap as __always_inline
  MIPS: mark mult_sh_align_mod() as __always_inline
  s390/cpacf: mark scpacf_query() as __always_inline
  mtd: rawnand: vf610_nfc: add initializer to avoid
    -Wmaybe-uninitialized
  MIPS: mark __fls() and __ffs() as __always_inline
  ARM: mark setup_machine_tags() stub as __init __noreturn
  powerpc/prom_init: mark prom_getprop() and prom_getproplen() as __init
  powerpc/mm/radix: mark __radix__flush_tlb_range_psize() as
    __always_inline
  powerpc/mm/radix: mark as __tlbie_pid() and friends as__always_inline
  compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING

 arch/arm/kernel/atags.h             |  2 +-
 arch/arm64/include/asm/cpufeature.h |  4 ++--
 arch/mips/include/asm/bitops.h      |  4 ++--
 arch/mips/kernel/cpu-bugs64.c       |  4 ++--
 arch/powerpc/kernel/prom_init.c     |  6 +++---
 arch/powerpc/mm/tlb-radix.c         | 12 ++++++------
 arch/s390/include/asm/cpacf.h       |  2 +-
 arch/x86/Kconfig                    |  3 ---
 arch/x86/Kconfig.debug              | 14 --------------
 drivers/mtd/nand/raw/vf610_nfc.c    |  2 +-
 include/linux/compiler_types.h      |  3 +--
 lib/Kconfig.debug                   | 14 ++++++++++++++
 12 files changed, 33 insertions(+), 37 deletions(-)

-- 
2.17.1
