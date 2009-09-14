From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 03/11] MIPS: Convert BUG() to use unreachable()
Date: Mon, 14 Sep 2009 14:55:32 -0700
Message-ID: <1252965340-31735-3-git-send-email-ddaney@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757391AbZINV6G@vger.kernel.org>
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

Use the new unreachable() macro instead of while(1);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/bug.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
index 6cf29c2..540c98a 100644
--- a/arch/mips/include/asm/bug.h
+++ b/arch/mips/include/asm/bug.h
@@ -11,9 +11,7 @@
 static inline void __noreturn BUG(void)
 {
 	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
-	/* Fool GCC into thinking the function doesn't return. */
-	while (1)
-		;
+	unreachable();
 }
 
 #define HAVE_ARCH_BUG
-- 
1.6.2.5
