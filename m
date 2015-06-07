From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 01/19] ARC: mm/cache_arc700.c -> mm/cache.c
Date: Sun, 7 Jun 2015 14:08:05 +0530
Message-ID: <1433666303-26112-2-git-send-email-vgupta@synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56897 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932772AbbFGIju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:39:50 -0400
In-Reply-To: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/Makefile                    | 2 +-
 arch/arc/mm/{cache_arc700.c => cache.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arc/mm/{cache_arc700.c => cache.c} (100%)

diff --git a/arch/arc/mm/Makefile b/arch/arc/mm/Makefile
index ac95cc239c1e..7beb941556c3 100644
--- a/arch/arc/mm/Makefile
+++ b/arch/arc/mm/Makefile
@@ -7,4 +7,4 @@
 #
 
 obj-y	:= extable.o ioremap.o dma.o fault.o init.o
-obj-y	+= tlb.o tlbex.o cache_arc700.o mmap.o
+obj-y	+= tlb.o tlbex.o cache.o mmap.o
diff --git a/arch/arc/mm/cache_arc700.c b/arch/arc/mm/cache.c
similarity index 100%
rename from arch/arc/mm/cache_arc700.c
rename to arch/arc/mm/cache.c
-- 
1.9.1
