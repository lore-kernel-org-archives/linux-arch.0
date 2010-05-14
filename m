From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 35/37] x86: Change e820_any_mapped() to __init
Date: Fri, 14 May 2010 12:46:01 -0700
Message-ID: <1273866363-14249-36-git-send-email-yinghai@kernel.org>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:17318 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab0ENTt5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 15:49:57 -0400
In-Reply-To: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

We don't need to expose e820_any_mapped() anymore

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/kernel/e820.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index eb556d0..c2e18f9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -47,9 +47,10 @@ EXPORT_SYMBOL(pci_mem_start);
 /*
  * This function checks if any part of the range <start,end> is mapped
  * with type.
+ * phys_pud_init() is using it and is _meminit, but we have !after_bootmem
+ * so could use refok here
  */
-int
-e820_any_mapped(u64 start, u64 end, unsigned type)
+int __init_refok e820_any_mapped(u64 start, u64 end, unsigned type)
 {
 	int i;
 
@@ -64,7 +65,6 @@ e820_any_mapped(u64 start, u64 end, unsigned type)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(e820_any_mapped);
 
 /*
  * This function checks if the entire range <start,end> is mapped with type.
-- 
1.6.4.2
