From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 1/2] compiler-gcc: Allow arch-specific override of unreachable
Date: Fri, 27 May 2016 16:45:26 +0100
Message-ID: <20160527154527.6806-1-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>, "# v4 . 4+" <stable@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Include an arch-specific asm/compiler-gcc.h and allow for it to define a
custom version of unreachable(), which is needed to workaround a bug in
current versions of GCC for the MIPS architecture. This patch includes
an effectively empty asm-generic implementation of asm/compiler-gcc.h &
leaves the architecture specifics to a further patch.

Marked for stable as far back as v4.4 such that the MIPS patch depending
upon it can be backported too.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.4+
---
Changes in v2:
- Add generic-y entries to arch Kbuild files. Oops!
---
 arch/alpha/include/asm/Kbuild      | 1 +
 arch/arc/include/asm/Kbuild        | 1 +
 arch/arm/include/asm/Kbuild        | 1 +
 arch/arm64/include/asm/Kbuild      | 1 +
 arch/avr32/include/asm/Kbuild      | 1 +
 arch/blackfin/include/asm/Kbuild   | 1 +
 arch/c6x/include/asm/Kbuild        | 1 +
 arch/cris/include/asm/Kbuild       | 1 +
 arch/frv/include/asm/Kbuild        | 1 +
 arch/h8300/include/asm/Kbuild      | 1 +
 arch/hexagon/include/asm/Kbuild    | 1 +
 arch/ia64/include/asm/Kbuild       | 1 +
 arch/m32r/include/asm/Kbuild       | 1 +
 arch/m68k/include/asm/Kbuild       | 1 +
 arch/metag/include/asm/Kbuild      | 1 +
 arch/microblaze/include/asm/Kbuild | 1 +
 arch/mips/include/asm/Kbuild       | 1 +
 arch/mn10300/include/asm/Kbuild    | 1 +
 arch/nios2/include/asm/Kbuild      | 1 +
 arch/openrisc/include/asm/Kbuild   | 1 +
 arch/parisc/include/asm/Kbuild     | 1 +
 arch/powerpc/include/asm/Kbuild    | 1 +
 arch/s390/include/asm/Kbuild       | 1 +
 arch/score/include/asm/Kbuild      | 1 +
 arch/sh/include/asm/Kbuild         | 1 +
 arch/sparc/include/asm/Kbuild      | 1 +
 arch/tile/include/asm/Kbuild       | 1 +
 arch/um/include/asm/Kbuild         | 1 +
 arch/unicore32/include/asm/Kbuild  | 1 +
 arch/x86/include/asm/Kbuild        | 1 +
 arch/xtensa/include/asm/Kbuild     | 1 +
 include/asm-generic/compiler-gcc.h | 8 ++++++++
 include/linux/compiler-gcc.h       | 7 ++++++-
 33 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/compiler-gcc.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index ffd9cf5..94b962d 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += exec.h
 generic-y += irq_work.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 0b10ef2..ea3febf 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 55e0e3e..071fb46 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -2,6 +2,7 @@
 
 generic-y += bitsperlong.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += early_ioremap.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index cff532a..4dc925a 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/avr32/include/asm/Kbuild b/arch/avr32/include/asm/Kbuild
index 241b9b9..de29503 100644
--- a/arch/avr32/include/asm/Kbuild
+++ b/arch/avr32/include/asm/Kbuild
@@ -1,5 +1,6 @@
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += delay.h
 generic-y += device.h
diff --git a/arch/blackfin/include/asm/Kbuild b/arch/blackfin/include/asm/Kbuild
index 91d49c0..a53e643 100644
--- a/arch/blackfin/include/asm/Kbuild
+++ b/arch/blackfin/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += bugs.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 64465e7..64f709b 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += barrier.h
 generic-y += bitsperlong.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index 1778805..d52d996 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += barrier.h
 generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += cmpxchg.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/frv/include/asm/Kbuild b/arch/frv/include/asm/Kbuild
index 1fa084c..213d33d 100644
--- a/arch/frv/include/asm/Kbuild
+++ b/arch/frv/include/asm/Kbuild
@@ -1,5 +1,6 @@
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += exec.h
 generic-y += irq_work.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 373cb23..2b2cad6 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += bugs.h
 generic-y += cacheflush.h
 generic-y += checksum.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index db8ddab..66c3a759 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 502a91d..cc6a991 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,5 +1,6 @@
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += exec.h
 generic-y += irq_work.h
 generic-y += kvm_para.h
diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index 860e440..e06a38f 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -1,5 +1,6 @@
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += exec.h
 generic-y += irq_work.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index eb85bd9..2624c10 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += barrier.h
 generic-y += bitsperlong.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += emergency-restart.h
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
index 29acb89d..aae290e 100644
--- a/arch/metag/include/asm/Kbuild
+++ b/arch/metag/include/asm/Kbuild
@@ -2,6 +2,7 @@ generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index b0ae88c..4e91bad 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 generic-y += barrier.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += exec.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index c7fe4d0..9ccb519 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # MIPS headers
 generic-(CONFIG_GENERIC_CSUM) += checksum.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += dma-contiguous.h
diff --git a/arch/mn10300/include/asm/Kbuild b/arch/mn10300/include/asm/Kbuild
index 1c8dd0f..9bcf3f5 100644
--- a/arch/mn10300/include/asm/Kbuild
+++ b/arch/mn10300/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 generic-y += barrier.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += exec.h
 generic-y += irq_work.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index d63330e..16fd572 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += bitsperlong.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 2832f03..27be320 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -12,6 +12,7 @@ generic-y += checksum.h
 generic-y += clkdev.h
 generic-y += cmpxchg-local.h
 generic-y += cmpxchg.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index f9b3a81..4f2cdd1 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -2,6 +2,7 @@
 generic-y += auxvec.h
 generic-y += barrier.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index ab9f4e0..23116ca 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -1,4 +1,5 @@
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += div64.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 9043d2e..22e1921 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/score/include/asm/Kbuild b/arch/score/include/asm/Kbuild
index a05218f..b2277b6 100644
--- a/arch/score/include/asm/Kbuild
+++ b/arch/score/include/asm/Kbuild
@@ -4,6 +4,7 @@ header-y +=
 
 generic-y += barrier.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index a319745..9c15552 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,6 +1,7 @@
 
 generic-y += bitsperlong.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index e9286188..d36f1ca 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -2,6 +2,7 @@
 
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index ba35c41..969d85c 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -4,6 +4,7 @@ header-y += ../arch/
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 904f3eb..dcae7de 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += barrier.h
 generic-y += bug.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 256c45b..d24f77b 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += bugs.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += current.h
 generic-y += device.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index aeac434..5b8fe8b 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -5,6 +5,7 @@ genhdr-y += unistd_64.h
 genhdr-y += unistd_x32.h
 
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index b56855a..2320040 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,6 +1,7 @@
 generic-y += bitsperlong.h
 generic-y += bug.h
 generic-y += clkdev.h
+generic-y += compiler-gcc.h
 generic-y += cputime.h
 generic-y += div64.h
 generic-y += emergency-restart.h
diff --git a/include/asm-generic/compiler-gcc.h b/include/asm-generic/compiler-gcc.h
new file mode 100644
index 0000000..e8ba230
--- /dev/null
+++ b/include/asm-generic/compiler-gcc.h
@@ -0,0 +1,8 @@
+#ifndef __LINUX_COMPILER_H
+#error "Please don't include <asm/compiler.gcc.h> directly, include <linux/compiler.h> instead."
+#endif
+
+/*
+ * We have nothing architecture-specific to do here, simply leave everything to
+ * the generic linux/compiler-gcc.h.
+ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3d5202e..e556cb8 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -9,6 +9,9 @@
 		     + __GNUC_MINOR__ * 100	\
 		     + __GNUC_PATCHLEVEL__)
 
+/* Allow architectures to override some definitions where necessary */
+#include <asm/compiler-gcc.h>
+
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
@@ -196,7 +199,9 @@
  * this in the preprocessor, but we can live with this because they're
  * unreleased.  Really, we need to have autoconf for the kernel.
  */
-#define unreachable() __builtin_unreachable()
+#ifndef unreachable
+# define unreachable() __builtin_unreachable()
+#endif
 
 /* Mark a function definition as prohibited from being cloned. */
 #define __noclone	__attribute__((__noclone__, __optimize__("no-tracer")))
-- 
2.8.3
