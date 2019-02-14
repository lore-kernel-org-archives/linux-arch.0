From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/4] init: free_initmem: poison freed init memory
Date: Thu, 14 Feb 2019 17:59:36 +0200
Message-ID: <1550159977-8949-4-git-send-email-rppt@linux.ibm.com>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

Various architectures including x86 poison the freed init memory.
Do the same in the generic free_initmem implementation and switch sparc32
architecture that is identical to the generic code over to it now.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/mm/init_32.c | 5 -----
 init/main.c             | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d900952..77e8341 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -294,11 +294,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-void free_initmem (void)
-{
-	free_initmem_default(POISON_FREE_INITMEM);
-}
-
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
diff --git a/init/main.c b/init/main.c
index 38d69e0..9a61e9c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1049,7 +1049,7 @@ static inline void mark_readonly(void)
 
 void __weak free_initmem(void)
 {
-	free_initmem_default(-1);
+	free_initmem_default(POISON_FREE_INITMEM);
 }
 
 static int __ref kernel_init(void *unused)
-- 
2.7.4
