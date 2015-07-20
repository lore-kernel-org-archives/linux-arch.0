Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20209 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755134AbbGTAYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Jul 2015 20:24:22 -0400
Subject: [PATCH 08/10] arch: introduce strict_ioremap
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 19 Jul 2015 20:18:17 -0400
Message-ID: <20150720001817.30857.69287.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
Message-ID: <20150720001817.43TDd0kX9ht3zCX6tIwuUZ_Fff5417psfGDQjADLJW0@z>

In preparation for enabling memremap(), add support for strict mappings.
strict_ioremap_<type>() returns NULL if the arch does not implement the
mapping type, rather than falling back silently to ioremap().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/io.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index 58482241c95c..080a4fbf2ba4 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -130,6 +130,27 @@ static inline void __iomem *ioremap_uc(resource_size_t offset,
 }
 #endif
 
+static inline void __iomem *strict_ioremap_cache(resource_size_t offset,
+		unsigned long size)
+{
+#ifdef ioremap_cache
+	return ioremap_cache(offset, size);
+#else
+	return (void __force __iomem *) NULL;
+#endif
+}
+
+static inline void __iomem *strict_ioremap_wt(resource_size_t offset,
+		unsigned long size)
+{
+#ifdef ioremap_wt
+	return ioremap_wt(offset, size);
+#else
+	return (void __force __iomem *) NULL;
+#endif
+}
+
+
 /*
  * Some systems do not have legacy ISA devices.
  * /dev/port is not a valid interface on these systems.

