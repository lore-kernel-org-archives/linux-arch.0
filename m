Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:39561 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761498AbXKPXLF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Nov 2007 18:11:05 -0500
Message-Id: <20071116231104.048130087@sgi.com>
References: <20071116230920.278761667@sgi.com>
Date: Fri, 16 Nov 2007 15:09:28 -0800
From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 08/30] cpu_alloc: Sparc64 support
Content-Disposition: inline; filename=cpu_alloc_sparc64
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

Enable a simple virtual configuration with 32MB available per cpu so that
we do not use a static area on sparc64.

[Not tested. I have no sparc64]

Signed-off-by: Christoph Lameter <clameter@sgi.com>

---
 arch/sparc64/Kconfig          |   15 +++++++++++++++
 include/asm-sparc64/pgtable.h |    1 +
 2 files changed, 16 insertions(+)

Index: linux-2.6/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.orig/arch/sparc64/Kconfig	2007-11-15 21:24:46.942815842 -0800
+++ linux-2.6/arch/sparc64/Kconfig	2007-11-15 21:25:27.790904212 -0800
@@ -103,6 +103,21 @@ config SPARC64_PAGE_SIZE_4MB
 
 endchoice
 
+config CPU_AREA_VIRTUAL
+	bool
+	default y
+
+config CPU_AREA_ORDER
+	int
+	default "11" if SPARC64_PAGE_SIZE_8KB
+	default "9" if SPARC64_PAGE_SIZE_64KB
+	default "6" if SPARC64_PAGE_SIZE_512KB
+	default "3" if SPARC64_PAGE_SIZE_4MB
+
+config CPU_AREA_ALLOC_ORDER
+	int
+	default "0"
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
Index: linux-2.6/include/asm-sparc64/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/pgtable.h	2007-11-15 21:24:46.950904404 -0800
+++ linux-2.6/include/asm-sparc64/pgtable.h	2007-11-15 21:25:27.794904145 -0800
@@ -43,6 +43,7 @@
 #define VMALLOC_START		_AC(0x0000000100000000,UL)
 #define VMALLOC_END		_AC(0x0000000200000000,UL)
 #define VMEMMAP_BASE		_AC(0x0000000200000000,UL)
+#define CPU_AREA_BASE		_AC(0x0000000300000000,UL)
 
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 

-- 
