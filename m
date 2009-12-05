From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/5] MIPS: Convert BUG() to use unreachable()
Date: Fri,  4 Dec 2009 17:44:52 -0800
Message-ID: <1259977494-24636-3-git-send-email-ddaney@caviumnetworks.com>
References: <4B19BAD3.1000808@caviumnetworks.com>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <4B19BAD3.1000808@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Use the new unreachable() macro instead of while(1);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
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
