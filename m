Return-Path: <rppt@linux.ibm.com>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 4/4] riscv: switch over to generic free_initmem()
Date: Mon, 18 Feb 2019 20:41:25 +0200
Message-ID: <1550515285-17446-5-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
References: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20190218184125.mhH2hZ9ysmtdGolujFT2Laz2TDknsVXKKux8QhRCos8@z>

The riscv version of free_initmem() differs from the generic one only in
that it sets the freed memory to zero.

Make ricsv use the generic version and poison the freed memory.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/mm/init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 658ebf6..2af0010 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -60,11 +60,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(0);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-- 
2.7.4
