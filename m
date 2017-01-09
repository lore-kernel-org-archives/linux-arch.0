From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 07/10] xtensa: migrate exception table users off module.h and onto extable.h
Date: Mon, 9 Jan 2017 15:40:07 -0500
Message-ID: <20170109204010.5047-8-paul.gortmaker@windriver.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109204010.5047-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

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
