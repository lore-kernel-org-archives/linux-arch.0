From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 2/4] mips: remove dma64_addr_t usage
Date: Tue, 12 Oct 2010 12:13:13 +0900
Message-ID: <1286853195-32202-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:35336 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0JLDXC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Oct 2010 23:23:02 -0400
In-Reply-To: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

let's use u64 instead.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/include/asm/pci/bridge.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 5f4b9d4..f1f508e 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -839,7 +839,7 @@ struct bridge_controller {
 	nasid_t			nasid;
 	unsigned int		widget_id;
 	unsigned int 		irq_cpu;
-	dma64_addr_t		baddr;
+	u64			baddr;
 	unsigned int		pci_int[8];
 };
 
-- 
1.7.1
