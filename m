From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 05/17] xtensa: fix __delay for small loop count
Date: Thu, 17 Oct 2013 02:42:16 +0400
Message-ID: <1381963348-29448-6-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:43441 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760759Ab3JPWmy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:54 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so1198654lbd.16
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:53 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

Avoid __delay counter underflow for loop counts < 2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/delay.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

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
1.8.1.4
