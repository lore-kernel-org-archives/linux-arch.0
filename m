Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730101.outbound.protection.outlook.com ([40.107.73.101]:45037
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732330AbeHIULj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Aug 2018 16:11:39 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH v6 2/4] um: Add generated/ to MODE_INCLUDE
Date: Thu,  9 Aug 2018 10:44:42 -0700
Message-Id: <20180809174444.31705-3-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-1-paul.burton@mips.com>
References: <20180809174444.31705-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-arch@vger.kernel.org, linux-um@lists.infradead.org, Paul Burton <paul.burton@mips.com>

From: James Hogan <jhogan@kernel.org>

Add the um specific generated includes directory to MODE_INCLUDE so that
asm/compiler.h can be used for overriding linux/compiler*.h which is
included automatically, with um using a generated asm-generic wrapper at
arch/um/include/generated/asm/compiler.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-um@lists.infradead.org

Signed-off-by: Paul Burton <paul.burton@mips.com>
---

Changes in v6:
- s/srctree/objtree/ to fix build issues when building out of tree.

Changes in v5: None
Changes in v4:
- New patch in v4.

 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..fec1252160db 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -30,6 +30,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/os-$(OS)/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
+MODE_INCLUDE	+= -I$(objtree)/$(ARCH_DIR)/include/generated
 
 HEADER_ARCH 	:= $(SUBARCH)
 
-- 
2.18.0
