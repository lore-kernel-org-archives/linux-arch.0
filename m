Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfAGBCc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jan 2019 20:02:32 -0500
Date: Sun, 06 Jan 2019 17:02:30 -0800
From: akpm@linux-foundation.org
Subject: [merged] fls-change-parameter-to-unsigned-int.patch
 removed from -mm tree
Message-ID: <20190107010230.ormZEvzjH%akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: geert@linux-m68k.org, linux-arch@vger.kernel.org, mm-commits@vger.kernel.org, tglx@linutronix.de, willy@infradead.org


The patch titled
     Subject: fls: change parameter to unsigned int
has been removed from the -mm tree.  Its filename was
     fls-change-parameter-to-unsigned-int.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
From: Matthew Wilcox <willy@infradead.org>
Subject: fls: change parameter to unsigned int

When testing in userspace, UBSAN pointed out that shifting into the sign
bit is undefined behaviour.  It doesn't really make sense to ask for the
highest set bit of a negative value, so just turn the argument type into
an unsigned int.

Some architectures (eg ppc) already had it declared as an unsigned int, so
I don't expect too many problems.

Link: http://lkml.kernel.org/r/20181105221117.31828-1-willy@infradead.org
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/alpha/include/asm/bitops.h          |    4 ++--
 arch/arc/include/asm/bitops.h            |    4 ++--
 arch/c6x/include/asm/bitops.h            |    2 +-
 arch/csky/include/asm/bitops.h           |    2 +-
 arch/hexagon/include/asm/bitops.h        |    2 +-
 arch/ia64/include/asm/bitops.h           |    3 +--
 arch/m68k/include/asm/bitops.h           |    2 +-
 arch/mips/include/asm/bitops.h           |    2 +-
 arch/openrisc/include/asm/bitops/fls.h   |    2 +-
 arch/parisc/include/asm/bitops.h         |    2 +-
 arch/s390/include/asm/bitops.h           |    4 ++--
 arch/unicore32/include/asm/bitops.h      |    2 +-
 arch/x86/include/asm/bitops.h            |    2 +-
 include/asm-generic/bitops/builtin-fls.h |    2 +-
 include/asm-generic/bitops/fls.h         |    2 +-
 tools/include/asm-generic/bitops/fls.h   |    2 +-
 16 files changed, 19 insertions(+), 20 deletions(-)

--- a/arch/alpha/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/alpha/include/asm/bitops.h
@@ -391,9 +391,9 @@ static inline unsigned long __fls(unsign
 	return fls64(x) - 1;
 }
 
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
-	return fls64((unsigned int) x);
+	return fls64(x);
 }
 
 /*
--- a/arch/arc/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/arc/include/asm/bitops.h
@@ -278,7 +278,7 @@ static inline __attribute__ ((const)) in
 	return res;
 }
 
-static inline int constant_fls(int x)
+static inline int constant_fls(unsigned int x)
 {
 	int r = 32;
 
@@ -312,7 +312,7 @@ static inline int constant_fls(int x)
  * @result: [1-32]
  * fls(1) = 1, fls(0x80000000) = 32, fls(0) = 0
  */
-static inline __attribute__ ((const)) int fls(unsigned long x)
+static inline __attribute__ ((const)) int fls(unsigned int x)
 {
 	if (__builtin_constant_p(x))
 	       return constant_fls(x);
--- a/arch/c6x/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/c6x/include/asm/bitops.h
@@ -54,7 +54,7 @@ static inline unsigned long __ffs(unsign
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	if (!x)
 		return 0;
--- a/arch/csky/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/csky/include/asm/bitops.h
@@ -40,7 +40,7 @@ static __always_inline unsigned long __f
 /*
  * asm-generic/bitops/fls.h
  */
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	asm volatile(
 		"ff1 %0\n"
--- a/arch/hexagon/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int r;
 
--- a/arch/ia64/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/ia64/include/asm/bitops.h
@@ -388,8 +388,7 @@ ia64_fls (unsigned long x)
  * Find the last (most significant) bit set.  Returns 0 for x==0 and
  * bits are numbered from 1..32 (e.g., fls(9) == 4).
  */
-static inline int
-fls (int t)
+static inline int fls(unsigned int t)
 {
 	unsigned long x = t & 0xffffffffu;
 
--- a/arch/m68k/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/m68k/include/asm/bitops.h
@@ -502,7 +502,7 @@ static inline unsigned long __ffs(unsign
 /*
  *	fls: find last bit set.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int cnt;
 
--- a/arch/mips/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/mips/include/asm/bitops.h
@@ -555,7 +555,7 @@ static inline unsigned long __ffs(unsign
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int r;
 
--- a/arch/openrisc/include/asm/bitops/fls.h~fls-change-parameter-to-unsigned-int
+++ a/arch/openrisc/include/asm/bitops/fls.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_OPENRISC_HAVE_INST_FL1
 
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int ret;
 
--- a/arch/parisc/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/parisc/include/asm/bitops.h
@@ -188,7 +188,7 @@ static __inline__ int ffs(int x)
  * fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __inline__ int fls(int x)
+static __inline__ int fls(unsigned int x)
 {
 	int ret;
 	if (!x)
--- a/arch/s390/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/s390/include/asm/bitops.h
@@ -397,9 +397,9 @@ static inline int fls64(unsigned long wo
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(int word)
+static inline int fls(unsigned int word)
 {
-	return fls64((unsigned int)word);
+	return fls64(word);
 }
 
 #else /* CONFIG_HAVE_MARCH_Z9_109_FEATURES */
--- a/arch/unicore32/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/unicore32/include/asm/bitops.h
@@ -22,7 +22,7 @@
  * the cntlz instruction for much better code efficiency.
  */
 
-static inline int fls(int x)
+static inline int fls(unsigned int x)
 {
 	int ret;
 
--- a/arch/x86/include/asm/bitops.h~fls-change-parameter-to-unsigned-int
+++ a/arch/x86/include/asm/bitops.h
@@ -448,7 +448,7 @@ static __always_inline int ffs(int x)
  * set bit if value is nonzero. The last (most significant) bit is
  * at position 32.
  */
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r;
 
--- a/include/asm-generic/bitops/builtin-fls.h~fls-change-parameter-to-unsigned-int
+++ a/include/asm-generic/bitops/builtin-fls.h
@@ -9,7 +9,7 @@
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
 }
--- a/include/asm-generic/bitops/fls.h~fls-change-parameter-to-unsigned-int
+++ a/include/asm-generic/bitops/fls.h
@@ -10,7 +10,7 @@
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r = 32;
 
--- a/tools/include/asm-generic/bitops/fls.h~fls-change-parameter-to-unsigned-int
+++ a/tools/include/asm-generic/bitops/fls.h
@@ -10,7 +10,7 @@
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int fls(int x)
+static __always_inline int fls(unsigned int x)
 {
 	int r = 32;
 
_

Patches currently in -mm which might be from willy@infradead.org are

initialise-mmu_notifier_range-correctly.patch
mm-remove-sysctl_extfrag_handler.patch
