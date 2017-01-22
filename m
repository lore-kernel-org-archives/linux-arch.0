Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60065 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbdAVQeA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:34:00 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 13/20] arc: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:37 -0500
Message-ID: <20170122163244.11740-14-paul.gortmaker@windriver.com>
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org
Message-ID: <20170122163237.DroKJVxCx_JcBvhRVv4kBJomACwPM1ydX7goua9P63c@z>

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.
Since the file does have some EXPORT_SYMBOL, we add export.h include.

Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arc/mm/extable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arc/mm/extable.c b/arch/arc/mm/extable.c
index aa652e281324..c86906b41bfe 100644
--- a/arch/arc/mm/extable.c
+++ b/arch/arc/mm/extable.c
@@ -8,7 +8,8 @@
  * Borrowed heavily from MIPS
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
-- 
2.11.0

