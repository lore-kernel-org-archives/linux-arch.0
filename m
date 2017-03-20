From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/4] asm-generic/io.h: Drop ioremap_uc() stub for systems
 with MMU
Date: Mon, 20 Mar 2017 13:43:07 -0500
Message-ID: <20170320184307.4858.40982.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

8c7ea50c010b ("x86/mm, asm-generic: Add IOMMU ioremap_uc() variant
default") added a default ioremap_uc() implementation that always returns
NULL to indicate failure.

For arches that don't implement their own ioremap_uc(), the default
implementation allows us to *build* drivers that use ioremap_uc(), but they
won't work.

Remove the default ioremap_uc() so a driver that depends on it will fail at
build-time rather than at run-time.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/asm-generic/io.h |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 3f8a7e589071..7b0617d2d210 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -798,29 +798,15 @@ static inline void *phys_to_virt(unsigned long address)
 }
 #endif
 
+#ifndef CONFIG_MMU
+
 /**
  * DOC: ioremap() and ioremap_*() variants
  *
  * If you have an MMU, your architecture must implement both ioremap() and
- * iounmap().
+ * iounmap(), as well as variants like ioremap_nocache(), ioremap_uc(),
+ * and ioremap_wc().
  *
- * It must also implement variants such as ioremap_uc().  The default
- * implementation here returns failure (NULL) to avoid improper behavior.
- */
-
-#ifdef CONFIG_MMU
-
-#ifndef ioremap_uc
-#define ioremap_uc ioremap_uc
-static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
-{
-	return NULL;
-}
-#endif
-
-#else /* !CONFIG_MMU */
-
-/*
  * If you don't have an MMU, the default implementations here provide
  * direct identity mapping.  You can override these if necessary.
  */
