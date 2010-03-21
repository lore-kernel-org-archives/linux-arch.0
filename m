Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from acsinet11.oracle.com ([141.146.126.233]:28715 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0CUHPz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 21 Mar 2010 03:15:55 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 05/20] x86: make e820 to be initdata
Date: Sun, 21 Mar 2010 00:13:06 -0700
Message-ID: <1269155601-18247-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1269155601-18247-1-git-send-email-yinghai@kernel.org>
References: <1269155601-18247-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20100321071306.XEg6tex0QQ0jQ-doiQri1wMfdzkaqxEn-QWIeAAY8k4@z>

and we don't need to expose e820_any_mapped anymore

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/kernel/e820.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 40c04cf..a558609 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -34,7 +34,7 @@
  * user can e.g. boot the original kernel with mem=1G while still booting the
  * next kernel with full memory.
  */
-static struct e820map e820;
+static struct e820map __initdata e820;
 static struct e820map __initdata e820_saved;
 
 /* For PCI or other memory-mapped resources */
@@ -46,9 +46,10 @@ EXPORT_SYMBOL(pci_mem_start);
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
 
@@ -63,7 +64,6 @@ e820_any_mapped(u64 start, u64 end, unsigned type)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(e820_any_mapped);
 
 /*
  * This function checks if the entire range <start,end> is mapped with type.
-- 
1.6.4.2

