Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:46295 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932654AbeGIMr7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 08:47:59 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] atomic{64}_t: Explicitly specify data storage length and alignment
Date: Mon,  9 Jul 2018 15:47:41 +0300
Message-ID: <20180709124741.21037-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, David Laight <David.Laight@ACULAB.COM>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20180709124741.70-C4c91gC4KeAZGgAQ1l-rf4iOyDuqanDOmN7Co6U4@z>

Atomic instructions require data they operate on to be aligned
according to data size. I.e. 32-bit atomic values must be 32-bit
aligned while 64-bit values must be 64-bit aligned.

Otherwise even if CPU may handle not-aligend normal data access,
still atomic instructions fail and typically raise an exception
leaving us dead in the water.

This came-up during lengthly discussion here:
http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004022.html

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/atomic.h                                 | 2 +-
 include/asm-generic/atomic64.h                                | 2 +-
 include/linux/types.h                                         | 4 ++--
 tools/include/linux/types.h                                   | 2 +-
 tools/testing/selftests/futex/include/atomic.h                | 2 +-
 .../rcutorture/formal/srcu-cbmc/include/linux/types.h         | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 66d0e215a773..2ed6d7cf1407 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -267,7 +267,7 @@ ATOMIC_OPS(xor, ^=, eor)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
-	long long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i) { (i) }
diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 8d28eb010d0d..b94b749b5952 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -13,7 +13,7 @@
 #define _ASM_GENERIC_ATOMIC64_H
 
 typedef struct {
-	long long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 
 #define ATOMIC64_INIT(i)	{ (i) }
diff --git a/include/linux/types.h b/include/linux/types.h
index 9834e90aa010..e2f631782621 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -174,12 +174,12 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	u32 __aligned(4) counter;
 } atomic_t;
 
 #ifdef CONFIG_64BIT
 typedef struct {
-	long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 #endif
 
diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 154eb4e3ca7c..c913e26ea4eb 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -59,7 +59,7 @@ typedef __u64 __bitwise __le64;
 typedef __u64 __bitwise __be64;
 
 typedef struct {
-	int counter;
+	u32 __aligned(4) counter;
 } atomic_t;
 
 #ifndef __aligned_u64
diff --git a/tools/testing/selftests/futex/include/atomic.h b/tools/testing/selftests/futex/include/atomic.h
index f861da3e31ab..34e14295e492 100644
--- a/tools/testing/selftests/futex/include/atomic.h
+++ b/tools/testing/selftests/futex/include/atomic.h
@@ -23,7 +23,7 @@
 #define _ATOMIC_H
 
 typedef struct {
-	volatile int val;
+	volatile u32 __aligned(4) val;
 } atomic_t;
 
 #define ATOMIC_INITIALIZER { 0 }
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
index 891ad13e95b2..32ce965187b3 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
@@ -100,12 +100,12 @@ typedef phys_addr_t resource_size_t;
 typedef unsigned long irq_hw_number_t;
 
 typedef struct {
-	int counter;
+	u32 __aligned(4) counter;
 } atomic_t;
 
 #ifdef CONFIG_64BIT
 typedef struct {
-	long counter;
+	u64 __aligned(8) counter;
 } atomic64_t;
 #endif
 
-- 
2.17.1
