Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55103 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933857AbaE3UG7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2014 16:06:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 02/32] uapi: add struct __kernel_timespec{32,64}
Date: Fri, 30 May 2014 22:01:26 +0200
Message-ID: <1401480116-1973111-3-git-send-email-arnd@arndb.de>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20140530200126.PJin0xcXQFNH4W6tD7Gb1uxGnR8QJf8omxXTSjrK6PA@z>

We cannot use time_t or any derived structures beyond the year
2038 in interfaces between kernel and user space, on 32-bit
machines.

This is my suggestion for how to migrate syscall and ioctl
interfaces: We completely phase out time_t, timeval and timespec
from the uapi header files and replace them with types that are
either explicitly safe (__kernel_timespec64), or explicitly
unsafe (e.g. __kernel_timespec32). For each unsafe interface,
there needs to be a safe replacement interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/time.h | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index e75e1b6..e2b56a3 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -3,7 +3,18 @@
 
 #include <linux/types.h>
 
-
+/*
+ * time_t, timespec and timeval are not safe to use beyond
+ * 2038 on 32-bit systems, and should be phased out for
+ * in-kernel uses as well as interfaces to user space.
+ *
+ * Inside of the kernel, we can use e.g. inode_time,
+ * ktime_t or timespec64, as appropriate.
+ *
+ * In the long run, we have to stop making these definitions
+ * visibile to user headers, so libc can define its own
+ * 64-bit types.
+ */
 #ifndef _STRUCT_TIMESPEC
 #define _STRUCT_TIMESPEC
 struct timespec {
@@ -17,6 +28,33 @@ struct timeval {
 	__kernel_suseconds_t	tv_usec;	/* microseconds */
 };
 
+/*
+ * __kernel_timespec64 is the general type to be used for
+ * new user space interfaces passing a time argument.
+ * 64-bit nanoseconds is a bit silly, but the advantage is
+ * that it is compatible with the native 'struct timespec'
+ * on 64-bit user space. This simplifies the compat code.
+ */
+struct __kernel_timespec64 {
+	long long tv_sec;
+	long long tv_nsec;
+};
+
+/*
+ * As interfaces get moved over from time_t, timeval and timespec
+ * to __kernel_timespec64, we have to provide backwards compatibility
+ * interfaces. These can use __kernel_timespec32. Other types will
+ * be needed as required.
+ * The compat syscalls and ioctls can also migrate from compat_timespec
+ * to __kernel_timespec32 in order to share the implementation with
+ * the native 32-bit legacy handlers.
+ */
+struct __kernel_timespec32 {
+	int	tv_sec;
+	int	tv_nsec;
+};
+
+/* timezone is safe for use beyond 2038 */
 struct timezone {
 	int	tz_minuteswest;	/* minutes west of Greenwich */
 	int	tz_dsttime;	/* type of dst correction */
-- 
1.8.3.2

