From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 20/20] module.h: remove extable.h include now users have migrated
Date: Sun, 22 Jan 2017 11:32:44 -0500
Message-ID: <20170122163244.11740-21-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:58912 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbdAVQdw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 22 Jan 2017 11:33:52 -0500
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

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
index 7c84273d60b9..2e6df4c41c86 100644
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
2.11.0
