From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 7/8] tile: enable ARCH_DMA_ADDR_T_64BIT
Date: Fri,  3 Sep 2010 09:49:15 +0900
Message-ID: <1283474956-14710-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, cmetcalf@tilera.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: cmetcalf@tilera.com
---
 arch/tile/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 1eb308c..aeca73f 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -58,6 +58,9 @@ config ARCH_SUPPORTS_OPTIMIZED_INLINING
 config ARCH_PHYS_ADDR_T_64BIT
 	def_bool y
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool y
+
 config LOCKDEP_SUPPORT
 	def_bool y
 
-- 
1.7.1
