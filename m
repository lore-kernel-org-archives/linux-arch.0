Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:49386
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeHRVT6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Aug 2018 17:19:58 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH v8 2/2] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date: Sat, 18 Aug 2018 11:10:17 -0700
Message-ID: <20180818181017.1246-3-paul.burton@mips.com>
In-Reply-To: <20180818181017.1246-1-paul.burton@mips.com>
References: <20180818181017.1246-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180818181017.BV0xcGDUPjzayZE184crv69o3oYhN5T8TRErjD3oB4U@z>

Some versions of GCC for the MIPS architecture suffer from a bug which
can lead to instructions from beyond an unreachable statement being
incorrectly reordered into earlier branch delay slots if the unreachable
statement is the only content of a case in a switch statement. This can
lead to seemingly random behaviour, such as invalid memory accesses from
incorrectly reordered loads or stores, and link failures on microMIPS
builds.

See this potential GCC fix for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

Runtime problems resulting from this bug were initially observed using a
maltasmvp_defconfig v4.4 kernel built using GCC 4.9.2 (from a Codescape
SDK 2015.06-05 toolchain), with the result being an address exception
taken after log messages about the L1 caches (during probe of the L2
cache):

    Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
    VPE topology {2,2} total 4
    Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
    Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
    <AdEL exception here>

This is early enough that the kernel exception vectors are not in use,
so any further output depends upon the bootloader. This is reproducible
in QEMU where no further output occurs - ie. the system hangs here.
Given the nature of the bug it may potentially be hit with differing
symptoms. The bug is known to affect GCC versions as recent as 7.3, and
it is unclear whether GCC 8 fixed it or just happens not to encounter
the bug in the testcase found at the link above due to differing
optimizations.

This bug can be worked around by placing a volatile asm statement, which
GCC is prevented from reordering past, prior to the
__builtin_unreachable call.

That was actually done already for other reasons by commit 173a3efd3edb
("bug.h: work around GCC PR82365 in BUG()"), but creates problems for
microMIPS builds due to the lack of a .insn directive. The microMIPS ISA
allows for interlinking with regular MIPS32 code by repurposing bit 0 of
the program counter as an ISA mode bit. To switch modes one changes the
value of this bit in the PC. However typical branch instructions encode
their offsets as multiples of 2-byte instruction halfwords, which means
they cannot change ISA mode - this must be done using either an indirect
branch (a jump-register in MIPS terminology) or a dedicated jalx
instruction. In order to ensure that regular branches don't attempt to
target code in a different ISA which they can't actually switch to, the
linker will check that branch targets are code in the same ISA as the
branch.

Unfortunately our empty asm volatile statements don't qualify as code,
and the link for microMIPS builds fails with errors such as:

    arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another ISA mode
    arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another ISA mode

Resolve this by adding a .insn directive within the asm statement which
declares that what comes next is code. This may or may not be true,
since we don't really know what comes next, but as this code is in an
unreachable path anyway that doesn't matter since we won't execute it.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org

---

Changes in v8:
- Move to asm/compiler_types.h to suit patch 1.
- Commit message improvements.
- Drop James' SoB since this changed a fair bit since he added it.

Changes in v7:
- Elaborate on affected GCC versions in comment.

Changes in v6: None

Changes in v5:
- Comment & commit message tweaks.

Changes in v4: None

Changes in v3:
- Forward port to v4.17-rc and update commit message.
- Drop stable tag for now.

Changes in v2:
- Remove generic-y entry.

 arch/mips/include/asm/compiler_types.h | 39 ++++++++++++++++++++++++++
 include/linux/compiler-gcc.h           |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/mips/include/asm/compiler_types.h

diff --git a/arch/mips/include/asm/compiler_types.h b/arch/mips/include/asm/compiler_types.h
new file mode 100644
index 000000000000..cecd5dc48ce2
--- /dev/null
+++ b/arch/mips/include/asm/compiler_types.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_COMPILER_TYPES_H__
+#define __ASM_COMPILER_TYPES_H__
+
+/*
+ * With GCC 4.5 onwards we can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately at least GCC 4.6.3 through 7.3.0 inclusive suffer from a bug
+ * that can lead to instructions from beyond an unreachable statement being
+ * incorrectly reordered into earlier delay slots if the unreachable statement
+ * is the only content of a case in a switch statement. This can lead to
+ * seemingly random behaviour, such as invalid memory accesses from incorrectly
+ * reordered loads or stores. See this potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * It is unclear whether GCC 8 onwards suffer from the same issue - nothing
+ * relevant is mentioned in GCC 8 release notes and nothing obviously relevant
+ * stands out in GCC commit logs, but these newer GCC versions generate very
+ * different code for the testcase which doesn't exhibit the bug.
+ *
+ * GCC also handles stack allocation suboptimally when calling noreturn
+ * functions or calling __builtin_unreachable():
+ *
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
+ *
+ * We work around both of these issues by placing a volatile asm statement,
+ * which GCC is prevented from reordering past, prior to __builtin_unreachable
+ * calls.
+ *
+ * The .insn statement is required to ensure that any branches to the
+ * statement, which sadly must be kept due to the asm statement, are known to
+ * be branches to code and satisfy linker requirements for microMIPS kernels.
+ */
+#define barrier_before_unreachable() asm volatile(".insn")
+
+#endif /* __ASM_COMPILER_TYPES_H__ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..354d40f7bf80 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -218,7 +218,9 @@
  *
  * Adding an empty inline assembly before it works around the problem
  */
+#ifndef barrier_before_unreachable
 #define barrier_before_unreachable() asm volatile("")
+#endif
 
 /*
  * Mark a position in code as unreachable.  This can be used to
-- 
2.18.0
