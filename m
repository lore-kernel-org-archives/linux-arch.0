From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 07/20] xtensa: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:31 -0500
Message-ID: <20170122163244.11740-8-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60032 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdAVQdV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:33:21 -0500
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/xtensa/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 2725e08ef353..a14df5aa98c8 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -13,7 +13,7 @@
  */
 
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/hardirq.h>
 #include <linux/perf_event.h>
 #include <linux/uaccess.h>
-- 
2.11.0
