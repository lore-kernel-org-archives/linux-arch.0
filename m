Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:1628 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760872AbXHJOmC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Aug 2007 10:42:02 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 4/5] vmemmap sparc64: convert to new config options
References: <exportbomb.1186756801@pinky>
Message-Id: <E1IJVg2-000553-Rf@localhost.localdomain>
Date: Fri, 10 Aug 2007 15:41:22 +0100
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>


Convert over to the new Kconfig options.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 arch/sparc64/Kconfig   |    9 +--------
 arch/sparc64/mm/init.c |    4 ++--
 2 files changed, 3 insertions(+), 10 deletions(-)
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 9953b4e..59c4d75 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -240,20 +240,13 @@ config ARCH_SELECT_MEMORY_MODEL
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
+	select SPARSEMEM_VMEMMAP_ENABLE
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
 source "mm/Kconfig"
 
-config SPARSEMEM_VMEMMAP
-	def_bool y
-	depends on SPARSEMEM
-
-config ARCH_POPULATES_SPARSEMEM_VMEMMAP
-	def_bool y
-	depends on SPARSEMEM_VMEMMAP
-
 config ISA
 	bool
 	help
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 19cac53..4e1df9a 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1655,7 +1655,7 @@ EXPORT_SYMBOL(_PAGE_E);
 unsigned long _PAGE_CACHE __read_mostly;
 EXPORT_SYMBOL(_PAGE_CACHE);
 
-#ifdef CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 
 #define VMEMMAP_CHUNK_SHIFT	22
 #define VMEMMAP_CHUNK		(1UL << VMEMMAP_CHUNK_SHIFT)
@@ -1705,7 +1705,7 @@ int __meminit vmemmap_populate(struct page *start, unsigned long nr, int node)
 	}
 	return 0;
 }
-#endif /* CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP */
+#endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 static void prot_init_common(unsigned long page_none,
 			     unsigned long page_shared,
