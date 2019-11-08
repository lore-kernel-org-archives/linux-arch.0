Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:33093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHVIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 16:08:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/23] y2038: add __kernel_old_timespec and __kernel_old_time_t
Date: Fri,  8 Nov 2019 22:07:22 +0100
Message-ID: <20191108210824.1534248-2-arnd@arndb.de>
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20191108210722.VbpT8xCW8gvPdKe_AI1EEZytLtraF6QqZMiirm8WUO4@z>

The 'struct timespec' definition can no longer be part of the uapi headers
because it conflicts with a a now incompatible libc definition. Also,
we really want to remove it in order to prevent new uses from creeping in.

The same namespace conflict exists with time_t, which should also be
removed. __kernel_time_t could be used safely, but adding 'old' in the
name makes it clearer that this should not be used for new interfaces.

Add a replacement __kernel_old_timespec structure and __kernel_old_time_t
along the lines of __kernel_old_timeval.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/posix_types.h | 1 +
 include/uapi/linux/time_types.h        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index f0733a26ebfc..2f9c80595ba7 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -86,6 +86,7 @@ typedef struct {
  */
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
+typedef __kernel_long_t	__kernel_old_time_t;
 typedef __kernel_long_t	__kernel_time_t;
 typedef long long __kernel_time64_t;
 typedef __kernel_long_t	__kernel_clock_t;
diff --git a/include/uapi/linux/time_types.h b/include/uapi/linux/time_types.h
index 27bfc8fc6904..60b37f29842d 100644
--- a/include/uapi/linux/time_types.h
+++ b/include/uapi/linux/time_types.h
@@ -28,6 +28,11 @@ struct __kernel_old_timeval {
 };
 #endif
 
+struct __kernel_old_timespec {
+	__kernel_time_t	tv_sec;			/* seconds */
+	long		tv_nsec;		/* nanoseconds */
+};
+
 struct __kernel_sock_timeval {
 	__s64 tv_sec;
 	__s64 tv_usec;
-- 
2.20.0
