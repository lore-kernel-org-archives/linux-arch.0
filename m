From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 10/14] tile: migrate exception table users off module.h and onto extable.h
Date: Sun, 24 Jul 2016 23:42:43 -0400
Message-ID: <20160725034247.109173-11-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:36403 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbcGYDnp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jul 2016 23:43:45 -0400
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Chris Metcalf <cmetcalf@mellanox.com>

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Chris Metcalf <cmetcalf@mellanox.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/tile/kernel/unaligned.c | 2 +-
 arch/tile/mm/extable.c       | 2 +-
 arch/tile/mm/fault.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/tile/kernel/unaligned.c b/arch/tile/kernel/unaligned.c
index 9772a3554282..4fe78c5b8394 100644
--- a/arch/tile/kernel/unaligned.c
+++ b/arch/tile/kernel/unaligned.c
@@ -22,7 +22,7 @@
 #include <linux/mman.h>
 #include <linux/types.h>
 #include <linux/err.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/compat.h>
 #include <linux/prctl.h>
 #include <asm/cacheflush.h>
diff --git a/arch/tile/mm/extable.c b/arch/tile/mm/extable.c
index 4fb0acb9d154..aeaf20c7aaa4 100644
--- a/arch/tile/mm/extable.c
+++ b/arch/tile/mm/extable.c
@@ -12,7 +12,7 @@
  *   more details.
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 
diff --git a/arch/tile/mm/fault.c b/arch/tile/mm/fault.c
index beba986589e5..709f8e9ba3e9 100644
--- a/arch/tile/mm/fault.c
+++ b/arch/tile/mm/fault.c
@@ -29,7 +29,7 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/highmem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kprobes.h>
 #include <linux/hugetlb.h>
 #include <linux/syscalls.h>
-- 
2.8.4
