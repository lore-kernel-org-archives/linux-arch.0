From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/5] powerpc: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 09:28:19 -0800
Message-ID: <1260466101-17545-3-git-send-email-ddaney@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3893 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761237AbZLJR3P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Dec 2009 12:29:15 -0500
In-Reply-To: <4B212EEC.3060808@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, David Daney <ddaney@caviumnetworks.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@ozlabs.org
---
 arch/powerpc/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 64e1fdc..2c15212 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -68,7 +68,7 @@
 		_EMIT_BUG_ENTRY					\
 		: : "i" (__FILE__), "i" (__LINE__),		\
 		    "i" (0), "i"  (sizeof(struct bug_entry)));	\
-	for(;;) ;						\
+	unreachable();						\
 } while (0)
 
 #define BUG_ON(x) do {						\
-- 
1.6.2.5
