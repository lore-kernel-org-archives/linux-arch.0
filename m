Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64374 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbbJIWVl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Oct 2015 18:21:41 -0400
Subject: [PATCH 04/20] sh: introduce arch_memremap()
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 09 Oct 2015 18:15:59 -0400
Message-ID: <20151009221559.32203.37854.stgit@dwillia2-desk3.jf.intel.com>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20151009221559.1rWCuh3Ozjp5e2rT_BembT8koHtAsPYRwkqxAzfQm5s@z>

In preparation for removing ioremap_cache() introduce arch_memremap()
for sh.  This simply enforces that attempts to establish writethrough
mappings fail rather than silently fallback to uncached.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/sh/Kconfig      |    1 +
 arch/sh/mm/ioremap.c |    9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d514df7e04dd..b5801ae0e952 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -54,6 +54,7 @@ config SUPERH32
 	def_bool ARCH = "sh"
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select ARCH_HAS_MEMREMAP
 	select HAVE_IOREMAP_PROT if MMU && !X2TLB
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 0c99ec2e7ed8..ce3819273368 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -86,6 +86,15 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 }
 EXPORT_SYMBOL(__ioremap_caller);
 
+void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags)
+{
+	if ((flags & MEMREMAP_WB) == 0)
+		return NULL;
+
+	return (void __force *) __ioremap_mode(offset, size, PAGE_KERNEL);
+}
+EXPORT_SYMBOL(arch_memremap);
+
 /*
  * Simple checks for non-translatable mappings.
  */

