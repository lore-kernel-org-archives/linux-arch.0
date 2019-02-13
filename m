From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/8] mm: unexport free_reserved_area
Date: Wed, 13 Feb 2019 18:46:14 +0100
Message-ID: <20190213174621.29297-2-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

This function is only used by built-in code, which makes perfect
sense given the purpose of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 35fdde041f5c..45f12a42709d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7255,7 +7255,6 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 
 	return pages;
 }
-EXPORT_SYMBOL(free_reserved_area);
 
 #ifdef	CONFIG_HIGHMEM
 void free_highmem_page(struct page *page)
-- 
2.20.1
