From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 6/8] mips: fix implicit declarations of function 'PAGE_ALIGN'
Date: Thu,  3 Jul 2008 11:59:29 +0200
Message-ID: <1215079171-22637-7-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12566
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758031AbYGCMOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:14:19 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/mips/kernel/module.c        |    1 +
 arch/mips/sgi-ip27/ip27-klnuma.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
index e7ed0ac..1f60e27 100644
--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -22,6 +22,7 @@
 
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
diff --git a/arch/mips/sgi-ip27/ip27-klnuma.c b/arch/mips/sgi-ip27/ip27-klnuma.c
index 48932ce..d9c79d8 100644
--- a/arch/mips/sgi-ip27/ip27-klnuma.c
+++ b/arch/mips/sgi-ip27/ip27-klnuma.c
@@ -4,6 +4,7 @@
  * Copyright 2000 - 2001 Kanoj Sarcar (kanoj@sgi.com)
  */
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/kernel.h>
 #include <linux/nodemask.h>
-- 
1.5.4.3
