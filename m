From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v5 07/10] include: Add new y2038 safe __kernel_timespec
Date: Tue, 13 Mar 2018 21:03:30 -0700
Message-ID: <20180314040333.3291-8-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, tglx@linutronix.de, john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The new struct __kernel_timespec is similar to current
internal kernel struct timespec64 on 64 bit architecture.
The compat structure however is similar to below on little
endian systems (padding and tv_nsec are switched for big
endian systems):

typedef s32            compat_long_t;
typedef s64            compat_kernel_time64_t;

struct compat_kernel_timespec {
       compat_kernel_time64_t  tv_sec;
       compat_long_t           tv_nsec;
       compat_long_t           padding;
};

This allows for both the native and compat representations to
be the same and syscalls using this type as part of their ABI
can have a single entry point to both.

Note that the compat define is not included anywhere in the
kernel explicitly to avoid confusion.

These types will be used by the new syscalls that will be
introduced in the consequent patches.
Most of the new syscalls are just an update to the existing
native ones with this new type. Hence, put this new type under
an ifdef so that the architectures can define CONFIG_64BIT_TIME
when they are ready to handle this switch.

Cc: linux-arch@vger.kernel.org
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/time64.h                 | 10 +++++++++-
 include/uapi/asm-generic/posix_types.h |  1 +
 include/uapi/linux/time.h              |  7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 93d39499838e..0d96887ba4e0 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -2,12 +2,20 @@
 #ifndef _LINUX_TIME64_H
 #define _LINUX_TIME64_H
 
-#include <uapi/linux/time.h>
 #include <linux/math64.h>
 
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
 
+/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
+ * and 32-bit emulation.
+ */
+#ifndef CONFIG_64BIT_TIME
+#define __kernel_timespec timespec
+#endif
+
+#include <uapi/linux/time.h>
+
 #if __BITS_PER_LONG == 64
 /* this trick allows us to optimize out timespec64_to_timespec */
 # define timespec64 timespec
diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index 5e6ea22bd525..f0733a26ebfc 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -87,6 +87,7 @@ typedef struct {
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
 typedef __kernel_long_t	__kernel_time_t;
+typedef long long __kernel_time64_t;
 typedef __kernel_long_t	__kernel_clock_t;
 typedef int		__kernel_timer_t;
 typedef int		__kernel_clockid_t;
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 53f8dd84beb5..0ad4510884b0 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -42,6 +42,13 @@ struct itimerval {
 	struct timeval it_value;	/* current value */
 };
 
+#ifndef __kernel_timespec
+struct __kernel_timespec {
+	__kernel_time64_t       tv_sec;                 /* seconds */
+	long long               tv_nsec;                /* nanoseconds */
+};
+#endif
+
 /*
  * The IDs of the various system clocks (for POSIX.1b interval timers):
  */
-- 
2.14.1
