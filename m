From: James Hogan <jhogan@kernel.org>
Subject: [PATCH v3 3/3] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date: Tue, 17 Apr 2018 11:11:06 +0100
Message-ID: <fd3a82afd8817d4a221a8ed482df05abaf980bc6.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Matthew Fortune <matthew.fortune@mips.com>, Robert Suchanek <robert.suchanek@mips.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

Older versions of GCC for the MIPS architecture suffer from a bug which
can lead to instructions from beyond an unreachable statement being
incorrectly reordered into earlier branch delay slots if the unreachable
statement is the only content of a case in a switch statement. This can
lead to seemingly random behaviour, such as invalid memory accesses from
incorrectly reordered loads or stores, and link failures on microMIPS
builds.

See this potential GCC fix for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

This bug can be worked around by placing a volatile asm statement, which
GCC is prevented from reordering past, prior to the
__builtin_unreachable call. This was actually done for other reasons by
commit 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()"), but
without the MIPS specific .insn, which broke microMIPS builds on newer
GCC 7.2 toolchains with errors like the following:

    arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another ISA mode
    arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another ISA mode

The original bug affects at least a maltasmvp_defconfig kernel built
from the v4.4 tag using GCC 4.9.2 (from a Codescape SDK 2015.06-05
toolchain), with the result being an address exception taken after log
messages about the L1 caches (during probe of the L2 cache):

    Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
    VPE topology {2,2} total 4
    Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
    Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
    <AdEL exception here>

This is early enough that the kernel exception vectors are not in use,
so any further output depends upon the bootloader. This is reproducible
in QEMU where no further output occurs - ie. the system hangs here.
Given the nature of the bug it may potentially be hit with differing
symptoms.

Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
Signed-off-by: Paul Burton <paul.burton@mips.com>
[jhogan@kernel.org: Forward port and use asm/compiler.h instead of
 asm/compiler-gcc.h]
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Matthew Fortune <matthew.fortune@mips.com>
Cc: Robert Suchanek <robert.suchanek@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
---
This is an alternative approach to this earlier patch which seems to
have been rejected:

    https://patchwork.linux-mips.org/patch/12556/
    https://marc.info/?l=linux-mips&m=145555921408274&w=2

Changes in v3 (James):
- Forward port to v4.17-rc and update commit message.
- Drop stable tag for now.

Changes in v2 (Paul):
- Remove generic-y entry.
---
 arch/mips/include/asm/compiler.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index e081a265f422..ff2a412899d4 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -8,6 +8,29 @@
 #ifndef _ASM_COMPILER_H
 #define _ASM_COMPILER_H
 
+/*
+ * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
+ * 2016 suffer from a bug that can lead to instructions from beyond an
+ * unreachable statement being incorrectly reordered into earlier delay slots
+ * if the unreachable statement is the only content of a case in a switch
+ * statement. This can lead to seemingly random behaviour, such as invalid
+ * memory accesses from incorrectly reordered loads or stores. See this
+ * potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * We work around this by placing a volatile asm statement, which GCC is
+ * prevented from reordering past, prior to the __builtin_unreachable call. The
+ * .insn statement is required to ensure that any branches to the statement,
+ * which sadly must be kept due to the asm statement, are known to be branches
+ * to code and satisfy linker requirements for microMIPS kernels.
+ */
+#define barrier_before_unreachable() asm volatile(".insn")
+
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
 #define GCC_IMM_ASM() "n"
 #define GCC_REG_ACCUM "$0"
-- 
git-series 0.9.1
