From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 33/35] x86: Change e820_any_mapped() to __init
Date: Thu, 13 May 2010 17:19:54 -0700
Message-ID: <1273796396-29649-34-git-send-email-yinghai@kernel.org>
References: <1273796396-29649-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273796396-29649-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

We don't need to expose e820_any_mapped() anymore

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/kernel/e820.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f4b1285..0e30c2e 100644
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
