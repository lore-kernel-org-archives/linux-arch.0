Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S263962AbUILX1j@vger.kernel.org>
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63902
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263851AbUILX1j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 12 Sep 2004 19:27:39 -0400
Received: from localhost
	([127.0.0.1] helo=cheetah.davemloft.net ident=davem)
	by cheetah.davemloft.net with smtp (Exim 3.36 #1 (Debian))
	id 1C6djb-0001xV-00
	for <linux-arch@vger.kernel.org>; Sun, 12 Sep 2004 16:26:15 -0700
Date: Sun, 12 Sep 2004 16:26:15 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: time interpolators
Message-Id: <20040912162615.76b479b7.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I've just converted Sparc64 over to using the generic
interpolator code, it was really simply and I'd recommend
other ports to do it as well.

Kudos to the ia64 folks for writing this stuff and making
it usable so incredibly simply by other platforms.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/10 17:51:36-07:00 davem@nuts.davemloft.net 
#   [SPARC64]: Use time interpolators.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# arch/sparc64/kernel/time.c
#   2004/09/10 17:51:01-07:00 davem@nuts.davemloft.net +9 -111
#   [SPARC64]: Use time interpolators.
# 
# arch/sparc64/Kconfig
#   2004/09/10 17:51:01-07:00 davem@nuts.davemloft.net +4 -0
#   [SPARC64]: Use time interpolators.
# 
diff -Nru a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	2004-09-12 23:23:05 -07:00
+++ b/arch/sparc64/Kconfig	2004-09-12 23:23:05 -07:00
@@ -12,6 +12,10 @@
 	bool
 	default y
 
+config TIME_INTERPOLATION
+	bool
+	default y
+
 source "init/Kconfig"
 
 menu "General machine setup"
diff -Nru a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c	2004-09-12 23:23:05 -07:00
+++ b/arch/sparc64/kernel/time.c	2004-09-12 23:23:05 -07:00
@@ -431,7 +431,6 @@
 unsigned long timer_tick_offset;
 unsigned long timer_tick_compare;
 
-static unsigned long timer_ticks_per_usec_quotient;
 static unsigned long timer_ticks_per_nsec_quotient;
 
 #define TICK_SIZE (tick_nsec / 1000)
@@ -1025,18 +1024,22 @@
 static struct notifier_block sparc64_cpufreq_notifier_block = {
 	.notifier_call	= sparc64_cpufreq_notifier
 };
-#endif
+
+#endif /* CONFIG_CPU_FREQ */
+
+static struct time_interpolator sparc64_cpu_interpolator = {
+	.source		=	TIME_SOURCE_CPU,
+	.shift		=	16,
+};
 
 /* The quotient formula is taken from the IA64 port. */
-#define SPARC64_USEC_PER_CYC_SHIFT	30UL
 #define SPARC64_NSEC_PER_CYC_SHIFT	30UL
 void __init time_init(void)
 {
 	unsigned long clock = sparc64_init_timers(timer_interrupt);
 
-	timer_ticks_per_usec_quotient =
-		(((1000000UL << SPARC64_USEC_PER_CYC_SHIFT) +
-		  (clock / 2)) / clock);
+	sparc64_cpu_interpolator.frequency = clock;
+	register_time_interpolator(&sparc64_cpu_interpolator);
 
 	timer_ticks_per_nsec_quotient =
 		(((NSEC_PER_SEC << SPARC64_NSEC_PER_CYC_SHIFT) +
@@ -1048,17 +1051,6 @@
 #endif
 }
 
-static __inline__ unsigned long do_gettimeoffset(void)
-{
-	unsigned long ticks = tick_ops->get_tick();
-
-	ticks += timer_tick_offset;
-	ticks -= timer_tick_compare;
-
-	return (ticks * timer_ticks_per_usec_quotient)
-		>> SPARC64_USEC_PER_CYC_SHIFT;
-}
-
 unsigned long long sched_clock(void)
 {
 	unsigned long ticks = tick_ops->get_tick();
@@ -1066,100 +1058,6 @@
 	return (ticks * timer_ticks_per_nsec_quotient)
 		>> SPARC64_NSEC_PER_CYC_SHIFT;
 }
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	if (this_is_starfire)
-		return 0;
-
-	write_seqlock_irq(&xtime_lock);
-	/*
-	 * This is revolting. We need to set "xtime" correctly. However, the
-	 * value in this location is the value at the most recent update of
-	 * wall time.  Discover what correction gettimeofday() would have
-	 * made, and then undo it!
-	 */
-	nsec -= do_gettimeoffset() * 1000;
-	nsec -= (jiffies - wall_jiffies) * (NSEC_PER_SEC / HZ);
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
-/* Ok, my cute asm atomicity trick doesn't work anymore.
- * There are just too many variables that need to be protected
- * now (both members of xtime, wall_jiffies, et al.)
- */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq;
-	unsigned long usec, sec;
-	unsigned long max_ntp_tick = tick_usec - tickadj;
-
-	do {
-		unsigned long lost;
-
-		seq = read_seqbegin(&xtime_lock);
-		usec = do_gettimeoffset();
-		lost = jiffies - wall_jiffies;
-
-		/*
-		 * If time_adjust is negative then NTP is slowing the clock
-		 * so make sure not to go into next possible interval.
-		 * Better to lose some accuracy than have time go backwards..
-		 */
-		if (unlikely(time_adjust < 0)) {
-			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
-		}
-		else if (unlikely(lost))
-			usec += lost * tick_usec;
-
-		sec = xtime.tv_sec;
-
-		/* Believe it or not, this divide shows up on
-		 * kernel profiles.  The problem is that it is
-		 * both 64-bit and signed.  Happily, 32-bits
-		 * of precision is all we really need and in
-		 * doing so gcc ends up emitting a cheap multiply.
-		 *
-		 * XXX Why is tv_nsec 'long' and 'signed' in
-		 * XXX the first place, can it even be negative?
-		 */
-		usec += ((unsigned int) xtime.tv_nsec / 1000U);
-	} while (read_seqretry(&xtime_lock, seq));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
 
 static int set_rtc_mmss(unsigned long nowtime)
 {
