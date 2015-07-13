From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] fs: dax: do not build on ARC or SH
Date: Mon, 13 Jul 2015 11:52:47 +0200
Message-ID: <1436781167-14446-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:42850 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbGMJwz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 05:52:55 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Arnd Bergmann <arnd@arndb.de>

The DAX implementation relies on the architecture to provide a working
copy_user_page() function, as reported by Michael Ellerman's kisskb
build bot:

fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2

We already have a list of architectures that are known to be incompatible,
but the list is missing ARC and SH at the moment. Further, blackfin and
c6x also lack support for this function, but are already excluded because
they do not support MMU-based kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
[Geert: s/SH/SUPERH/, as reported by Paul Bolle <pebolle@tiscali.nl>]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 011f43365d7b1e53..53326a50a3ce3830 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -37,7 +37,7 @@ source "fs/f2fs/Kconfig"
 config FS_DAX
 	bool "Direct Access (DAX) support"
 	depends on MMU
-	depends on !(ARM || MIPS || SPARC)
+	depends on !(ARC || ARM || MIPS || SPARC || SUPERH)
 	help
 	  Direct Access (DAX) can be used on memory-backed block devices.
 	  If the block device supports DAX and the filesystem supports DAX,
-- 
1.9.1
