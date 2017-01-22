From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 17/20] microblaze: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:41 -0500
Message-ID: <20170122163244.11740-18-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Michal Simek <monstr@monstr.eu>
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/microblaze/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index abb678ccde6f..f91b30f8aaa8 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -17,7 +17,7 @@
  *
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
-- 
2.11.0
