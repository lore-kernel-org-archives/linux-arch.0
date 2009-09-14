From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 06/11] parisc: Convert BUG() to use unreachable()
Date: Mon, 14 Sep 2009 14:55:35 -0700
Message-ID: <1252965340-31735-6-git-send-email-ddaney@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9421 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313AbZINV4C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2009 17:56:02 -0400
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

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
