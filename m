Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56035 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940682AbdAIUlg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2017 15:41:36 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 04/10] arm: migrate exception table users off module.h and onto extable.h
Date: Mon, 9 Jan 2017 15:40:04 -0500
Message-ID: <20170109204010.5047-5-paul.gortmaker@windriver.com>
In-Reply-To: <20170109204010.5047-1-paul.gortmaker@windriver.com>
References: <20170109204010.5047-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <20170109204004.BLT_HwteAbIbMb0OuDy-hbqeD69X6NitAFrlstu5m4o@z>

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mm/extable.c | 2 +-
 arch/arm/mm/fault.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/extable.c b/arch/arm/mm/extable.c
index 312e15e6d00b..f436f7439e46 100644
--- a/arch/arm/mm/extable.c
+++ b/arch/arm/mm/extable.c
@@ -1,7 +1,7 @@
 /*
  *  linux/arch/arm/mm/extable.c
  */
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3a2e678b8d30..94de590db99e 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -8,7 +8,7 @@
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

