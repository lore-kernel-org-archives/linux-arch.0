From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 11/20] sound, skylake: switch from ioremap_cache to memremap
Date: Fri, 09 Oct 2015 18:16:36 -0400
Message-ID: <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

In preparation for deprecating ioremap_cache() convert its usage in
skl-nhlt to memremap.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c |   10 +++++-----
 sound/soc/intel/skylake/skl.h      |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 13036b19d7e5..b0c7bd113aac 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -25,7 +25,7 @@ static u8 OSC_UUID[16] = {0x6E, 0x88, 0x9F, 0xA6, 0xEB, 0x6C, 0x94, 0x45,
 
 #define DSDT_NHLT_PATH "\\_SB.PCI0.HDAS"
 
-void __iomem *skl_nhlt_init(struct device *dev)
+void *skl_nhlt_init(struct device *dev)
 {
 	acpi_handle handle;
 	union acpi_object *obj;
@@ -40,17 +40,17 @@ void __iomem *skl_nhlt_init(struct device *dev)
 	if (obj && obj->type == ACPI_TYPE_BUFFER) {
 		nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
 
-		return ioremap_cache(nhlt_ptr->min_addr, nhlt_ptr->length);
+		return memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
+				MEMREMAP_WB);
 	}
 
 	dev_err(dev, "device specific method to extract NHLT blob failed\n");
 	return NULL;
 }
 
-void skl_nhlt_free(void __iomem *addr)
+void skl_nhlt_free(void *addr)
 {
-	iounmap(addr);
-	addr = NULL;
+	memunmap(addr);
 }
 
 static struct nhlt_specific_cfg *skl_get_specific_cfg(
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f7fdbb02947f..551c6db25f34 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -55,7 +55,7 @@ struct skl {
 	unsigned int init_failed:1; /* delayed init failed */
 	struct platform_device *dmic_dev;
 
-	void __iomem *nhlt; /* nhlt ptr */
+	void *nhlt; /* nhlt ptr */
 	struct skl_sst *skl_sst; /* sst skl ctx */
 };
 
@@ -72,8 +72,8 @@ struct skl_dma_params {
 int skl_platform_unregister(struct device *dev);
 int skl_platform_register(struct device *dev);
 
-void __iomem *skl_nhlt_init(struct device *dev);
-void skl_nhlt_free(void __iomem *addr);
+void *skl_nhlt_init(struct device *dev);
+void skl_nhlt_free(void *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
 			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
 
