From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] alpha: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 09:28:20 -0800
Message-ID: <1260466101-17545-4-git-send-email-ddaney@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3874 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761053AbZLJR3O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 12:29:14 -0500
In-Reply-To: <4B212EEC.3060808@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: linux-alpha@vger.kernel.org
---
 arch/alpha/include/asm/bug.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/alpha/include/asm/bug.h b/arch/alpha/include/asm/bug.h
index 1720c8a..f091682 100644
--- a/arch/alpha/include/asm/bug.h
+++ b/arch/alpha/include/asm/bug.h
@@ -13,7 +13,8 @@
 		"call_pal %0  # bugchk\n\t"				\
 		".long %1\n\t.8byte %2"					\
 		: : "i"(PAL_bugchk), "i"(__LINE__), "i"(__FILE__));	\
-	for ( ; ; ); } while (0)
+	unreachable();							\
+  } while (0)
 
 #define HAVE_ARCH_BUG
 #endif
-- 
1.6.2.5
