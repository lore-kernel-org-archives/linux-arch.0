From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/4] dmapool: Fix overflow condition in pool_find_page
Date: Fri, 25 Sep 2015 13:15:43 +0100
Message-ID: <be19713dc9e80c6486e86c60a43e149d45b104a3.1443178314.git.robin.murphy@arm.com>
References: <cover.1443178314.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <cover.1443178314.git.robin.murphy@arm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, m.szyprowski@samsung.com, sumit.semwal@linaro.org, sakari.ailus@iki.fi, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

If a DMA pool lies at the very top of the dma_addr_t range (as may
happen with an IOMMU involved), the calculated end address of the pool
wraps around to zero, and page lookup always fails. Tweak the relevant
calculation to be overflow-proof.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 71a8998..312a716 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -394,7 +394,7 @@ static struct dma_page *pool_find_page(struct dma_pool =
*pool, dma_addr_t dma)
 =09list_for_each_entry(page, &pool->page_list, page_list) {
 =09=09if (dma < page->dma)
 =09=09=09continue;
-=09=09if (dma < (page->dma + pool->allocation))
+=09=09if ((dma - page->dma) < pool->allocation)
 =09=09=09return page;
 =09}
 =09return NULL;
--=20
1.9.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
