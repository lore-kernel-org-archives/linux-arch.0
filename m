From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 07/10] devm: fix ioremap_cache() usage
Date: Sun, 19 Jul 2015 20:18:11 -0400
Message-ID: <20150720001811.30857.92541.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63738 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754854AbbGTAXz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Jul 2015 20:23:55 -0400
In-Reply-To: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, hch@lst.de, linux-arm-kernel@lists.infradead.org

Provide devm_ioremap_cache() and fix up devm_ioremap_resource() to
actually provide cacheable mappings.  On archs that implement
ioremap_cache() devm_ioremap_resource() is always silently falling back
to uncached when IORESOURCE_CACHEABLE is specified.

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/io.h |    2 ++
 lib/devres.c       |   53 +++++++++++++++++++++++++---------------------------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index a4b2c1b2aaee..58482241c95c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -71,6 +71,8 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size);
+void __iomem *devm_ioremap_cache(struct device *dev, resource_size_t offset,
+			   resource_size_t size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
diff --git a/lib/devres.c b/lib/devres.c
index dafbad21bfab..eefdebd9f903 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -34,6 +34,8 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
 	return *(void **)res == match_data;
 }
 
+typedef void __iomem *(*ioremap_fn)(resource_size_t offset, unsigned long size);
+
 /**
  * devm_ioremap - Managed ioremap()
  * @dev: Generic device to remap IO address for
@@ -42,8 +44,9 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
  *
  * Managed ioremap().  Map is automatically unmapped on driver detach.
  */
-void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
-			   resource_size_t size)
+static void __iomem *devm_ioremap_type(struct device *dev,
+		resource_size_t offset, resource_size_t size,
+		ioremap_fn ioremap_type)
 {
 	void __iomem **ptr, *addr;
 
@@ -51,7 +54,7 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 	if (!ptr)
 		return NULL;
 
-	addr = ioremap(offset, size);
+	addr = ioremap_type(offset, size);
 	if (addr) {
 		*ptr = addr;
 		devres_add(dev, ptr);
@@ -60,34 +63,25 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 
 	return addr;
 }
+
+void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
+			   resource_size_t size)
+{
+	return devm_ioremap_type(dev, offset, size, ioremap);
+}
 EXPORT_SYMBOL(devm_ioremap);
 
-/**
- * devm_ioremap_nocache - Managed ioremap_nocache()
- * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
- * @size: Size of map
- *
- * Managed ioremap_nocache().  Map is automatically unmapped on driver
- * detach.
- */
+void __iomem *devm_ioremap_cache(struct device *dev, resource_size_t offset,
+			   resource_size_t size)
+{
+	return devm_ioremap_type(dev, offset, size, ioremap_cache);
+}
+EXPORT_SYMBOL(devm_ioremap_cache);
+
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size)
 {
-	void __iomem **ptr, *addr;
-
-	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	addr = ioremap_nocache(offset, size);
-	if (addr) {
-		*ptr = addr;
-		devres_add(dev, ptr);
-	} else
-		devres_free(ptr);
-
-	return addr;
+	return devm_ioremap_type(dev, offset, size, ioremap_nocache);
 }
 EXPORT_SYMBOL(devm_ioremap_nocache);
 
@@ -173,8 +167,11 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
-	/* FIXME: add devm_ioremap_cache support */
-	dest_ptr = devm_ioremap(dev, res->start, size);
+	if (res->flags & IORESOURCE_CACHEABLE)
+		dest_ptr = devm_ioremap_cache(dev, res->start, size);
+	else
+		dest_ptr = devm_ioremap_nocache(dev, res->start, size);
+
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
 		devm_release_mem_region(dev, res->start, size);
