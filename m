From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 06/24] blackfin: Provide atomic_{or,xor,and}
Date: Thu, 09 Jul 2015 19:29:01 +0200
Message-ID: <20150709175308.550556715@infradead.org>
References: <20150709172855.564686637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59874 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbbGIR4u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 13:56:50 -0400
Content-Disposition: inline; filename=peterz-blackfin-atomic_logic_ops.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, mingo@kernel.org, peterz@infradead.org

Implement atomic logic ops -- atomic_{or,xor,and}.

These will replace the atomic_{set,clear}_mask functions that are
available on some archs.

TODO: use inline asm or at least asm macros to collapse the lot.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/blackfin/include/asm/atomic.h |   26 +++++++++++++++++++-------
 arch/blackfin/kernel/bfin_ksyms.c  |    7 ++++---
 arch/blackfin/mach-bf561/atomic.S  |   30 +++++++++++++++---------------
 3 files changed, 38 insertions(+), 25 deletions(-)

--- a/arch/blackfin/include/asm/atomic.h
+++ b/arch/blackfin/include/asm/atomic.h
@@ -16,19 +16,31 @@
 #include <linux/types.h>
 
 asmlinkage int __raw_uncached_fetch_asm(const volatile int *ptr);
-asmlinkage int __raw_atomic_update_asm(volatile int *ptr, int value);
-asmlinkage int __raw_atomic_clear_asm(volatile int *ptr, int value);
-asmlinkage int __raw_atomic_set_asm(volatile int *ptr, int value);
+asmlinkage int __raw_atomic_add_asm(volatile int *ptr, int value);
+
+asmlinkage int __raw_atomic_and_asm(volatile int *ptr, int value);
+asmlinkage int __raw_atomic_or_asm(volatile int *ptr, int value);
 asmlinkage int __raw_atomic_xor_asm(volatile int *ptr, int value);
 asmlinkage int __raw_atomic_test_asm(const volatile int *ptr, int value);
 
 #define atomic_read(v) __raw_uncached_fetch_asm(&(v)->counter)
 
-#define atomic_add_return(i, v) __raw_atomic_update_asm(&(v)->counter, i)
-#define atomic_sub_return(i, v) __raw_atomic_update_asm(&(v)->counter, -(i))
+#define atomic_add_return(i, v) __raw_atomic_add_asm(&(v)->counter, i)
+#define atomic_sub_return(i, v) __raw_atomic_add_asm(&(v)->counter, -(i))
 
-#define atomic_clear_mask(m, v) __raw_atomic_clear_asm(&(v)->counter, m)
-#define atomic_set_mask(m, v)   __raw_atomic_set_asm(&(v)->counter, m)
+#define atomic_or(i, v)  (void)__raw_atomic_or_asm(&(v)->counter, i)
+#define atomic_and(i, v) (void)__raw_atomic_and_asm(&(v)->counter, i)
+#define atomic_xor(i, v) (void)__raw_atomic_xor_asm(&(v)->counter, i)
+
+static inline __deprecated void atomic_clear_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_and(~mask, v);
+}
+
+static inline __deprecated void atomic_set_mask(unsigned int mask, atomic_t *v)
+{
+	atomic_or(mask, v);
+}
 
 #endif
 
--- a/arch/blackfin/kernel/bfin_ksyms.c
+++ b/arch/blackfin/kernel/bfin_ksyms.c
@@ -83,11 +83,12 @@ EXPORT_SYMBOL(insl);
 EXPORT_SYMBOL(insl_16);
 
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(__raw_atomic_update_asm);
-EXPORT_SYMBOL(__raw_atomic_clear_asm);
-EXPORT_SYMBOL(__raw_atomic_set_asm);
+EXPORT_SYMBOL(__raw_atomic_add_asm);
+EXPORT_SYMBOL(__raw_atomic_and_asm);
+EXPORT_SYMBOL(__raw_atomic_or_asm);
 EXPORT_SYMBOL(__raw_atomic_xor_asm);
 EXPORT_SYMBOL(__raw_atomic_test_asm);
+
 EXPORT_SYMBOL(__raw_xchg_1_asm);
 EXPORT_SYMBOL(__raw_xchg_2_asm);
 EXPORT_SYMBOL(__raw_xchg_4_asm);
--- a/arch/blackfin/mach-bf561/atomic.S
+++ b/arch/blackfin/mach-bf561/atomic.S
@@ -587,10 +587,10 @@ ENDPROC(___raw_write_unlock_asm)
  * r0 = ptr
  * r1 = value
  *
- * Add a signed value to a 32bit word and return the new value atomically.
+ * ADD a signed value to a 32bit word and return the new value atomically.
  * Clobbers: r3:0, p1:0
  */
-ENTRY(___raw_atomic_update_asm)
+ENTRY(___raw_atomic_add_asm)
 	p1 = r0;
 	r3 = r1;
 	[--sp] = rets;
@@ -603,19 +603,19 @@ ENTRY(___raw_atomic_update_asm)
 	r0 = r3;
 	rets = [sp++];
 	rts;
-ENDPROC(___raw_atomic_update_asm)
+ENDPROC(___raw_atomic_add_asm)
 
 /*
  * r0 = ptr
  * r1 = mask
  *
- * Clear the mask bits from a 32bit word and return the old 32bit value
+ * AND the mask bits from a 32bit word and return the old 32bit value
  * atomically.
  * Clobbers: r3:0, p1:0
  */
-ENTRY(___raw_atomic_clear_asm)
+ENTRY(___raw_atomic_and_asm)
 	p1 = r0;
-	r3 = ~r1;
+	r3 = r1;
 	[--sp] = rets;
 	call _get_core_lock;
 	r2 = [p1];
@@ -627,17 +627,17 @@ ENTRY(___raw_atomic_clear_asm)
 	r0 = r3;
 	rets = [sp++];
 	rts;
-ENDPROC(___raw_atomic_clear_asm)
+ENDPROC(___raw_atomic_and_asm)
 
 /*
  * r0 = ptr
  * r1 = mask
  *
- * Set the mask bits into a 32bit word and return the old 32bit value
+ * OR the mask bits into a 32bit word and return the old 32bit value
  * atomically.
  * Clobbers: r3:0, p1:0
  */
-ENTRY(___raw_atomic_set_asm)
+ENTRY(___raw_atomic_or_asm)
 	p1 = r0;
 	r3 = r1;
 	[--sp] = rets;
@@ -651,7 +651,7 @@ ENTRY(___raw_atomic_set_asm)
 	r0 = r3;
 	rets = [sp++];
 	rts;
-ENDPROC(___raw_atomic_set_asm)
+ENDPROC(___raw_atomic_or_asm)
 
 /*
  * r0 = ptr
@@ -787,7 +787,7 @@ ENTRY(___raw_bit_set_asm)
 	r2 = r1;
 	r1 = 1;
 	r1 <<= r2;
-	jump ___raw_atomic_set_asm
+	jump ___raw_atomic_or_asm
 ENDPROC(___raw_bit_set_asm)
 
 /*
@@ -798,10 +798,10 @@ ENDPROC(___raw_bit_set_asm)
  * Clobbers: r3:0, p1:0
  */
 ENTRY(___raw_bit_clear_asm)
-	r2 = r1;
-	r1 = 1;
-	r1 <<= r2;
-	jump ___raw_atomic_clear_asm
+	r2 = 1;
+	r2 <<= r1;
+	r1 = ~r2;
+	jump ___raw_atomic_and_asm
 ENDPROC(___raw_bit_clear_asm)
 
 /*
