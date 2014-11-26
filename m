From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 2/2] lib: devres: Add exec versions of devm_ioremap_resource and friends
Date: Wed, 26 Nov 2014 15:14:01 -0600
Message-ID: <bde13d5e7931af9aa90ddc09a79be5c30e3eef94.1417029918.git.d-gerlach@ti.com>
References: <cover.1417029918.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1417029918.git.d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russ Dill <russ.dill-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Anson.Huang-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>

Now that there is an _exec version of ioremap, add devm support for it.

Signed-off-by: Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>
Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
---
 include/linux/device.h |  19 +++++++-
 include/linux/io.h     |   9 +++-
 lib/devres.c           | 125 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 147 insertions(+), 6 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ce1f2160..d336465 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -635,7 +635,24 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+void __iomem *__devm_ioremap_resource(struct device *dev, struct resource *res,
+				      bool exec);
+static inline void __iomem *devm_ioremap_resource(struct device *dev,
+						  struct resource *res)
+{
+	return __devm_ioremap_resource(dev, res, false);
+}
+void __iomem *devm_request_and_ioremap(struct device *dev,
+				       struct resource *res);
+
+static inline void __iomem *devm_ioremap_exec_resource(struct device *dev,
+						       struct resource *res)
+{
+	return __devm_ioremap_resource(dev, res, true);
+}
+
+void __iomem *devm_request_and_ioremap_exec(struct device *dev,
+					    struct resource *res);
 
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
diff --git a/include/linux/io.h b/include/linux/io.h
index d5fc9b8..0c6405a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -61,9 +61,14 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 #define IOMEM_ERR_PTR(err) (__force void __iomem *)ERR_PTR(err)
 
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
-			    unsigned long size);
+			   unsigned long size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
-				    unsigned long size);
+				   unsigned long size);
+void __iomem *devm_ioremap_exec(struct device *dev, resource_size_t offset,
+				unsigned long size);
+void __iomem *devm_ioremap_exec_nocache(struct device *dev,
+					resource_size_t offset,
+					unsigned long size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index f4a195a..f5d0eac 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -72,6 +72,64 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 EXPORT_SYMBOL(devm_ioremap_nocache);
 
 /**
+ * devm_ioremap_exec - Managed ioremap_exec()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_exec().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_exec(struct device *dev, resource_size_t offset,
+				unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_exec(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_exec);
+
+/**
+ * devm_ioremap_exec_nocache - Managed ioremap_exec_nocache()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_exec_nocache().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_ioremap_exec_nocache(struct device *dev,
+					resource_size_t offset,
+					unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_exec_nocache(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_exec_nocache);
+
+/**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
  * @addr: Address to unmap
@@ -104,7 +162,8 @@ EXPORT_SYMBOL(devm_iounmap);
  *	if (IS_ERR(base))
  *		return PTR_ERR(base);
  */
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
+void __iomem *__devm_ioremap_resource(struct device *dev, struct resource *res,
+				      bool exec)
 {
 	resource_size_t size;
 	const char *name;
@@ -125,7 +184,11 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
-	if (res->flags & IORESOURCE_CACHEABLE)
+	if (exec && res->flags & IORESOURCE_CACHEABLE)
+		dest_ptr = devm_ioremap_exec(dev, res->start, size);
+	else if (exec)
+		dest_ptr = devm_ioremap_exec_nocache(dev, res->start, size);
+	else if (res->flags & IORESOURCE_CACHEABLE)
 		dest_ptr = devm_ioremap(dev, res->start, size);
 	else
 		dest_ptr = devm_ioremap_nocache(dev, res->start, size);
@@ -138,7 +201,63 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 
 	return dest_ptr;
 }
-EXPORT_SYMBOL(devm_ioremap_resource);
+EXPORT_SYMBOL(__devm_ioremap_resource);
+
+/**
+ * devm_request_and_ioremap() - Check, request region, and ioremap resource
+ * @dev: Generic device to handle the resource for
+ * @res: resource to be handled
+ *
+ * Takes all necessary steps to ioremap a mem resource. Uses managed device, so
+ * everything is undone on driver detach. Checks arguments, so you can feed
+ * it the result from e.g. platform_get_resource() directly. Returns the
+ * remapped pointer or NULL on error. Usage example:
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_request_and_ioremap(&pdev->dev, res);
+ *	if (!base)
+ *		return -EADDRNOTAVAIL;
+ */
+void __iomem *devm_request_and_ioremap(struct device *device,
+				       struct resource *res)
+{
+	void __iomem *dest_ptr;
+
+	dest_ptr = devm_ioremap_resource(device, res);
+	if (IS_ERR(dest_ptr))
+		return NULL;
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL(devm_request_and_ioremap);
+
+/**
+ * devm_request_and_ioremap_exec() - Check, request region, and ioremap resource
+ * @dev: Generic device to handle the resource for
+ * @res: resource to be handled
+ *
+ * Takes all necessary steps to ioremap a mem resource. Uses managed device, so
+ * everything is undone on driver detach. Checks arguments, so you can feed
+ * it the result from e.g. platform_get_resource() directly. Returns the
+ * remapped pointer or NULL on error. Usage example:
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_request_and_ioremap_exec(&pdev->dev, res);
+ *	if (!base)
+ *		return -EADDRNOTAVAIL;
+ */
+void __iomem *devm_request_and_ioremap_exec(struct device *device,
+					    struct resource *res)
+{
+	void __iomem *dest_ptr;
+
+	dest_ptr = devm_ioremap_exec_resource(device, res);
+	if (IS_ERR(dest_ptr))
+		return NULL;
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL(devm_request_and_ioremap_exec);
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 /*
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
