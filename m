From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/5] x86: Convert BUG() to use unreachable()
Date: Fri,  4 Dec 2009 17:44:51 -0800
Message-ID: <1259977494-24636-2-git-send-email-ddaney@caviumnetworks.com>
References: <4B19BAD3.1000808@caviumnetworks.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:1361 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbZLECHR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2009 21:07:17 -0500
In-Reply-To: <4B19BAD3.1000808@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org

Use the new unreachable() macro instead of for(;;);.  When
allyesconfig is built with a GCC-4.5 snapshot on i686 the size of the
text segment is reduced by 3987 bytes (from 6827019 to 6823032).

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: "H. Peter Anvin" <hpa@zytor.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: x86@kernel.org
---
 arch/x86/include/asm/bug.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index d9cf1cd..f654d1b 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,14 +22,14 @@ do {								\
 		     ".popsection"				\
 		     : : "i" (__FILE__), "i" (__LINE__),	\
 		     "i" (sizeof(struct bug_entry)));		\
-	for (;;) ;						\
+	unreachable();						\
 } while (0)
 
 #else
 #define BUG()							\
 do {								\
 	asm volatile("ud2");					\
-	for (;;) ;						\
+	unreachable();						\
 } while (0)
 #endif
 
-- 
1.6.2.5
