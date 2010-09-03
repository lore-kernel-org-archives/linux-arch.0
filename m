From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 4/8] mips: enable ARCH_DMA_ADDR_T_64BIT with (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
Date: Fri,  3 Sep 2010 09:49:12 +0900
Message-ID: <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ad59dd..3e9db47 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -830,6 +830,9 @@ config GPIO_TXX9
 config CFE
 	bool
 
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
+
 config DMA_COHERENT
 	bool
 
-- 
1.7.1
