From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 01/25] asm-generic: Change time_t and clock_t to 64 bit
Date: Tue, 13 May 2014 17:02:29 +0800
Message-ID: <1399971749-4004-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0139.outbound.protection.outlook.com ([157.56.111.139]:11808
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752503AbaEMJCl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:02:41 -0400
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Arnd Bergmann <arnd@arndb.de>

Use 64 bit time_t and clock_t as default. 32 bit users can provide
an override to define these as "long" if needed.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 include/uapi/asm-generic/posix_types.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/asm-generic/posix_types.h b/include/uapi/asm-generic/posix_types.h
index fe74fcc..3f0e613 100644
--- a/include/uapi/asm-generic/posix_types.h
+++ b/include/uapi/asm-generic/posix_types.h
@@ -81,12 +81,22 @@ typedef struct {
 #endif
 
 /*
+ * Use 64 bit time_t and clock_t as default. 32 bit users can provide an override to
+ * define these as "long" if needed.
+ */
+#ifndef __kernel_time_t
+typedef long long	__kernel_time_t;
+#endif
+
+#ifndef __kernel_clock_t
+typedef long long	__kernel_clock_t;
+#endif
+
+/*
  * anything below here should be completely generic
  */
 typedef __kernel_long_t	__kernel_off_t;
 typedef long long	__kernel_loff_t;
-typedef __kernel_long_t	__kernel_time_t;
-typedef __kernel_long_t	__kernel_clock_t;
 typedef int		__kernel_timer_t;
 typedef int		__kernel_clockid_t;
 typedef char *		__kernel_caddr_t;
-- 
1.8.2.1
