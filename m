From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] cpufreq: governor: Fix overflow when calculating idle time
Date: Tue,  5 Apr 2016 00:32:33 +0800
Message-ID: <1459787553-20092-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-arch.vger.kernel.org

It was reported that after Commit 0df35026c6a5 ("cpufreq: governor: Fix
negative idle_time when configured with CONFIG_HZ_PERIODIC"),
cpufreq ondemand governor started to act oddly. Without any load,
with freshly booted system, it pumped cpu frequency up to maximum
at some point of time and stayed there. The problem is caused by
jiffies oveflow in get_cpu_idle_time:

Since jiffies is not counted from zero but from -300HZ, after booting
up 5 minutes, the jiffies will round up to zero. As a result,
the following condition will always be true:
if (cur_idle_time < j_cdbs->prev_cpu_idle)
        cur_idle_time = j_cdbs->prev_cpu_idle;
Say, once cur_idle_time rounds up to zero, while prev_cpu_idle remains
negative(because of -300HZ), the cur_idle_time will be modified to the
same as prev_cpu_idle(negative), thus we get a zero of idle running time
during this sample(cur_idle_time - prev_cpu_idle), which causes a high
busy time, thus governor always requests for the highest freq.
So the patch mentioned above has triggered this overflow issue more easily.

This patch fixes this problem by doing two modifications in the
get_cpu_idle_time_jiffy:

1. Count the wall time from INITIAL_JIFFIES rather than 0.
2. Use 64bit rather than 32bit to convert jiffies64 to usec.

In this way, either the wall time or the idle time will be
monotonically increased, thus avoid the jiffies overflow problem.
(If CONFIG_HZ_1000=y, it would be at least 500000000 years for
64bit to overflow, which would not possibly happen.)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=115261
Reported-by: Timo Valtoaho <timo.valtoaho@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq.c             |  6 +++---
 include/asm-generic/cputime_jiffies.h |  2 ++
 include/linux/cputime.h               |  5 +++++
 include/linux/jiffies.h               |  1 +
 kernel/time/time.c                    | 20 ++++++++++++++++++++
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b87596b..2dc327a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -138,7 +138,7 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 	u64 cur_wall_time;
 	u64 busy_time;
 
-	cur_wall_time = jiffies64_to_cputime64(get_jiffies_64());
+	cur_wall_time = jiffies64_to_cputime64(get_jiffies_64() - INITIAL_JIFFIES);
 
 	busy_time = kcpustat_cpu(cpu).cpustat[CPUTIME_USER];
 	busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SYSTEM];
@@ -149,9 +149,9 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 
 	idle_time = cur_wall_time - busy_time;
 	if (wall)
-		*wall = cputime_to_usecs(cur_wall_time);
+		*wall = cputime64_to_usecs(cur_wall_time);
 
-	return cputime_to_usecs(idle_time);
+	return cputime64_to_usecs(idle_time);
 }
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
diff --git a/include/asm-generic/cputime_jiffies.h b/include/asm-generic/cputime_jiffies.h
index fe386fc..ff1cf39 100644
--- a/include/asm-generic/cputime_jiffies.h
+++ b/include/asm-generic/cputime_jiffies.h
@@ -36,6 +36,8 @@ typedef u64 __nocast cputime64_t;
 	jiffies_to_cputime(usecs_to_jiffies(__usec))
 #define usecs_to_cputime64(__usec)	\
 	jiffies64_to_cputime64(nsecs_to_jiffies64((__usec) * 1000))
+#define cputime64_to_usecs(__ct)		\
+	jiffies64_to_usecs(cputime64_to_jiffies64(__ct))
 
 /*
  * Convert cputime to seconds and back.
diff --git a/include/linux/cputime.h b/include/linux/cputime.h
index f2eb2ee..ffa8665 100644
--- a/include/linux/cputime.h
+++ b/include/linux/cputime.h
@@ -13,4 +13,9 @@
 	usecs_to_cputime((__nsecs) / NSEC_PER_USEC)
 #endif
 
+#ifndef cputime64_to_usecs
+#define cputime64_to_usecs(__ct)		\
+	cputime_to_usecs(__ct)
+#endif
+
 #endif /* __LINUX_CPUTIME_H */
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 5fdc553..f26ceb4 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -283,6 +283,7 @@ extern unsigned long preset_lpj;
  */
 extern unsigned int jiffies_to_msecs(const unsigned long j);
 extern unsigned int jiffies_to_usecs(const unsigned long j);
+extern u64 jiffies64_to_usecs(const u64 j);
 
 static inline u64 jiffies_to_nsecs(const unsigned long j)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index be115b0..5167c4b 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -286,6 +286,26 @@ unsigned int jiffies_to_usecs(const unsigned long j)
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
 
+u64 jiffies64_to_usecs(const u64 j)
+{
+	/*
+	 * Hz usually doesn't go much further MSEC_PER_SEC.
+	 * jiffies_to_usecs() and usecs_to_jiffies() depend on that.
+	 */
+	BUILD_BUG_ON(HZ > USEC_PER_SEC);
+
+#if !(USEC_PER_SEC % HZ)
+	return (USEC_PER_SEC / HZ) * j;
+#else
+# if BITS_PER_LONG == 32
+	return (HZ_TO_USEC_MUL32 * j) >> HZ_TO_USEC_SHR32;
+# else
+	return (j * HZ_TO_USEC_NUM) / HZ_TO_USEC_DEN;
+# endif
+#endif
+}
+EXPORT_SYMBOL(jiffies64_to_usecs);
+
 /**
  * timespec_trunc - Truncate timespec to a granularity
  * @t: Timespec
-- 
1.8.4.2
