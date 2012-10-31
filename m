From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 34/40] musb: don't redefine {read,write}s{l,w,b} on metag
Date: Wed, 31 Oct 2012 16:14:15 +0000
Message-ID: <1351700061-7203-35-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49661 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423210Ab2JaQPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:15:23 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

musb_io.h redefines {read,write}s{l,w,b} functions if the architecture
doesn't match in a particular set. The metag architecture already
defines them which causes compiler errors, so add METAG to the set of
architectures to exclude.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 drivers/usb/musb/musb_io.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
index f7c1c8e..8914872 100644
--- a/drivers/usb/musb/musb_io.h
+++ b/drivers/usb/musb/musb_io.h
@@ -40,7 +40,8 @@
 #if !defined(CONFIG_ARM) && !defined(CONFIG_SUPERH) \
 	&& !defined(CONFIG_AVR32) && !defined(CONFIG_PPC32) \
 	&& !defined(CONFIG_PPC64) && !defined(CONFIG_BLACKFIN) \
-	&& !defined(CONFIG_MIPS) && !defined(CONFIG_M68K)
+	&& !defined(CONFIG_MIPS) && !defined(CONFIG_M68K) \
+	&& !defined(CONFIG_METAG)
 static inline void readsl(const void __iomem *addr, void *buf, int len)
 	{ insl((unsigned long)addr, buf, len); }
 static inline void readsw(const void __iomem *addr, void *buf, int len)
-- 
1.7.7.6
