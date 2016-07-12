From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] printk: include <asm/sections.h> instead of <asm-generic/sections.h>
Date: Tue, 12 Jul 2016 09:56:48 +0900
Message-ID: <1468285008-7331-1-git-send-email-hch@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35403 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167AbcGLA4v (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2016 20:56:51 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

asm-generic headers are generic implementations for architecture specific
code and should not be included by common code.  Thus use the asm/ version
of sections.h to get at the linker sections.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 60cdf63..fac6fd4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -48,7 +48,7 @@
 #include <linux/uio.h>
 
 #include <asm/uaccess.h>
-#include <asm-generic/sections.h>
+#include <asm/sections.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/printk.h>
-- 
2.1.4
