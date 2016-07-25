Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:60952 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752801AbcGYDn5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 24 Jul 2016 23:43:57 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 03/14] arm: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:36 -0400
Message-ID: <20160725034247.109173-4-paul.gortmaker@windriver.com>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <20160725034236.6-Hb09JOAY9oEYQABJLGdsH4eWKv2LJztew2JY_WWqg@z>

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
2.8.4

