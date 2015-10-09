From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 15/20] sfi: switch from ioremap_cache to memremap
Date: Fri, 09 Oct 2015 18:16:57 -0400
Message-ID: <20151009221657.32203.42989.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-arch.vger.kernel.org

In preparation for deprecating ioremap_cache() convert its usage in sfi
to memremap.  It's a bit awkward that we go and add back a fake __iomem
annotation, but this is to keep consistency with early_ioremap() which
does not have a 'memremap' flavor.

Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/sfi/sfi_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sfi/sfi_core.c b/drivers/sfi/sfi_core.c
index 296db7a69c27..d9430b845dfa 100644
--- a/drivers/sfi/sfi_core.c
+++ b/drivers/sfi/sfi_core.c
@@ -101,7 +101,7 @@ static void __iomem * __ref sfi_map_memory(u64 phys, u32 size)
 		return NULL;
 
 	if (sfi_use_ioremap)
-		return ioremap_cache(phys, size);
+		return (void __iomem *) memremap(phys, size, MEMREMAP_WB);
 	else
 		return early_ioremap(phys, size);
 }
@@ -112,7 +112,7 @@ static void __ref sfi_unmap_memory(void __iomem *virt, u32 size)
 		return;
 
 	if (sfi_use_ioremap)
-		iounmap(virt);
+		memunmap((void __force *) virt);
 	else
 		early_iounmap(virt, size);
 }
