From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/4] m68k/mm: sun3 - Add missing initialization of max_pfn and {min,max}_low_pfn
Date: Sun, 15 Nov 2015 12:04:14 +0100
Message-ID: <1447585455-19671-4-git-send-email-geert@linux-m68k.org>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Greg Ungerer <gerg@uclinux.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

If max_pfn is not initialized, the various /proc/kpage* files are empty,
and selftests/vm/mlock2-tests will fail. max_pfn is also used by the
block layer to calculate DMA masks.

Switch from init_bootmem_node() to init_bootmem(), as there's only one
memory node on Sun-3. This will initialize min_low_pfn and max_low_pfn,
which was also not done before.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 arch/m68k/sun3/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index a8b942bf71638c97..2a5f43a68ae3d73d 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -118,13 +118,13 @@ static void __init sun3_bootmem_alloc(unsigned long memory_start,
 	memory_end = memory_end & PAGE_MASK;
 
 	start_page = __pa(memory_start) >> PAGE_SHIFT;
-	num_pages = __pa(memory_end) >> PAGE_SHIFT;
+	max_pfn = num_pages = __pa(memory_end) >> PAGE_SHIFT;
 
 	high_memory = (void *)memory_end;
 	availmem = memory_start;
 
 	m68k_setup_node(0);
-	availmem += init_bootmem_node(NODE_DATA(0), start_page, 0, num_pages);
+	availmem += init_bootmem(start_page, num_pages);
 	availmem = (availmem + (PAGE_SIZE-1)) & PAGE_MASK;
 
 	free_bootmem(__pa(availmem), memory_end - (availmem));
-- 
1.9.1
