Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1625 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932745AbbJIWVg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Oct 2015 18:21:36 -0400
Subject: [PATCH 03/20] ia64: introduce arch_memremap()
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 09 Oct 2015 18:15:53 -0400
Message-ID: <20151009221553.32203.23192.stgit@dwillia2-desk3.jf.intel.com>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Ross Zwisler <ross.zwisler@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20151009221553.ex9nFeqGYHg0NTdu9nvdSMHp_8RRJmiQdK2_YzxUukw@z>

In preparation for removing ioremap_cache() introduce arch_memremap()
for ia64.  Given that ia64 does not allow external control for caching
types, this simply aliases arch_memremap() with the ia64 ioremap()
implementation.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/ia64/Kconfig      |    1 +
 arch/ia64/mm/ioremap.c |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index eb0249e37981..b39bab1da7dd 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -52,6 +52,7 @@ config IA64
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_HAS_MEMREMAP
 	select HAVE_ARCH_AUDITSYSCALL
 	default y
 	help
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 43964cde6214..53a1faa0e5da 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -101,6 +101,16 @@ ioremap (unsigned long phys_addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
+/*
+ * Cache mapping-type is determined internal to ioremap and can't be
+ * externally specified
+ */
+void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags)
+{
+	return (void __force *) ioremap(offset, size);
+}
+EXPORT_SYMBOL(arch_memremap);
+
 void __iomem *
 ioremap_nocache (unsigned long phys_addr, unsigned long size)
 {

