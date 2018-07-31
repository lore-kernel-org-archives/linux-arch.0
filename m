From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/10] kconfig: add a Memory Management options" menu
Date: Tue, 31 Jul 2018 13:39:35 +0200
Message-ID: <20180731113935.6105-11-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This moves all the options under a proper menu.

Based on a patch from Randy Dunlap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 mm/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index ce95491abd6a..9ae1b6a8e30f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1,3 +1,6 @@
+
+menu "Memory Management options"
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
@@ -762,3 +765,5 @@ config GUP_BENCHMARK
 
 config ARCH_HAS_PTE_SPECIAL
 	bool
+
+endmenu
-- 
2.18.0
