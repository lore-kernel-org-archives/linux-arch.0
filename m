From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/4] m68k/mm: m54xx - Add missing initialization of max_pfn
Date: Sun, 15 Nov 2015 12:04:13 +0100
Message-ID: <1447585455-19671-3-git-send-email-geert@linux-m68k.org>
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

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 arch/m68k/coldfire/m54xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/m54xx.c b/arch/m68k/coldfire/m54xx.c
index f7836c6a6b60eb24..c32f76791f488ae1 100644
--- a/arch/m68k/coldfire/m54xx.c
+++ b/arch/m68k/coldfire/m54xx.c
@@ -98,7 +98,7 @@ static void __init mcf54xx_bootmem_alloc(void)
 	memstart = PAGE_ALIGN(_ramstart);
 	min_low_pfn = PFN_DOWN(_rambase);
 	start_pfn = PFN_DOWN(memstart);
-	max_low_pfn = PFN_DOWN(_ramend);
+	max_pfn = max_low_pfn = PFN_DOWN(_ramend);
 	high_memory = (void *)_ramend;
 
 	m68k_virt_to_node_shift = fls(_ramend - _rambase - 1) - 6;
-- 
1.9.1
