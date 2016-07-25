From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 14/14] module.h: remove extable.h include now users have migrated
Date: Sun, 24 Jul 2016 23:42:47 -0400
Message-ID: <20160725034247.109173-15-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46448 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbcGYDnz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2016 23:43:55 -0400
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

With hopefully most/all users of module.h that were looking for
exception table functions moved over to the new extable.h header,
we can remove the back-compat include that let us transition
without introducing build regressions.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/module.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f95ed243a4de..1974eadcb308 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -18,7 +18,6 @@
 #include <linux/moduleparam.h>
 #include <linux/jump_label.h>
 #include <linux/export.h>
-#include <linux/extable.h>	/* only as arch move module.h -> extable.h */
 #include <linux/rbtree_latch.h>
 
 #include <linux/percpu.h>
-- 
2.8.4
