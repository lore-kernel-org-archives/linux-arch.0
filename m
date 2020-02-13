Return-Path: <SRS0=hmIl=4B=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:49856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgBMQRA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:00 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 06/19] linux/time32.h: Extract common header for vDSO
Date: Thu, 13 Feb 2020 16:16:01 +0000
Message-ID: <20200213161614.23246-7-vincenzo.frascino@arm.com>
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, ndesaulniers@google.com, avagin@openvz.org
Message-ID: <20200213161601.V1q1pkimvyUdo1mqpv51RkGkJQjkcOwAvIiEMpD_ktE@z>

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Split time32.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/common/time32.h | 17 +++++++++++++++++
 include/linux/time32.h  | 13 +------------
 2 files changed, 18 insertions(+), 12 deletions(-)
 create mode 100644 include/common/time32.h

diff --git a/include/common/time32.h b/include/common/time32.h
new file mode 100644
index 000000000000..d5b85abdfaf1
--- /dev/null
+++ b/include/common/time32.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COMMON_TIME32_H
+#define __COMMON_TIME32_H
+
+typedef s32		old_time32_t;
+
+struct old_timespec32 {
+	old_time32_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct old_timeval32 {
+	old_time32_t	tv_sec;
+	s32		tv_usec;
+};
+
+#endif /* __COMMON_TIME32_H */
diff --git a/include/linux/time32.h b/include/linux/time32.h
index cad4c3186002..39ff2f55e8d7 100644
--- a/include/linux/time32.h
+++ b/include/linux/time32.h
@@ -11,21 +11,10 @@
 
 #include <linux/time64.h>
 #include <linux/timex.h>
+#include <common/time32.h>
 
 #define TIME_T_MAX	(__kernel_old_time_t)((1UL << ((sizeof(__kernel_old_time_t) << 3) - 1)) - 1)
 
-typedef s32		old_time32_t;
-
-struct old_timespec32 {
-	old_time32_t	tv_sec;
-	s32		tv_nsec;
-};
-
-struct old_timeval32 {
-	old_time32_t	tv_sec;
-	s32		tv_usec;
-};
-
 struct old_itimerspec32 {
 	struct old_timespec32 it_interval;
 	struct old_timespec32 it_value;
-- 
2.25.0
