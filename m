From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 08/33] locking,blackfin: Implement atomic_fetch_{add,sub,and,or,xor}()
Date: Tue, 31 May 2016 12:19:33 +0200
Message-ID: <20160531102641.947942866@infradead.org>
References: <20160531101925.702692792@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch-blackfin.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

Implement FETCH-OP atomic primitives, these are very similar to the
existing OP-RETURN primitives we already have, except they return the
value of the atomic variable _before_ modification.

This is especially useful for irreversible operations -- such as
bitops (because it becomes impossible to reconstruct the state prior
to modification).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/blackfin/include/asm/atomic.h |    8 ++++++
 arch/blackfin/kernel/bfin_ksyms.c  |    1 
 arch/blackfin/mach-bf561/atomic.S  |   43 ++++++++++++++++++++++++++-----------
 3 files changed, 40 insertions(+), 12 deletions(-)

--- a/arch/blackfin/include/asm/atomic.h
+++ b/arch/blackfin/include/asm/atomic.h
@@ -17,6 +17,7 @@
 
 asmlinkage int __raw_uncached_fetch_asm(const volatile int *ptr);
 asmlinkage int __raw_atomic_add_asm(volatile int *ptr, int value);
+asmlinkage int __raw_atomic_xadd_asm(volatile int *ptr, int value);
 
 asmlinkage int __raw_atomic_and_asm(volatile int *ptr, int value);
 asmlinkage int __raw_atomic_or_asm(volatile int *ptr, int value);
@@ -28,10 +29,17 @@ asmlinkage int __raw_atomic_test_asm(con
 #define atomic_add_return(i, v) __raw_atomic_add_asm(&(v)->counter, i)
 #define atomic_sub_return(i, v) __raw_atomic_add_asm(&(v)->counter, -(i))
 
+#define atomic_fetch_add(i, v) __raw_atomic_xadd_asm(&(v)->counter, i)
+#define atomic_fetch_sub(i, v) __raw_atomic_xadd_asm(&(v)->counter, -(i))
+
 #define atomic_or(i, v)  (void)__raw_atomic_or_asm(&(v)->counter, i)
 #define atomic_and(i, v) (void)__raw_atomic_and_asm(&(v)->counter, i)
 #define atomic_xor(i, v) (void)__raw_atomic_xor_asm(&(v)->counter, i)
 
+#define atomic_fetch_or(i, v)  __raw_atomic_or_asm(&(v)->counter, i)
+#define atomic_fetch_and(i, v) __raw_atomic_and_asm(&(v)->counter, i)
+#define atomic_fetch_xor(i, v) __raw_atomic_xor_asm(&(v)->counter, i)
+
 #endif
 
 #include <asm-generic/atomic.h>
--- a/arch/blackfin/kernel/bfin_ksyms.c
+++ b/arch/blackfin/kernel/bfin_ksyms.c
@@ -84,6 +84,7 @@ EXPORT_SYMBOL(insl_16);
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(__raw_atomic_add_asm);
+EXPORT_SYMBOL(__raw_atomic_xadd_asm);
 EXPORT_SYMBOL(__raw_atomic_and_asm);
 EXPORT_SYMBOL(__raw_atomic_or_asm);
 EXPORT_SYMBOL(__raw_atomic_xor_asm);
--- a/arch/blackfin/mach-bf561/atomic.S
+++ b/arch/blackfin/mach-bf561/atomic.S
@@ -607,6 +607,28 @@ ENDPROC(___raw_atomic_add_asm)
 
 /*
  * r0 = ptr
+ * r1 = value
+ *
+ * ADD a signed value to a 32bit word and return the old value atomically.
+ * Clobbers: r3:0, p1:0
+ */
+ENTRY(___raw_atomic_xadd_asm)
+	p1 = r0;
+	r3 = r1;
+	[--sp] = rets;
+	call _get_core_lock;
+	r3 = [p1];
+	r2 = r3 + r2;
+	[p1] = r2;
+	r1 = p1;
+	call _put_core_lock;
+	r0 = r3;
+	rets = [sp++];
+	rts;
+ENDPROC(___raw_atomic_add_asm)
+
+/*
+ * r0 = ptr
  * r1 = mask
  *
  * AND the mask bits from a 32bit word and return the old 32bit value
@@ -618,10 +640,9 @@ ENTRY(___raw_atomic_and_asm)
 	r3 = r1;
 	[--sp] = rets;
 	call _get_core_lock;
-	r2 = [p1];
-	r3 = r2 & r3;
-	[p1] = r3;
-	r3 = r2;
+	r3 = [p1];
+	r2 = r2 & r3;
+	[p1] = r2;
 	r1 = p1;
 	call _put_core_lock;
 	r0 = r3;
@@ -642,10 +663,9 @@ ENTRY(___raw_atomic_or_asm)
 	r3 = r1;
 	[--sp] = rets;
 	call _get_core_lock;
-	r2 = [p1];
-	r3 = r2 | r3;
-	[p1] = r3;
-	r3 = r2;
+	r3 = [p1];
+	r2 = r2 | r3;
+	[p1] = r2;
 	r1 = p1;
 	call _put_core_lock;
 	r0 = r3;
@@ -666,10 +686,9 @@ ENTRY(___raw_atomic_xor_asm)
 	r3 = r1;
 	[--sp] = rets;
 	call _get_core_lock;
-	r2 = [p1];
-	r3 = r2 ^ r3;
-	[p1] = r3;
-	r3 = r2;
+	r3 = [p1];
+	r2 = r2 ^ r3;
+	[p1] = r2;
 	r1 = p1;
 	call _put_core_lock;
 	r0 = r3;
