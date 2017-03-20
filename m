Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753084AbdCTSmu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 14:42:50 -0400
Subject: [PATCH v2 1/4] asm-generic/io.h: Fix "IOMMU" typos
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 20 Mar 2017 13:42:46 -0500
Message-ID: <20170320184246.4858.15836.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Message-ID: <20170320184246.MXkmT6ejbwAwYxVgIVq9g-luMWhboOS4unb6L7dpAD4@z>

The ioremap() block comment refers to "IOMMU" when it means "MMU".  Fix
these typos to avoid confusion.

Fixes: 8c7ea50c010b ("x86/mm, asm-generic: Add IOMMU ioremap_uc() variant default")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/io.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ef015eb3403..978d2e27ce1d 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -802,16 +802,16 @@ static inline void *phys_to_virt(unsigned long address)
 /**
  * DOC: ioremap() and ioremap_*() variants
  *
- * If you have an IOMMU your architecture is expected to have both ioremap()
+ * If you have an MMU your architecture is expected to have both ioremap()
  * and iounmap() implemented otherwise the asm-generic helpers will provide a
  * direct mapping.
  *
- * There are ioremap_*() call variants, if you have no IOMMU we naturally will
+ * There are ioremap_*() call variants, if you have no MMU we naturally will
  * default to direct mapping for all of them, you can override these defaults.
- * If you have an IOMMU you are highly encouraged to provide your own
+ * If you have an MMU you are highly encouraged to provide your own
  * ioremap variant implementation as there currently is no safe architecture
  * agnostic default. To avoid possible improper behaviour default asm-generic
- * ioremap_*() variants all return NULL when an IOMMU is available. If you've
+ * ioremap_*() variants all return NULL when an MMU is available. If you've
  * defined your own ioremap_*() variant you must then declare your own
  * ioremap_*() variant as defined to itself to avoid the default NULL return.
  */
