Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269310AbUH0Gl5@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:12189 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269080AbUH0Glv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Aug 2004 02:41:51 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i7R6fo116524
	for <linux-arch@vger.kernel.org>; Thu, 26 Aug 2004 23:41:50 -0700
Date: Thu, 26 Aug 2004 23:40:05 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: using-get_cycles-for-add_timer_randomness.patch
Message-Id: <20040826234005.2afdb353.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


What's the status of this?  Is it a showstopper for MIPS?


From: Anton Blanchard <anton@samba.org>

I tested how long it took to do a dd from /dev/random on ppc64 before and
after this patch, while doing a ping flood from another machine.

before:
# /usr/bin/time dd if=/dev/random of=/dev/zero count=1k
0+51 records in
Command terminated by signal 2
0.00user 0.00system 19:18.46elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

I gave up after 19 minutes.

after:
# /usr/bin/time dd if=/dev/random of=/dev/zero count=1k
0+1024 records in
0.00user 0.00system 0:33.38elapsed 0%CPU (0avgtext+0avgdata 0maxresident)k

Just over 33 seconds. Better.

From: Arnd Bergmann <arnd@arndb.de>

I noticed that only i386 and x86-64 are currently using a high resolution
timer source when adding randomness.  Since many architectures have a
working get_cycles() implementation, it seems rather straightforward to use
that.

Has this been discussed before, or can anyone comment on the implementation
below?

This patch attempts to take into account the size of cycles_t, which is
either 32 or 64 bits wide but independent of the architecture's word size.

The behavior should be nearly identical to the old one on i386, x86-64 and
all architectures without a time stamp counter, while finding more entropy
on the other architectures.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/random.c    |   31 ++++++++++++-------------------
 25-akpm/include/asm-i386/timex.h |   13 ++++++++-----
 2 files changed, 20 insertions(+), 24 deletions(-)

diff -puN drivers/char/random.c~using-get_cycles-for-add_timer_randomness drivers/char/random.c
--- 25/drivers/char/random.c~using-get_cycles-for-add_timer_randomness	2004-08-23 22:02:34.353713704 -0700
+++ 25-akpm/drivers/char/random.c	2004-08-23 22:03:04.368150816 -0700
@@ -781,8 +781,8 @@ static void batch_entropy_process(void *
 
 /* There is one of these per entropy source */
 struct timer_rand_state {
-	__u32		last_time;
-	__s32		last_delta,last_delta2;
+	cycles_t	last_time;
+	long		last_delta,last_delta2;
 	unsigned	dont_count_entropy:1;
 };
 
@@ -799,14 +799,12 @@ static struct timer_rand_state *irq_time
  * The number "num" is also added to the pool - it should somehow describe
  * the type of event which just happened.  This is currently 0-255 for
  * keyboard scan codes, and 256 upwards for interrupts.
- * On the i386, this is assumed to be at most 16 bits, and the high bits
- * are used for a high-resolution timer.
  *
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	__u32		time;
-	__s32		delta, delta2, delta3;
+	cycles_t	time;
+	long		delta, delta2, delta3;
 	int		entropy = 0;
 
 	/* if over the trickle threshold, use only 1 in 4096 samples */
@@ -814,22 +812,17 @@ static void add_timer_randomness(struct 
 	     (__get_cpu_var(trickle_count)++ & 0xfff))
 		return;
 
-#if defined (__i386__) || defined (__x86_64__)
-	if (cpu_has_tsc) {
-		__u32 high;
-		rdtsc(time, high);
-		num ^= high;
+	/*
+	 * Use get_cycles() if implemented, otherwise fall back to
+	 * jiffies.
+	 */
+	time = get_cycles();
+	if (time != 0) {
+		if (sizeof(time) > 4)
+			num ^= (u32)(time >> 32);
 	} else {
 		time = jiffies;
 	}
-#elif defined (__sparc_v9__)
-	unsigned long tick = tick_ops->get_tick();
-
-	time = (unsigned int) tick;
-	num ^= (tick >> 32UL);
-#else
-	time = jiffies;
-#endif
 
 	/*
 	 * Calculate number of bits of randomness we probably added.
diff -puN include/asm-i386/timex.h~using-get_cycles-for-add_timer_randomness include/asm-i386/timex.h
--- 25/include/asm-i386/timex.h~using-get_cycles-for-add_timer_randomness	2004-08-23 22:02:34.355713400 -0700
+++ 25-akpm/include/asm-i386/timex.h	2004-08-23 22:02:34.370711120 -0700
@@ -7,7 +7,7 @@
 #define _ASMi386_TIMEX_H
 
 #include <linux/config.h>
-#include <asm/msr.h>
+#include <asm/processor.h>
 
 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
@@ -40,14 +40,17 @@ extern cycles_t cacheflush_time;
 
 static inline cycles_t get_cycles (void)
 {
+	unsigned long long ret=0;
+
 #ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
+	if (!cpu_has_tsc)
+		return 0;
+#endif
 
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
 	rdtscll(ret);
-	return ret;
 #endif
+	return ret;
 }
 
 extern unsigned long cpu_khz;
_
