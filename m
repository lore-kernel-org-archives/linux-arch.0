Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266578AbUHMSPY@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40181 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S266545AbUHMSPY
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Aug 2004 14:15:24 -0400
Received: from d12nrmr1507.megacenter.de.ibm.com (d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate1.de.ibm.com (8.12.10/8.12.10) with ESMTP id i7DIFMGP066004
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 18:15:22 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1507.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i7DIFM2x221592
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:15:22 +0200
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1Bvgao-0000VK-00
	for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2004 20:15:54 +0200
Date: Fri, 13 Aug 2004 20:15:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] cputime (3/7): move jiffies stuff to jiffies.h.
Message-ID: <20040813181554.GD1862@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[PATCH] cputime (3/7): move jiffies stuff to jiffies.h.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Move all that lovely jiffies related functions into ONE file,
include/linux/jiffies.h.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/linux/jiffies.h |  291 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/time.h    |  253 -----------------------------------------
 include/linux/times.h   |   54 --------
 3 files changed, 296 insertions(+), 302 deletions(-)

diff -urN linux-2.6.8-rc4/include/linux/jiffies.h linux-2.6.8-cputime/include/linux/jiffies.h
--- linux-2.6.8-rc4/include/linux/jiffies.h	Wed Jun 16 07:18:53 2004
+++ linux-2.6.8-cputime/include/linux/jiffies.h	Fri Aug 13 19:05:28 2004
@@ -5,8 +5,17 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
+#include <linux/time.h>
 #include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
+#include <asm/div64.h>
+
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend,divisor,remainder) ({ \
+		       u64 result = dividend;		\
+		       *remainder = do_div(result,divisor); \
+		       result; })
+#endif
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
@@ -50,4 +59,286 @@
 	 ((long)(a) - (long)(b) >= 0))
 #define time_before_eq(a,b)	time_after_eq(b,a)
 
+/*
+ * Have the 32 bit jiffies value wrap 5 minutes after boot
+ * so jiffies wrap bugs show up earlier.
+ */
+#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
+
+/*
+ * Change timeval to jiffies, trying to avoid the
+ * most obvious overflows..
+ *
+ * And some not so obvious.
+ *
+ * Note that we don't want to return MAX_LONG, because
+ * for various timeout reasons we often end up having
+ * to wait "jiffies+1" in order to guarantee that we wait
+ * at _least_ "jiffies" - so "jiffies+1" had better still
+ * be positive.
+ */
+#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
+
+/*
+ * We want to do realistic conversions of time so we need to use the same
+ * values the update wall clock code uses as the jiffies size.  This value
+ * is: TICK_NSEC (which is defined in timex.h).  This
+ * is a constant and is in nanoseconds.  We will used scaled math
+ * with a set of scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and
+ * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
+ * constants and so are computed at compile time.  SHIFT_HZ (computed in
+ * timex.h) adjusts the scaling for different HZ values.
+
+ * Scaled math???  What is that?
+ *
+ * Scaled math is a way to do integer math on values that would,
+ * otherwise, either overflow, underflow, or cause undesired div
+ * instructions to appear in the execution path.  In short, we "scale"
+ * up the operands so they take more bits (more precision, less
+ * underflow), do the desired operation and then "scale" the result back
+ * by the same amount.  If we do the scaling by shifting we avoid the
+ * costly mpy and the dastardly div instructions.
+
+ * Suppose, for example, we want to convert from seconds to jiffies
+ * where jiffies is defined in nanoseconds as NSEC_PER_JIFFIE.  The
+ * simple math is: jiff = (sec * NSEC_PER_SEC) / NSEC_PER_JIFFIE; We
+ * observe that (NSEC_PER_SEC / NSEC_PER_JIFFIE) is a constant which we
+ * might calculate at compile time, however, the result will only have
+ * about 3-4 bits of precision (less for smaller values of HZ).
+ *
+ * So, we scale as follows:
+ * jiff = (sec) * (NSEC_PER_SEC / NSEC_PER_JIFFIE);
+ * jiff = ((sec) * ((NSEC_PER_SEC * SCALE)/ NSEC_PER_JIFFIE)) / SCALE;
+ * Then we make SCALE a power of two so:
+ * jiff = ((sec) * ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE)) >> SCALE;
+ * Now we define:
+ * #define SEC_CONV = ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE))
+ * jiff = (sec * SEC_CONV) >> SCALE;
+ *
+ * Often the math we use will expand beyond 32-bits so we tell C how to
+ * do this and pass the 64-bit result of the mpy through the ">> SCALE"
+ * which should take the result back to 32-bits.  We want this expansion
+ * to capture as much precision as possible.  At the same time we don't
+ * want to overflow so we pick the SCALE to avoid this.  In this file,
+ * that means using a different scale for each range of HZ values (as
+ * defined in timex.h).
+ *
+ * For those who want to know, gcc will give a 64-bit result from a "*"
+ * operator if the result is a long long AND at least one of the
+ * operands is cast to long long (usually just prior to the "*" so as
+ * not to confuse it into thinking it really has a 64-bit operand,
+ * which, buy the way, it can do, but it take more code and at least 2
+ * mpys).
+
+ * We also need to be aware that one second in nanoseconds is only a
+ * couple of bits away from overflowing a 32-bit word, so we MUST use
+ * 64-bits to get the full range time in nanoseconds.
+
+ */
+
+/*
+ * Here are the scales we will use.  One for seconds, nanoseconds and
+ * microseconds.
+ *
+ * Within the limits of cpp we do a rough cut at the SEC_JIFFIE_SC and
+ * check if the sign bit is set.  If not, we bump the shift count by 1.
+ * (Gets an extra bit of precision where we can use it.)
+ * We know it is set for HZ = 1024 and HZ = 100 not for 1000.
+ * Haven't tested others.
+
+ * Limits of cpp (for #if expressions) only long (no long long), but
+ * then we only need the most signicant bit.
+ */
+
+#define SEC_JIFFIE_SC (31 - SHIFT_HZ)
+#if !((((NSEC_PER_SEC << 2) / TICK_NSEC) << (SEC_JIFFIE_SC - 2)) & 0x80000000)
+#undef SEC_JIFFIE_SC
+#define SEC_JIFFIE_SC (32 - SHIFT_HZ)
+#endif
+#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
+#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
+#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
+                                TICK_NSEC -1) / (u64)TICK_NSEC))
+
+#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
+#define USEC_CONVERSION  \
+                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
+                                        TICK_NSEC -1) / (u64)TICK_NSEC))
+/*
+ * USEC_ROUND is used in the timeval to jiffie conversion.  See there
+ * for more details.  It is the scaled resolution rounding value.  Note
+ * that it is a 64-bit value.  Since, when it is applied, we are already
+ * in jiffies (albit scaled), it is nothing but the bits we will shift
+ * off.
+ */
+#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
+/*
+ * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
+ * into seconds.  The 64-bit case will overflow if we are not careful,
+ * so use the messy SH_DIV macro to do it.  Still all constants.
+ */
+#if BITS_PER_LONG < 64
+# define MAX_SEC_IN_JIFFIES \
+	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
+#else	/* take care of overflow on 64 bits machines */
+# define MAX_SEC_IN_JIFFIES \
+	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
+
+#endif
+
+/*
+ * Convert jiffies to milliseconds and back.
+ *
+ * Avoid unnecessary multiplications/divisions in the
+ * two most common HZ cases:
+ */
+static inline unsigned int jiffies_to_msecs(const unsigned long j)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (1000 / HZ) * j;
+#elif HZ > 1000 && !(HZ % 1000)
+	return (j + (HZ / 1000) - 1)/(HZ / 1000);
+#else
+	return (j * 1000) / HZ;
+#endif
+}
+static inline unsigned long msecs_to_jiffies(const unsigned int m)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (m + (1000 / HZ) - 1) / (1000 / HZ);
+#elif HZ > 1000 && !(HZ % 1000)
+	return m * (HZ / 1000);
+#else
+	return (m * HZ + 999) / 1000;
+#endif
+}
+
+/*
+ * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
+ * that a remainder subtract here would not do the right thing as the
+ * resolution values don't fall on second boundries.  I.e. the line:
+ * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
+ *
+ * Rather, we just shift the bits off the right.
+ *
+ * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
+ * value to a scaled second value.
+ */
+static __inline__ unsigned long
+timespec_to_jiffies(const struct timespec *value)
+{
+	unsigned long sec = value->tv_sec;
+	long nsec = value->tv_nsec + TICK_NSEC - 1;
+
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		nsec = 0;
+	}
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)nsec * NSEC_CONVERSION) >>
+		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+
+}
+
+static __inline__ void
+jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+{
+	/*
+	 * Convert jiffies to nanoseconds and separate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC; 
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
+}
+
+/* Same for "timeval"
+ *
+ * Well, almost.  The problem here is that the real system resolution is
+ * in nanoseconds and the value being converted is in micro seconds.
+ * Also for some machines (those that use HZ = 1024, in-particular),
+ * there is a LARGE error in the tick size in microseconds.
+
+ * The solution we use is to do the rounding AFTER we convert the
+ * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
+ * Instruction wise, this should cost only an additional add with carry
+ * instruction above the way it was done above.
+ */
+static __inline__ unsigned long
+timeval_to_jiffies(const struct timeval *value)
+{
+	unsigned long sec = value->tv_sec;
+	long usec = value->tv_usec;
+
+	if (sec >= MAX_SEC_IN_JIFFIES){
+		sec = MAX_SEC_IN_JIFFIES;
+		usec = 0;
+	}
+	return (((u64)sec * SEC_CONVERSION) +
+		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
+		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
+}
+
+static __inline__ void
+jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+{
+	/*
+	 * Convert jiffies to nanoseconds and separate with
+	 * one divide.
+	 */
+	u64 nsec = (u64)jiffies * TICK_NSEC; 
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
+	value->tv_usec /= NSEC_PER_USEC;
+}
+
+/*
+ * Convert jiffies/jiffies_64 to clock_t and back.
+ */
+static inline clock_t jiffies_to_clock_t(long x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	return x / (HZ / USER_HZ);
+#else
+	u64 tmp = (u64)x * TICK_NSEC;
+	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
+	return (long)tmp;
+#endif
+}
+
+static inline unsigned long clock_t_to_jiffies(unsigned long x)
+{
+#if (HZ % USER_HZ)==0
+	if (x >= ~0UL / (HZ / USER_HZ))
+		return ~0UL;
+	return x * (HZ / USER_HZ);
+#else
+	u64 jif;
+
+	/* Don't worry about loss of precision here .. */
+	if (x >= ~0UL / HZ * USER_HZ)
+		return ~0UL;
+
+	/* .. but do try to contain it here */
+	jif = x * (u64) HZ;
+	do_div(jif, USER_HZ);
+	return jif;
+#endif
+}
+
+static inline u64 jiffies_64_to_clock_t(u64 x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	do_div(x, HZ / USER_HZ);
+#else
+	/*
+	 * There are better ways that don't overflow early,
+	 * but even this doesn't overflow in hundreds of years
+	 * in 64 bits, so..
+	 */
+	x *= TICK_NSEC;
+	do_div(x, (NSEC_PER_SEC / USER_HZ));
+#endif
+	return x;
+}
+
 #endif
diff -urN linux-2.6.8-rc4/include/linux/time.h linux-2.6.8-cputime/include/linux/time.h
--- linux-2.6.8-rc4/include/linux/time.h	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-cputime/include/linux/time.h	Fri Aug 13 19:05:28 2004
@@ -4,13 +4,10 @@
 #include <asm/param.h>
 #include <linux/types.h>
 
-#ifndef _STRUCT_TIMESPEC
-#define _STRUCT_TIMESPEC
 struct timespec {
 	time_t	tv_sec;		/* seconds */
 	long	tv_nsec;	/* nanoseconds */
 };
-#endif /* _STRUCT_TIMESPEC */
 
 struct timeval {
 	time_t		tv_sec;		/* seconds */
@@ -28,34 +25,6 @@
 #include <linux/seqlock.h>
 #include <linux/timex.h>
 #include <asm/div64.h>
-#ifndef div_long_long_rem
-
-#define div_long_long_rem(dividend,divisor,remainder) ({ \
-		       u64 result = dividend;		\
-		       *remainder = do_div(result,divisor); \
-		       result; })
-
-#endif
-
-/*
- * Have the 32 bit jiffies value wrap 5 minutes after boot
- * so jiffies wrap bugs show up earlier.
- */
-#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
-
-/*
- * Change timeval to jiffies, trying to avoid the
- * most obvious overflows..
- *
- * And some not so obvious.
- *
- * Note that we don't want to return MAX_LONG, because
- * for various timeout reasons we often end up having
- * to wait "jiffies+1" in order to guarantee that we wait
- * at _least_ "jiffies" - so "jiffies+1" had better still
- * be positive.
- */
-#define MAX_JIFFY_OFFSET ((~0UL >> 1)-1)
 
 /* Parameters used to convert the timespec values */
 #ifndef USEC_PER_SEC
@@ -70,218 +39,6 @@
 #define NSEC_PER_USEC (1000L)
 #endif
 
-/*
- * We want to do realistic conversions of time so we need to use the same
- * values the update wall clock code uses as the jiffies size.  This value
- * is: TICK_NSEC (which is defined in timex.h).  This
- * is a constant and is in nanoseconds.  We will used scaled math
- * with a set of scales defined here as SEC_JIFFIE_SC,  USEC_JIFFIE_SC and
- * NSEC_JIFFIE_SC.  Note that these defines contain nothing but
- * constants and so are computed at compile time.  SHIFT_HZ (computed in
- * timex.h) adjusts the scaling for different HZ values.
-
- * Scaled math???  What is that?
- *
- * Scaled math is a way to do integer math on values that would,
- * otherwise, either overflow, underflow, or cause undesired div
- * instructions to appear in the execution path.  In short, we "scale"
- * up the operands so they take more bits (more precision, less
- * underflow), do the desired operation and then "scale" the result back
- * by the same amount.  If we do the scaling by shifting we avoid the
- * costly mpy and the dastardly div instructions.
-
- * Suppose, for example, we want to convert from seconds to jiffies
- * where jiffies is defined in nanoseconds as NSEC_PER_JIFFIE.  The
- * simple math is: jiff = (sec * NSEC_PER_SEC) / NSEC_PER_JIFFIE; We
- * observe that (NSEC_PER_SEC / NSEC_PER_JIFFIE) is a constant which we
- * might calculate at compile time, however, the result will only have
- * about 3-4 bits of precision (less for smaller values of HZ).
- *
- * So, we scale as follows:
- * jiff = (sec) * (NSEC_PER_SEC / NSEC_PER_JIFFIE);
- * jiff = ((sec) * ((NSEC_PER_SEC * SCALE)/ NSEC_PER_JIFFIE)) / SCALE;
- * Then we make SCALE a power of two so:
- * jiff = ((sec) * ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE)) >> SCALE;
- * Now we define:
- * #define SEC_CONV = ((NSEC_PER_SEC << SCALE)/ NSEC_PER_JIFFIE))
- * jiff = (sec * SEC_CONV) >> SCALE;
- *
- * Often the math we use will expand beyond 32-bits so we tell C how to
- * do this and pass the 64-bit result of the mpy through the ">> SCALE"
- * which should take the result back to 32-bits.  We want this expansion
- * to capture as much precision as possible.  At the same time we don't
- * want to overflow so we pick the SCALE to avoid this.  In this file,
- * that means using a different scale for each range of HZ values (as
- * defined in timex.h).
- *
- * For those who want to know, gcc will give a 64-bit result from a "*"
- * operator if the result is a long long AND at least one of the
- * operands is cast to long long (usually just prior to the "*" so as
- * not to confuse it into thinking it really has a 64-bit operand,
- * which, buy the way, it can do, but it take more code and at least 2
- * mpys).
-
- * We also need to be aware that one second in nanoseconds is only a
- * couple of bits away from overflowing a 32-bit word, so we MUST use
- * 64-bits to get the full range time in nanoseconds.
-
- */
-
-/*
- * Here are the scales we will use.  One for seconds, nanoseconds and
- * microseconds.
- *
- * Within the limits of cpp we do a rough cut at the SEC_JIFFIE_SC and
- * check if the sign bit is set.  If not, we bump the shift count by 1.
- * (Gets an extra bit of precision where we can use it.)
- * We know it is set for HZ = 1024 and HZ = 100 not for 1000.
- * Haven't tested others.
-
- * Limits of cpp (for #if expressions) only long (no long long), but
- * then we only need the most signicant bit.
- */
-
-#define SEC_JIFFIE_SC (31 - SHIFT_HZ)
-#if !((((NSEC_PER_SEC << 2) / TICK_NSEC) << (SEC_JIFFIE_SC - 2)) & 0x80000000)
-#undef SEC_JIFFIE_SC
-#define SEC_JIFFIE_SC (32 - SHIFT_HZ)
-#endif
-#define NSEC_JIFFIE_SC (SEC_JIFFIE_SC + 29)
-#define USEC_JIFFIE_SC (SEC_JIFFIE_SC + 19)
-#define SEC_CONVERSION ((unsigned long)((((u64)NSEC_PER_SEC << SEC_JIFFIE_SC) +\
-                                TICK_NSEC -1) / (u64)TICK_NSEC))
-
-#define NSEC_CONVERSION ((unsigned long)((((u64)1 << NSEC_JIFFIE_SC) +\
-                                        TICK_NSEC -1) / (u64)TICK_NSEC))
-#define USEC_CONVERSION  \
-                    ((unsigned long)((((u64)NSEC_PER_USEC << USEC_JIFFIE_SC) +\
-                                        TICK_NSEC -1) / (u64)TICK_NSEC))
-/*
- * USEC_ROUND is used in the timeval to jiffie conversion.  See there
- * for more details.  It is the scaled resolution rounding value.  Note
- * that it is a 64-bit value.  Since, when it is applied, we are already
- * in jiffies (albit scaled), it is nothing but the bits we will shift
- * off.
- */
-#define USEC_ROUND (u64)(((u64)1 << USEC_JIFFIE_SC) - 1)
-/*
- * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that
- * into seconds.  The 64-bit case will overflow if we are not careful,
- * so use the messy SH_DIV macro to do it.  Still all constants.
- */
-#if BITS_PER_LONG < 64
-# define MAX_SEC_IN_JIFFIES \
-	(long)((u64)((u64)MAX_JIFFY_OFFSET * TICK_NSEC) / NSEC_PER_SEC)
-#else	/* take care of overflow on 64 bits machines */
-# define MAX_SEC_IN_JIFFIES \
-	(SH_DIV((MAX_JIFFY_OFFSET >> SEC_JIFFIE_SC) * TICK_NSEC, NSEC_PER_SEC, 1) - 1)
-
-#endif
-
-/*
- * Convert jiffies to milliseconds and back.
- *
- * Avoid unnecessary multiplications/divisions in the
- * two most common HZ cases:
- */
-static inline unsigned int jiffies_to_msecs(const unsigned long j)
-{
-#if HZ <= 1000 && !(1000 % HZ)
-	return (1000 / HZ) * j;
-#elif HZ > 1000 && !(HZ % 1000)
-	return (j + (HZ / 1000) - 1)/(HZ / 1000);
-#else
-	return (j * 1000) / HZ;
-#endif
-}
-static inline unsigned long msecs_to_jiffies(const unsigned int m)
-{
-#if HZ <= 1000 && !(1000 % HZ)
-	return (m + (1000 / HZ) - 1) / (1000 / HZ);
-#elif HZ > 1000 && !(HZ % 1000)
-	return m * (HZ / 1000);
-#else
-	return (m * HZ + 999) / 1000;
-#endif
-}
-
-/*
- * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
- * that a remainder subtract here would not do the right thing as the
- * resolution values don't fall on second boundries.  I.e. the line:
- * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
- *
- * Rather, we just shift the bits off the right.
- *
- * The >> (NSEC_JIFFIE_SC - SEC_JIFFIE_SC) converts the scaled nsec
- * value to a scaled second value.
- */
-static __inline__ unsigned long
-timespec_to_jiffies(const struct timespec *value)
-{
-	unsigned long sec = value->tv_sec;
-	long nsec = value->tv_nsec + TICK_NSEC - 1;
-
-	if (sec >= MAX_SEC_IN_JIFFIES){
-		sec = MAX_SEC_IN_JIFFIES;
-		nsec = 0;
-	}
-	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)nsec * NSEC_CONVERSION) >>
-		 (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-
-}
-
-static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC; 
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
-}
-
-/* Same for "timeval"
- *
- * Well, almost.  The problem here is that the real system resolution is
- * in nanoseconds and the value being converted is in micro seconds.
- * Also for some machines (those that use HZ = 1024, in-particular),
- * there is a LARGE error in the tick size in microseconds.
-
- * The solution we use is to do the rounding AFTER we convert the
- * microsecond part.  Thus the USEC_ROUND, the bits to be shifted off.
- * Instruction wise, this should cost only an additional add with carry
- * instruction above the way it was done above.
- */
-static __inline__ unsigned long
-timeval_to_jiffies(const struct timeval *value)
-{
-	unsigned long sec = value->tv_sec;
-	long usec = value->tv_usec;
-
-	if (sec >= MAX_SEC_IN_JIFFIES){
-		sec = MAX_SEC_IN_JIFFIES;
-		usec = 0;
-	}
-	return (((u64)sec * SEC_CONVERSION) +
-		(((u64)usec * USEC_CONVERSION + USEC_ROUND) >>
-		 (USEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
-}
-
-static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
-{
-	/*
-	 * Convert jiffies to nanoseconds and separate with
-	 * one divide.
-	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC; 
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
-	value->tv_usec /= NSEC_PER_USEC;
-}
-
 static __inline__ int timespec_equal(struct timespec *a, struct timespec *b) 
 { 
 	return (a->tv_sec == b->tv_sec) && (a->tv_nsec == b->tv_nsec);
@@ -333,11 +90,6 @@
 
 #define CURRENT_TIME (current_kernel_time())
 
-#endif /* __KERNEL__ */
-
-#define NFDBITS			__NFDBITS
-
-#ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern int do_settimeofday(struct timespec *tv);
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
@@ -363,7 +115,10 @@
 	ts->tv_sec = sec;
 	ts->tv_nsec = nsec;
 }
-#endif
+
+#endif /* __KERNEL__ */
+
+#define NFDBITS			__NFDBITS
 
 #define FD_SETSIZE		__FD_SETSIZE
 #define FD_SET(fd,fdsetp)	__FD_SET(fd,fdsetp)
diff -urN linux-2.6.8-rc4/include/linux/times.h linux-2.6.8-cputime/include/linux/times.h
--- linux-2.6.8-rc4/include/linux/times.h	Wed Jun 16 07:18:57 2004
+++ linux-2.6.8-cputime/include/linux/times.h	Fri Aug 13 19:05:28 2004
@@ -1,59 +1,7 @@
 #ifndef _LINUX_TIMES_H
 #define _LINUX_TIMES_H
 
-#ifdef __KERNEL__
-#include <linux/timex.h>
-#include <asm/div64.h>
-#include <asm/types.h>
-#include <asm/param.h>
-
-static inline clock_t jiffies_to_clock_t(long x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	return x / (HZ / USER_HZ);
-#else
-	u64 tmp = (u64)x * TICK_NSEC;
-	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
-	return (long)tmp;
-#endif
-}
-
-static inline unsigned long clock_t_to_jiffies(unsigned long x)
-{
-#if (HZ % USER_HZ)==0
-	if (x >= ~0UL / (HZ / USER_HZ))
-		return ~0UL;
-	return x * (HZ / USER_HZ);
-#else
-	u64 jif;
-
-	/* Don't worry about loss of precision here .. */
-	if (x >= ~0UL / HZ * USER_HZ)
-		return ~0UL;
-
-	/* .. but do try to contain it here */
-	jif = x * (u64) HZ;
-	do_div(jif, USER_HZ);
-	return jif;
-#endif
-}
-
-static inline u64 jiffies_64_to_clock_t(u64 x)
-{
-#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
-	do_div(x, HZ / USER_HZ);
-#else
-	/*
-	 * There are better ways that don't overflow early,
-	 * but even this doesn't overflow in hundreds of years
-	 * in 64 bits, so..
-	 */
-	x *= TICK_NSEC;
-	do_div(x, (NSEC_PER_SEC / USER_HZ));
-#endif
-	return x;
-}
-#endif
+#include <linux/types.h>
 
 struct tms {
 	clock_t tms_utime;
