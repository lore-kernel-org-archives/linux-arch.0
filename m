From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 09/20] frv: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:33 -0500
Message-ID: <20170122163244.11740-10-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-arch.vger.kernel.org

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/frv/mm/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/frv/mm/extable.c b/arch/frv/mm/extable.c
index 9a641c1b085a..a0e8b3e03e4c 100644
--- a/arch/frv/mm/extable.c
+++ b/arch/frv/mm/extable.c
@@ -2,7 +2,7 @@
  * linux/arch/frv/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
-- 
2.11.0
