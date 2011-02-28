From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] asm-generic/user.h: Fix spelling in comment
Date: Mon, 28 Feb 2011 10:32:22 +0100
Message-ID: <1298885542-6583-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:53989 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384Ab1B1JcZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Feb 2011 04:32:25 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org

Fix two misspellings.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/asm-generic/user.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/user.h b/include/asm-generic/user.h
index 8b9c3c9..35638c3 100644
--- a/include/asm-generic/user.h
+++ b/include/asm-generic/user.h
@@ -1,8 +1,8 @@
 #ifndef __ASM_GENERIC_USER_H
 #define __ASM_GENERIC_USER_H
 /*
- * This file may define a 'struct user' structure. However, it it only
- * used for a.out file, which are not supported on new architectures.
+ * This file may define a 'struct user' structure. However, it is only
+ * used for a.out files, which are not supported on new architectures.
  */
 
 #endif	/* __ASM_GENERIC_USER_H */
-- 
1.7.0.4
