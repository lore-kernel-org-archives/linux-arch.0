From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] vdso: Fix clocksource.h macro detection
Date: Mon, 23 Mar 2020 13:39:20 +0000
Message-ID: <20200323133920.46546-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:49176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgCWNjc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Mar 2020 09:39:32 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>

CONFIG_GENERIC_GETTIMEOFDAY is a sufficient condition to verify if an
architecture implements or not asm/vdso/clocksource.h. The current
implementation wrongly assumes that the same is true for the config
option CONFIG_ARCH_CLOCKSOURCE_DATA.
This results in a series of building errors on ia64/sparc/sparc64 like
the one below:

In file included from ./include/linux/clocksource.h:31,
                 from ./include/linux/clockchips.h:14,
                 from ./include/linux/tick.h:8,
                 from fs/proc/stat.c:15:
./include/vdso/clocksource.h:9:10: fatal error: asm/vdso/clocksource.h:
No such file or directory
    9 | #include <asm/vdso/clocksource.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~

Fix the issue removing the unneeded config condition.

Fixes: 14ee2ac618e4 ("linux/clocksource.h: Extract common header for vDSO")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Rebased on tip/master

 include/vdso/clocksource.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/vdso/clocksource.h b/include/vdso/clocksource.h
index ab58330e4e5d..c682e7c60273 100644
--- a/include/vdso/clocksource.h
+++ b/include/vdso/clocksource.h
@@ -4,10 +4,9 @@
 
 #include <vdso/limits.h>
 
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-	defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #include <asm/vdso/clocksource.h>
-#endif /* CONFIG_ARCH_CLOCKSOURCE_DATA || CONFIG_GENERIC_GETTIMEOFDAY */
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 enum vdso_clock_mode {
 	VDSO_CLOCKMODE_NONE,
-- 
2.25.2
