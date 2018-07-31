Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeGaNTs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jul 2018 09:19:48 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/10] kconfig: remove duplicate SWAP symbol defintions
Date: Tue, 31 Jul 2018 13:39:29 +0200
Message-ID: <20180731113935.6105-5-hch@lst.de>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180731113929.rggEyk0AQJAm0vLWHWzGaYALqRMGDnAz1HJf2l2FSRQ@z>

microblaze and nios2 define their own always n SWAP symbols.  Remove those
and let the generic defintion do the right thing by adding a new symbol
to disable swap entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig | 4 +---
 arch/nios2/Kconfig      | 4 +---
 init/Kconfig            | 9 ++++++++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index d14782100088..cc139d1b1284 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,5 +1,6 @@
 config MICROBLAZE
 	def_bool y
+	select ARCH_NO_SWAP
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
@@ -52,9 +53,6 @@ config CPU_LITTLE_ENDIAN
 
 endchoice
 
-config SWAP
-	def_bool n
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..3f9d4ef8b20f 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config NIOS2
 	def_bool y
+	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
@@ -38,9 +39,6 @@ config HAS_DMA
 config FPU
 	def_bool n
 
-config SWAP
-	def_bool n
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..1e69f93b809e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -218,9 +218,16 @@ config DEFAULT_HOSTNAME
 	  but you may wish to use a different default here to make a minimal
 	  system more usable with less configuration.
 
+#
+# For some reason microblaze and nios2 hard code SWAP=n.  Hopefully we can
+# add proper SWAP support to them, in which case this can be remove.
+#
+config ARCH_NO_SWAP
+	bool
+
 config SWAP
 	bool "Support for paging of anonymous memory (swap)"
-	depends on MMU && BLOCK
+	depends on MMU && BLOCK && !ARCH_NO_SWAP
 	default y
 	help
 	  This option allows you to choose whether you want to have support
-- 
2.18.0
