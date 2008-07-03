From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 4/8] m68k: fix implicit declaration of function 'PAGE_ALIGN'
Date: Thu,  3 Jul 2008 11:59:27 +0200
Message-ID: <1215079171-22637-5-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12597
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754843AbYGCMeT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:34:19 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/m68k/amiga/chipram.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/amiga/chipram.c b/arch/m68k/amiga/chipram.c
index cbe3653..61df1d3 100644
--- a/arch/m68k/amiga/chipram.c
+++ b/arch/m68k/amiga/chipram.c
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
-- 
1.5.4.3
