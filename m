From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 4/4] dma-debug: Allow poisoning nonzero allocations
Date: Fri, 25 Sep 2015 13:15:46 +0100
Message-ID: <0405c6131def5aa179ff4ba5d4201ebde89cede3.1443178314.git.robin.murphy@arm.com>
References: <cover.1443178314.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <cover.1443178314.git.robin.murphy@arm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, m.szyprowski@samsung.com, sumit.semwal@linaro.org, sakari.ailus@iki.fi, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Since some dma_alloc_coherent implementations return a zeroed buffer
regardless of whether __GFP_ZERO is passed, there exist drivers which
are implicitly dependent on this and pass otherwise uninitialised
buffers to hardware. This can lead to subtle and awkward-to-debug issues
using those drivers on different platforms, where nonzero uninitialised
junk may for instance occasionally look like a valid command which
causes the hardware to start misbehaving. To help with debugging such
issues, add the option to make uninitialised buffers much more obvious.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/asm-generic/dma-mapping-common.h |  2 +-
 include/linux/dma-debug.h                |  6 ++++--
 include/linux/poison.h                   |  3 +++
 lib/Kconfig.debug                        | 10 ++++++++++
 lib/dma-debug.c                          |  6 +++++-
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic=
/dma-mapping-common.h
index b1bc954..0f3e16b 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -260,7 +260,7 @@ static inline void *dma_alloc_attrs(struct device *dev,=
 size_t size,
 =09=09return NULL;
=20
 =09cpu_addr =3D ops->alloc(dev, size, dma_handle, flag, attrs);
-=09debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
+=09debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, flag);
 =09return cpu_addr;
 }
=20
diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index fe8cb61..e5f539d 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -51,7 +51,8 @@ extern void debug_dma_unmap_sg(struct device *dev, struct=
 scatterlist *sglist,
 =09=09=09       int nelems, int dir);
=20
 extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
-=09=09=09=09     dma_addr_t dma_addr, void *virt);
+=09=09=09=09     dma_addr_t dma_addr, void *virt,
+=09=09=09=09     gfp_t flags);
=20
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 =09=09=09=09    void *virt, dma_addr_t addr);
@@ -132,7 +133,8 @@ static inline void debug_dma_unmap_sg(struct device *de=
v,
 }
=20
 static inline void debug_dma_alloc_coherent(struct device *dev, size_t siz=
e,
-=09=09=09=09=09    dma_addr_t dma_addr, void *virt)
+=09=09=09=09=09    dma_addr_t dma_addr, void *virt,
+=09=09=09=09=09    gfp_t flags)
 {
 }
=20
diff --git a/include/linux/poison.h b/include/linux/poison.h
index 317e16d..174104e 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -73,6 +73,9 @@
 #define MUTEX_DEBUG_INIT=090x11
 #define MUTEX_DEBUG_FREE=090x22
=20
+/********** lib/dma_debug.c **********/
+#define DMA_ALLOC_POISON=090xee
+
 /********** lib/flex_array.c **********/
 #define FLEX_ARRAY_FREE=090x6c=09/* for use-after-free poisoning */
=20
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ab76b99..f2da7a1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1752,6 +1752,16 @@ config DMA_API_DEBUG
=20
 =09  If unsure, say N.
=20
+config DMA_API_DEBUG_POISON
+=09bool "Poison coherent DMA buffers"
+=09depends on DMA_API_DEBUG && EXPERT
+=09help
+=09  Poison DMA buffers returned by dma_alloc_coherent unless __GFP_ZERO
+=09  is explicitly specified, to catch drivers depending on zeroed buffers
+=09  without passing the correct flags.
+
+=09  Only say Y if you're prepared for almost everything to break.
+
 config TEST_LKM
 =09tristate "Test module loading with 'hello world' module"
 =09default n
diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 908fb35..40514ed 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
+#include <linux/poison.h>
 #include <linux/slab.h>
=20
 #include <asm/sections.h>
@@ -1447,7 +1448,7 @@ void debug_dma_unmap_sg(struct device *dev, struct sc=
atterlist *sglist,
 EXPORT_SYMBOL(debug_dma_unmap_sg);
=20
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
-=09=09=09      dma_addr_t dma_addr, void *virt)
+=09=09=09      dma_addr_t dma_addr, void *virt, gfp_t flags)
 {
 =09struct dma_debug_entry *entry;
=20
@@ -1457,6 +1458,9 @@ void debug_dma_alloc_coherent(struct device *dev, siz=
e_t size,
 =09if (unlikely(virt =3D=3D NULL))
 =09=09return;
=20
+=09if (IS_ENABLED(CONFIG_DMA_API_DEBUG_POISON) && !(flags & __GFP_ZERO))
+=09=09memset(virt, DMA_ALLOC_POISON, size);
+
 =09entry =3D dma_entry_alloc();
 =09if (!entry)
 =09=09return;
--=20
1.9.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
