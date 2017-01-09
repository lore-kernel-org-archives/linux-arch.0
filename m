Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:44056 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940744AbdAIUlU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Jan 2017 15:41:20 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 10/10] module.h: remove extable.h include now users have migrated
Date: Mon, 9 Jan 2017 15:40:10 -0500
Message-ID: <20170109204010.5047-11-paul.gortmaker@windriver.com>
In-Reply-To: <20170109204010.5047-1-paul.gortmaker@windriver.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20170109204010.RXG6Vh-MlMqglAe6052MuRO__B7GgWPqUE9VbOYTuis@z>

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

