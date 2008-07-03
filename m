From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 1/8] arm: fix implicit declaration of function 'PAGE_ALIGN'
Date: Thu,  3 Jul 2008 11:59:24 +0200
Message-ID: <1215079171-22637-2-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12609
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760462AbYGCMoO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:44:14 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/arm/plat-omap/fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 96d6f06..5d10752 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -23,6 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/bootmem.h>
-- 
1.5.4.3
