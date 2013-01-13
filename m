From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 7/9] mn10300: Provide dma_mmap_coherent() and dma_get_sgtable()
Date: Sun, 13 Jan 2013 11:44:48 +0100
Message-ID: <1358073890-3610-7-git-send-email-geert@linux-m68k.org>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-am33-list@redhat.com
List-Id: linux-arch.vger.kernel.org

mn10300/allmodconfig:

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

Mn10300 does not use dma_map_ops, hence it should implement them as inl=
ine
stubs using dma_common_mmap() and dma_common_get_sgtable().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-am33-list@redhat.com
---
 arch/mn10300/include/asm/dma-mapping.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mn10300/include/asm/dma-mapping.h b/arch/mn10300/incl=
ude/asm/dma-mapping.h
index c1be439..f7a4311 100644
--- a/arch/mn10300/include/asm/dma-mapping.h
+++ b/arch/mn10300/include/asm/dma-mapping.h
@@ -168,4 +168,14 @@ void dma_cache_sync(void *vaddr, size_t size,
 	mn10300_dcache_flush_inv();
 }
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
 #endif
--=20
1.7.0.4
