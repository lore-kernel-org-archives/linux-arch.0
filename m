Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:40683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCGQFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Mar 2019 11:05:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/4] vdso: arm: use __iter_div_u64_rem() for 64-bit division
Date: Thu,  7 Mar 2019 17:05:31 +0100
Message-Id: <20190307160532.3328288-4-arnd@arndb.de>
In-Reply-To: <20190307160532.3328288-1-arnd@arndb.de>
References: <20190307160532.3328288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Some compilers, e.g. clang-8, can turn a loop back into a division
operation, which here results in a link failure:

arch/arm/kernel/vdso.o: In function `update_vsyscall':
vdso.c:(.text+0x1c4): undefined reference to `__aeabi_uldivmod'

The problem is already solved in the generic __iter_div_u64_rem()
function, so use that here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/vdso.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 68930c90c504..32ad392e403b 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -328,11 +328,8 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_ts->sec		= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec			= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec			= nsec + tk->wall_to_monotonic.tv_nsec;
-	while (nsec >= NSEC_PER_SEC) {
-		nsec = nsec - NSEC_PER_SEC;
-		vdso_ts->sec++;
-	}
-	vdso_ts->nsec		= nsec;
+
+	vdso_ts->sec += __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 
 	if (__tk_is_cntvct) {
 		vdso_data->clock_mode	= 0;
-- 
2.20.0
