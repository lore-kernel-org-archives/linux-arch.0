From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 1/4] sparc: remove dma64_addr_t usage
Date: Tue, 12 Oct 2010 12:13:12 +0900
Message-ID: <1286853195-32202-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:35332 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0JLDW4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Oct 2010 23:22:56 -0400
In-Reply-To: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>

let's use u64 instead.

Looks like PCI654_REQUIRED_MASK or PCI64_ADR_BASE isn't used. They can
be removed?

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pci_64.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/pci_64.h b/arch/sparc/include/asm/pci_64.h
index 5312782..948b686 100644
--- a/arch/sparc/include/asm/pci_64.h
+++ b/arch/sparc/include/asm/pci_64.h
@@ -38,7 +38,7 @@ static inline void pcibios_penalize_isa_irq(int irq, int active)
  * types on sparc64.  However, it requires that the device
  * can drive enough of the 64 bits.
  */
-#define PCI64_REQUIRED_MASK	(~(dma64_addr_t)0)
+#define PCI64_REQUIRED_MASK	(~(u64)0)
 #define PCI64_ADDR_BASE		0xfffc000000000000UL
 
 #ifdef CONFIG_PCI
-- 
1.7.1
