From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 8/9] parisc: Provide dummy dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 27 Jan 2013 11:33:27 +0100
Message-ID: <1359282808-31398-9-git-send-email-geert@linux-m68k.org>
References: <1359282808-31398-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1359282808-31398-1-git-send-email-geert@linux-m68k.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Szyprowski <m.szyprowski@samsung.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

parisc/allmodconfig:

drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98vb=
2_dc_mmap=E2=80=99:
drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit dec=
laration of function =E2=80=98dma_mmap_coherent=E2=80=99
drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98vb=
2_dc_get_base_sgt=E2=80=99:
drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit dec=
laration of function =E2=80=98dma_get_sgtable=E2=80=99

=46or architectures using dma_map_ops, dma_mmap_coherent() and
dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>.

Parisc does not use dma_map_ops, hence it should implement them itself.
=46or now, use dummy implementations that just return -EINVAL, until th=
e
API has been finalized, as it cannot be supported on PA-RISC as-is.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-parisc@vger.kernel.org
---
v2: Dummy implementations that just return -EINVAL
---
 arch/parisc/include/asm/dma-mapping.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/parisc/include/asm/dma-mapping.h b/arch/parisc/includ=
e/asm/dma-mapping.h
index 467bbd5..106b395 100644
--- a/arch/parisc/include/asm/dma-mapping.h
+++ b/arch/parisc/include/asm/dma-mapping.h
@@ -238,4 +238,19 @@ void * sba_get_iommu(struct parisc_device *dev);
 /* At the moment, we panic on error for IOMMU resource exaustion */
 #define dma_mapping_error(dev, x)	0
=20
+/* This API cannot be supported on PA-RISC */
+static inline int dma_mmap_coherent(struct device *dev,
+				    struct vm_area_struct *vma, void *cpu_addr,
+				    dma_addr_t dma_addr, size_t size)
+{
+	return -EINVAL;
+}
+
+static inline int dma_get_sgtable(struct device *dev, struct sg_table =
*sgt,
+				  void *cpu_addr, dma_addr_t dma_addr,
+				  size_t size)
+{
+	return -EINVAL;
+}
+
 #endif
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
