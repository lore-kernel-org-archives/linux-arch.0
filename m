From: Andrea Righi <righi.andrea@gmail.com>
Subject: [PATCH -mm 3/8] h8300: fix implicit declaration of function 'PAGE_ALIGN'
Date: Thu,  3 Jul 2008 11:59:26 +0200
Message-ID: <1215079171-22637-4-git-send-email-righi.andrea@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from host198-128-dynamic.19-87-r.retail.telecomitalia.it ([87.19.128.198]:12595
	"EHLO linux.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754352AbYGCMeT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jul 2008 08:34:19 -0400
In-Reply-To: <>
References: <>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, paulus@samba.org, balbir@linux.vnet.ibm.com, Andrea Righi <righi.andrea@gmail.com>

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
---
 arch/h8300/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index b1f25c2..7fda657 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/fb.h>
 #include <linux/console.h>
-- 
1.5.4.3
