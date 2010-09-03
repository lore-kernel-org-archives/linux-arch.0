Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:59044 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756358Ab0ICAvq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 20:51:46 -0400
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 5/8] powerpc: enable ARCH_DMA_ADDR_T_64BIT with ARCH_PHYS_ADDR_T_64BIT
Date: Fri,  3 Sep 2010 09:49:13 +0900
Message-ID: <1283474956-14710-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@lists.ozlabs.org
Message-ID: <20100903004913.-QnltZFa1RS_LWCNmsVMJQgW5EpM5xoIBj_qQc1Euyk@z>

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 631e5a0..b0e58f5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -22,6 +22,9 @@ config WORD_SIZE
 config ARCH_PHYS_ADDR_T_64BIT
        def_bool PPC64 || PHYS_64BIT
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool ARCH_PHYS_ADDR_T_64BIT
+
 config MMU
 	bool
 	default y
-- 
1.7.1

