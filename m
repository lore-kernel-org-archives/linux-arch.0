From: James Hogan <jhogan@kernel.org>
Subject: [PATCH v3 2/3] compiler.h: Allow arch-specific overrides
Date: Tue, 17 Apr 2018 11:11:05 +0100
Message-ID: <cbf1a73e1c751fc8db124f974e268bab0d9727a5.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
In-Reply-To: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
References: <cover.ebc99f68d5063a817328b9184d747f539800cff0.1523959603.git-series.jhogan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

Include an arch-specific asm/compiler.h and allow for it to define a
custom version of barrier_before_unreachable(), which is needed to
workaround several issues on the MIPS architecture.

This patch includes an effectively empty asm-generic implementation of
asm/compiler.h for all architectures except alpha, arm, arm64, and mips
(which already have an asm/compiler.h) and leaves the architecture
specifics to a further patch.

Signed-off-by: Paul Burton <paul.burton@mips.com>
[jhogan@kernel.org: Forward port and use asm/compiler.h instead of
 asm/compiler-gcc.h]
Signed-off-by: James Hogan <jhogan@kernel.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
Changes in v3 (James):
- Rebase after 4.17 arch removal.
- Use asm/compiler.h instead of compiler-gcc.h (Arnd).
- Drop stable tag for now.

Changes in v2 (Paul):
- Add generic-y entries to arch Kbuild files. Oops!
---
 arch/arc/include/asm/Kbuild        | 1 +
 arch/c6x/include/asm/Kbuild        | 1 +
 arch/h8300/include/asm/Kbuild      | 1 +
 arch/hexagon/include/asm/Kbuild    | 1 +
 arch/ia64/include/asm/Kbuild       | 1 +
 arch/m68k/include/asm/Kbuild       | 1 +
 arch/microblaze/include/asm/Kbuild | 1 +
 arch/nds32/include/asm/Kbuild      | 1 +
 arch/nios2/include/asm/Kbuild      | 1 +
 arch/openrisc/include/asm/Kbuild   | 1 +
 arch/parisc/include/asm/Kbuild     | 1 +
 arch/powerpc/include/asm/Kbuild    | 1 +
 arch/riscv/include/asm/Kbuild      | 1 +
 arch/s390/include/asm/Kbuild       | 1 +
 arch/sh/include/asm/Kbuild         | 1 +
 arch/sparc/include/asm/Kbuild      | 1 +
 arch/um/include/asm/Kbuild         | 1 +
 arch/unicore32/include/asm/Kbuild  | 1 +
 arch/x86/include/asm/Kbuild        | 1 +
 arch/xtensa/include/asm/Kbuild     | 1 +
 include/asm-generic/compiler.h     | 8 ++++++++
 include/linux/compiler-gcc.h       | 2 ++
 include/linux/compiler_types.h     | 3 +++
 23 files changed, 33 insertions(+)
 create mode 100644 include/asm-generic/compiler.h

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 4bd5d4369e05..61ba443ad252 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += bugs.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index fd4c840de837..ddfa28f80955 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += atomic.h
 generic-y += barrier.h
 generic-y += bugs.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 14bac06b7116..bf06091a6034 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += barrier.h
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index e9743f689fb8..dccedfd7559e 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 6dd867873364..886bae7b001f 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compiler.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 88a9d27df1ac..089cd9b3c9fd 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += barrier.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 3c80a5a308ed..920ee0afc627 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += barrier.h
 generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 06bdf8167f5a..5536db1084f4 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += checksum.h
 generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += cmpxchg-local.h
+generic-y += compiler.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d232da2cbb38..7a351811b525 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += cmpxchg.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index f05c722a21f8..809c2e188884 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 2013d639e735..e458cba4f5ae 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += barrier.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 3196d227e351..636a1dae6adc 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compiler.h
 generic-y += div64.h
 generic-y += export.h
 generic-y += irq_regs.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 1e5fd280fb4d..58e8ed54a870 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
+generic-y += compiler.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e3239772887a..689993a319d6 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -6,6 +6,7 @@ generated-y += unistd_nr.h
 
 generic-y += asm-offsets.h
 generic-y += cacheflush.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 1efcce74997b..3074c98526bc 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,3 +1,4 @@
+generic-y += compiler.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index ac67828da201..d0b551d14ebd 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # User exported sparc header files
 
 
+generic-y += compiler.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index bb5a196c3061..ccf8a2f5cb08 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += barrier.h
 generic-y += bpf_perf_event.h
 generic-y += bug.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 6f70c76c81fc..a90a693da5c2 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -1,5 +1,6 @@
 generic-y += atomic.h
 generic-y += bugs.h
+generic-y += compiler.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index de690c2d2e33..de4246599536 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -6,6 +6,7 @@ generated-y += unistd_32_ia32.h
 generated-y += unistd_64_x32.h
 generated-y += xen-hypercalls.h
 
+generic-y += compiler.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 436b20337168..048341532d48 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += bug.h
+generic-y += compiler.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma-contiguous.h
diff --git a/include/asm-generic/compiler.h b/include/asm-generic/compiler.h
new file mode 100644
index 000000000000..64f920d745ce
--- /dev/null
+++ b/include/asm-generic/compiler.h
@@ -0,0 +1,8 @@
+#ifndef __LINUX_COMPILER_H
+#error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/*
+ * We have nothing architecture-specific to do here, simply leave everything to
+ * the generic linux/compiler.h.
+ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2c7f4369eff..2ff47f4efccb 100644
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
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..a20be5fce3c8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -54,6 +54,9 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 
 #ifdef __KERNEL__
 
+/* Allow architectures to override some definitions where necessary */
+#include <asm/compiler.h>
+
 #ifdef __GNUC__
 #include <linux/compiler-gcc.h>
 #endif
-- 
git-series 0.9.1
