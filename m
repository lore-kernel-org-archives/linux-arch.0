From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 00/11] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Date: Fri, 19 Apr 2019 18:47:43 +0900
Message-ID: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


Major changes in v2:
 - Eliminate more errors and warnings
 - Delete 'depends on !MIPS'
 - Split into separate patches

Arnd Bergmann (1):
  ARM: prevent tracing IPI_CPU_BACKTRACE

Masahiro Yamada (10):
  arm64: mark (__)cpus_have_const_cap as __always_inline
  MIPS: mark mult_sh_align_mod() as __always_inline
  s390/cpacf: mark scpacf_query() as __always_inline
  mtd: rawnand: vf610_nfc: add initializer to avoid
    -Wmaybe-uninitialized
  MIPS: mark __fls() as __always_inline
  ARM: mark setup_machine_tags() stub as __init __noreturn
  powerpc/prom_init: mark prom_getprop() and prom_getproplen() as __init
  powerpc/mm/radix: mark __radix__flush_tlb_range_psize() as
    __always_inline
  powerpc/mm/radix: mark as __tlbie_pid() and friends as__always_inline
  compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING

 arch/arm/include/asm/hardirq.h      |  1 +
 arch/arm/kernel/atags.h             |  2 +-
 arch/arm/kernel/smp.c               |  6 +++++-
 arch/arm64/include/asm/cpufeature.h |  4 ++--
 arch/mips/include/asm/bitops.h      |  2 +-
 arch/mips/kernel/cpu-bugs64.c       |  4 ++--
 arch/powerpc/kernel/prom_init.c     |  6 +++---
 arch/powerpc/mm/tlb-radix.c         | 12 ++++++------
 arch/s390/include/asm/cpacf.h       |  2 +-
 arch/x86/Kconfig                    |  3 ---
 arch/x86/Kconfig.debug              | 14 --------------
 drivers/mtd/nand/raw/vf610_nfc.c    |  2 +-
 include/linux/compiler_types.h      |  3 +--
 lib/Kconfig.debug                   | 14 ++++++++++++++
 14 files changed, 38 insertions(+), 37 deletions(-)

-- 
2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
