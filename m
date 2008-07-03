From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 5/8] m68knommu: fix implicit declaration of function 'PAGE_ALIGN'
Date: Thu,  3 Jul 2008 11:59:28 +0200
Message-ID: <1215079171-22637-6-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12567
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758034AbYGCMOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:14:19 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/m68knommu/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/m68knommu/kernel/setup.c b/arch/m68knommu/kernel/setup.c
index 03f4fe6..5985f19 100644
--- a/arch/m68knommu/kernel/setup.c
+++ b/arch/m68knommu/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/fb.h>
 #include <linux/module.h>
+#include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/errno.h>
 #include <linux/string.h>
-- 
1.5.4.3
