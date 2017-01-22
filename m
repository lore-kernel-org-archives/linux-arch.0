Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34632 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbdAVQdW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:33:22 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 09/20] frv: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:33 -0500
Message-ID: <20170122163244.11740-10-paul.gortmaker@windriver.com>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Message-ID: <20170122163233.EOQ9xyh-ZMsKqdtFOJ3AfcNFz2dnWzEF2vdvsSINvxs@z>

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

