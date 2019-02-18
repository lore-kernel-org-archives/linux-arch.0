From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 2/4] hexagon: switch over to generic free_initmem()
Date: Mon, 18 Feb 2019 20:41:23 +0200
Message-ID: <1550515285-17446-3-git-send-email-rppt@linux.ibm.com>
References: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

hexagon implementation of free_initmem() is currently empty and marked with
comment

 * Todo:  free pages between __init_begin and __init_end; possibly
 * some devtree related stuff as well.

Switch it to the generic implementation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/hexagon/mm/init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 1719ede..41cf342 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -85,16 +85,6 @@ void __init mem_init(void)
 }
 
 /*
- * free_initmem - frees memory used by stuff declared with __init
- *
- * Todo:  free pages between __init_begin and __init_end; possibly
- * some devtree related stuff as well.
- */
-void __ref free_initmem(void)
-{
-}
-
-/*
  * free_initrd_mem - frees...  initrd memory.
  * @start - start of init memory
  * @end - end of init memory
-- 
2.7.4
