From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 2/3] asm-generic/io.h: Remove unused generic __ioremap()
 definition
Date: Fri, 17 Mar 2017 12:46:51 -0500
Message-ID: <20170317174651.6308.69605.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170317172752.6308.91062.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbdCQRrX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Mar 2017 13:47:23 -0400
In-Reply-To: <20170317172752.6308.91062.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org

Several arches use __ioremap() to help implement the generic ioremap(),
ioremap_nocache(), and ioremap_wc() interfaces, but this usage is all
inside the arch/ directory.

The only __ioremap() uses outside arch/ are in the ZorroII RAM disk driver
and some framebuffer drivers that are only buildable on m68k and powerpc,
and they use the versions provided by those arches.

There's no need for a generic version of __ioremap(), so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/asm-generic/io.h |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 978d2e27ce1d..e0a331a22346 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -843,15 +843,6 @@ static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 }
 #endif
 
-#ifndef __ioremap
-#define __ioremap __ioremap
-static inline void __iomem *__ioremap(phys_addr_t offset, size_t size,
-				      unsigned long flags)
-{
-	return ioremap(offset, size);
-}
-#endif
-
 #ifndef ioremap_nocache
 #define ioremap_nocache ioremap_nocache
 static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
