From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 03/11] xtensa: fix __delay for small loop count
Date: Fri, 30 Aug 2013 19:34:55 +0400
Message-ID: <1377876903-27860-4-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:54635 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab3H3PfR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:17 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so1690238lab.30
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:16 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Avoid __delay counter underflow for loop counts < 2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- make __delay fix more explicit for constant delays less than 2;

 arch/xtensa/include/asm/delay.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/include/asm/delay.h b/arch/xtensa/include/asm/delay.h
index 3899610..742b89f 100644
--- a/arch/xtensa/include/asm/delay.h
+++ b/arch/xtensa/include/asm/delay.h
@@ -19,9 +19,12 @@ extern unsigned long loops_per_jiffy;
 
 static inline void __delay(unsigned long loops)
 {
-	/* 2 cycles per loop. */
-	__asm__ __volatile__ ("1: addi %0, %0, -2; bgeui %0, 2, 1b"
-			      : "=r" (loops) : "0" (loops));
+	if (__builtin_constant_p(loops) && loops < 2)
+		__asm__ __volatile__ ("nop");
+	else if (loops >= 2)
+		/* 2 cycles per loop. */
+		__asm__ __volatile__ ("1: addi %0, %0, -2; bgeui %0, 2, 1b"
+				: "+r" (loops));
 }
 
 /* For SMP/NUMA systems, change boot_cpu_data to something like
-- 
1.7.7.6
