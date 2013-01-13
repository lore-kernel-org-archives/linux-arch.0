From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/9] avr32: Provide dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 13 Jan 2013 11:44:42 +0100
Message-ID: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from juliette.telenet-ops.be ([195.130.137.74]:51173 "EHLO
	juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab3AMKo6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jan 2013 05:44:58 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>

avr32/allmodconfig:

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

Avr32 does not use dma_map_ops, hence it should implement them as inlin=
e
stubs using dma_common_mmap() and dma_common_get_sgtable().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 arch/avr32/include/asm/dma-mapping.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/include/asm/dma-mapping.h b/arch/avr32/include/=
asm/dma-mapping.h
index aaf5199..b3d18f9 100644
--- a/arch/avr32/include/asm/dma-mapping.h
+++ b/arch/avr32/include/asm/dma-mapping.h
@@ -336,4 +336,14 @@ dma_sync_sg_for_device(struct device *dev, struct =
scatterlist *sg,
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, =
f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
=20
+/* drivers/base/dma-mapping.c */
+extern int dma_common_mmap(struct device *dev, struct vm_area_struct *=
vma,
+			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
+extern int dma_common_get_sgtable(struct device *dev, struct sg_table =
*sgt,
+				  void *cpu_addr, dma_addr_t dma_addr,
+				  size_t size);
+
+#define dma_mmap_coherent(d, v, c, h, s) dma_common_mmap(d, v, c, h, s=
)
+#define dma_get_sgtable(d, t, v, h, s) dma_common_get_sgtable(d, t, v,=
 h, s)
+
 #endif /* __ASM_AVR32_DMA_MAPPING_H */
--=20
1.7.0.4
