From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/4] m68k/mm: motorola - Add missing initialization of max_pfn
Date: Sun, 15 Nov 2015 12:04:12 +0100
Message-ID: <1447585455-19671-2-git-send-email-geert@linux-m68k.org>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:60367 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbKOLnN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Nov 2015 06:43:13 -0500
In-Reply-To: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@uclinux.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If max_pfn is not initialized, the various /proc/kpage* files are empty,
and selftests/vm/mlock2-tests will fail. max_pfn is also used by the
block layer to calculate DMA masks.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mm/motorola.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index b958916e5eac96b2..8f37fdd80be9e9cc 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -250,7 +250,7 @@ void __init paging_init(void)
 	high_memory = phys_to_virt(max_addr);
 
 	min_low_pfn = availmem >> PAGE_SHIFT;
-	max_low_pfn = max_addr >> PAGE_SHIFT;
+	max_pfn = max_low_pfn = max_addr >> PAGE_SHIFT;
 
 	for (i = 0; i < m68k_num_memory; i++) {
 		addr = m68k_memory[i].addr;
-- 
1.9.1
