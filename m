Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9425 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307AbZINV4F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2009 17:56:05 -0400
From: David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 07/11] powerpc: Convert BUG() to use unreachable()
Date: Mon, 14 Sep 2009 14:55:36 -0700
Message-ID: <1252965340-31735-7-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4AAEBAC2.1050905@caviumnetworks.com>
References: <4AAEBAC2.1050905@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-ID: <20090914215536.gvfGsy1b_kJqnoc0nwB5_nRJZ2LTDKyQfePR1ef8Ug0@z>

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

