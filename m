From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 03/20] m32r: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:27 -0500
Message-ID: <20170122163244.11740-4-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:34620 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdAVQdK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:33:10 -0500
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/m32r/mm/extable.c | 2 +-
 arch/m32r/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m32r/mm/extable.c b/arch/m32r/mm/extable.c
index 40ccf80d29cf..8ac8ba6ef60c 100644
--- a/arch/m32r/mm/extable.c
+++ b/arch/m32r/mm/extable.c
@@ -2,7 +2,7 @@
  * linux/arch/m32r/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
index a3785d3644c2..a05dc3184594 100644
--- a/arch/m32r/mm/fault.c
+++ b/arch/m32r/mm/fault.c
@@ -23,7 +23,7 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/highmem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 #include <asm/m32r.h>
-- 
2.11.0
