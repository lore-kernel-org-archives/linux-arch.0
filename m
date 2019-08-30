Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:60838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbfH3N7Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 09:59:24 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 5/8] lib: vdso: Remove checks on return value for 32 bit vDSO
Date: Fri, 30 Aug 2019 14:58:59 +0100
Message-ID: <20190830135902.20861-6-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-1-vincenzo.frascino@arm.com>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com, tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Message-ID: <20190830135859.qo_tXmrPr7W782a3Ao8-5bid7c0xSbuG0GhlQy8fb_o@z>

Since all the architectures that support the generic vDSO library have
been converted to support the 32 bit fallbacks it is not required
anymore to check the return value of __cvdso_clock_get*time32_common()
before updating the old_timespec fields.

Remove the related checks from the generic vdso library.

Cc: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@kernel.org>
References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 2c4b311c226d..d5bc16748f81 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -129,10 +129,10 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	if (unlikely(ret))
 		return clock_gettime32_fallback(clock, res);
 
-	if (likely(!ret)) {
-		res->tv_sec = ts.tv_sec;
-		res->tv_nsec = ts.tv_nsec;
-	}
+	/* For ret == 0 */
+	res->tv_sec = ts.tv_sec;
+	res->tv_nsec = ts.tv_nsec;
+
 	return ret;
 }
 #endif /* BUILD_VDSO32 */
@@ -238,10 +238,10 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	if (unlikely(ret))
 		return clock_getres32_fallback(clock, res);
 
-	if (likely(!ret)) {
-		res->tv_sec = ts.tv_sec;
-		res->tv_nsec = ts.tv_nsec;
-	}
+	/* For ret == 0 */
+	res->tv_sec = ts.tv_sec;
+	res->tv_nsec = ts.tv_nsec;
+
 	return ret;
 }
 #endif /* BUILD_VDSO32 */
-- 
2.23.0
