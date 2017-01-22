From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 16/20] unicore32: migrate exception table users off module.h and onto extable.h
Date: Sun, 22 Jan 2017 11:32:40 -0500
Message-ID: <20170122163244.11740-17-paul.gortmaker@windriver.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60053 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdAVQdr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2017 11:33:47 -0500
In-Reply-To: <20170122163244.11740-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

This file was only including module.h for exception table related
functions.  We've now separated that content out into its own file
"extable.h" so now move over to that and avoid all the extra header
content in module.h that we don't really need to compile this file.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/unicore32/mm/extable.c | 2 +-
 arch/unicore32/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/mm/extable.c b/arch/unicore32/mm/extable.c
index 6564180eb285..c562046947ba 100644
--- a/arch/unicore32/mm/extable.c
+++ b/arch/unicore32/mm/extable.c
@@ -9,7 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/unicore32/mm/fault.c b/arch/unicore32/mm/fault.c
index 6c7f70bcaae3..b656d216a8a8 100644
--- a/arch/unicore32/mm/fault.c
+++ b/arch/unicore32/mm/fault.c
@@ -9,7 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
-- 
2.11.0
