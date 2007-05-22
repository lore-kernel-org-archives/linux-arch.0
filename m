Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:4679 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885AbXEVWrk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2007 18:47:40 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 5/8] IA64: SPARSEMEM_VMEMMAP 16K page size support
References: <exportbomb.1179873917@pinky>
Message-Id: <E1HqdLD-0003fb-PF@hellhawk.shadowen.org>
Date: Wed, 23 May 2007 00:00:31 +0100
Sender: linux-arch-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>


Equip IA64 sparsemem with a virtual memmap. This is similar to the
existing CONFIG_VIRTUAL_MEM_MAP functionality for DISCONTIGMEM.
It uses a PAGE_SIZE mapping.

This is provided as a minimally intrusive solution. We split the
128TB VMALLOC area into two 64TB areas and use one for the virtual
memmap.

This should replace CONFIG_VIRTUAL_MEM_MAP long term.

From: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Acked-by: Mel Gorman <mel@csn.ul.ie>
---
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index de1bff6..9d0d101 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -355,6 +355,10 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	depends on ARCH_DISCONTIGMEM_ENABLE
 
+config SPARSEMEM_VMEMMAP
+	def_bool y
+	depends on SPARSEMEM
+
 config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB)
 	depends on ARCH_DISCONTIGMEM_ENABLE
diff --git a/include/asm-ia64/pgtable.h b/include/asm-ia64/pgtable.h
index 670b706..366c34b 100644
--- a/include/asm-ia64/pgtable.h
+++ b/include/asm-ia64/pgtable.h
@@ -236,8 +236,14 @@ ia64_phys_addr_valid (unsigned long addr)
 # define VMALLOC_END		vmalloc_end
   extern unsigned long vmalloc_end;
 #else
+#if defined(CONFIG_SPARSEMEM) && defined(CONFIG_SPARSEMEM_VMEMMAP)
+/* SPARSEMEM_VMEMMAP uses half of vmalloc... */
+# define VMALLOC_END		(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 10)))
+# define vmemmap		((struct page *)VMALLOC_END)
+#else
 # define VMALLOC_END		(RGN_BASE(RGN_GATE) + (1UL << (4*PAGE_SHIFT - 9)))
 #endif
+#endif
 
 /* fs/proc/kcore.c */
 #define	kc_vaddr_to_offset(v) ((v) - RGN_BASE(RGN_GATE))
