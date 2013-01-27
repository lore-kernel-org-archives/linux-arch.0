From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/9] c6x: Provide dummy dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 27 Jan 2013 11:33:22 +0100
Message-ID: <1359282808-31398-4-git-send-email-geert@linux-m68k.org>
References: <1359282808-31398-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:59694 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab3A0Kdd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 Jan 2013 05:33:33 -0500
In-Reply-To: <1359282808-31398-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-c6x-dev@linux-c6x.org

c6x/allmodconfig (assumed):

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

C6x does not use dma_map_ops, hence it should implement them itself.
=46or now, use dummy implementations that just return -EINVAL, until th=
e API
has been finalized.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-c6x-dev@linux-c6x.org
---
v2: Dummy implementations that just return -EINVAL

Not compile-tested due to lack of cross-compiler
---
 arch/c6x/include/asm/dma-mapping.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/=
dma-mapping.h
index 3c69406..88bd0d8 100644
--- a/arch/c6x/include/asm/dma-mapping.h
+++ b/arch/c6x/include/asm/dma-mapping.h
@@ -89,4 +89,19 @@ extern void dma_free_coherent(struct device *, size_=
t, void *, dma_addr_t);
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent((d), (s),=
 (h), (f))
 #define dma_free_noncoherent(d, s, v, h)  dma_free_coherent((d), (s), =
(v), (h))
=20
+/* Not supported for now */
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
 #endif	/* _ASM_C6X_DMA_MAPPING_H */
--=20
1.7.0.4
