From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/10] kconfig: move the "Executable file formats" menu to fs/Kconfig.binfmt
Date: Tue, 31 Jul 2018 13:39:34 +0200
Message-ID: <20180731113935.6105-10-hch@lst.de>
References: <20180731113935.6105-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

No need to have this in the top-level Kconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 Kconfig           | 2 --
 fs/Kconfig.binfmt | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index a5997d6c2029..48a80beab685 100644
--- a/Kconfig
+++ b/Kconfig
@@ -13,9 +13,7 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-menu "Executable file formats"
 source "fs/Kconfig.binfmt"
-endmenu
 
 source "mm/Kconfig"
 
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 56df483de619..b795f8da81f3 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -1,3 +1,6 @@
+
+menu "Executable file formats"
+
 config BINFMT_ELF
 	bool "Kernel support for ELF binaries"
 	depends on MMU
@@ -187,3 +190,5 @@ config COREDUMP
 	  This option enables support for performing core dumps. You almost
 	  certainly want to say Y here. Not necessary on systems that never
 	  need debugging or only ever run flawless code.
+
+endmenu
-- 
2.18.0
