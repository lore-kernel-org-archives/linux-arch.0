From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/5] parisc: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 09:28:18 -0800
Message-ID: <1260466101-17545-2-git-send-email-ddaney@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <4B212EEC.3060808@caviumnetworks.com>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Kyle McMartin <kyle@mcmartin.ca>
CC: Helge Deller <deller@gmx.de>
CC: linux-parisc@vger.kernel.org
---
 arch/parisc/include/asm/bug.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 8cfc553..75e46c5 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -32,14 +32,14 @@
 			     "\t.popsection"				\
 			     : : "i" (__FILE__), "i" (__LINE__),	\
 			     "i" (0), "i" (sizeof(struct bug_entry)) ); \
-		for(;;) ;						\
+		unreachable();						\
 	} while(0)
 
 #else
 #define BUG()								\
 	do {								\
 		asm volatile(PARISC_BUG_BREAK_ASM : : );		\
-		for(;;) ;						\
+		unreachable();						\
 	} while(0)
 #endif
 
-- 
1.6.2.5

