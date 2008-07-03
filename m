From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 7/8] xtensa: fix implicit declaration of function 'PAGE_ALIGN'
Date: Thu,  3 Jul 2008 11:59:30 +0200
Message-ID: <1215079171-22637-8-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12650
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753407AbYGCNOO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 09:14:14 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/xtensa/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 5e6d75c..a00359e 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -16,6 +16,7 @@
 
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/screen_info.h>
 #include <linux/bootmem.h>
-- 
1.5.4.3
