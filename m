Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr710132.outbound.protection.outlook.com ([40.107.71.132]:8262
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729729AbeHIBSr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Aug 2018 21:18:47 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 2/4] um: Add generated/ to MODE_INCLUDE
Date: Wed,  8 Aug 2018 15:52:23 -0700
Message-Id: <20180808225225.24450-3-paul.burton@mips.com>
In-Reply-To: <20180808225225.24450-1-paul.burton@mips.com>
References: <20180808225225.24450-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mips@linux-mips.org
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linux-arch@vger.kernel.org, Paul Burton <paul.burton@mips.com>

From: James Hogan <jhogan@kernel.org>

Add the um specific generated includes directory to MODE_INCLUDE so that
asm/compiler.h can be used for overriding linux/compiler*.h which is
included automatically, with um using a generated asm-generic wrapper at
arch/um/include/generated/asm/compiler.h.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
I've been unable to reproduce the error the kbuild test robot reported
for v4 [1], so I'm hoping it may disappear with the rebased series or at
least give me more information if not...

[1] https://www.linux-mips.org/archives/linux-mips/2018-05/msg00094.html

Changes in v5: None
Changes in v4:
- New patch in v4.

 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index e54dda8a0363..543d12d230ab 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -30,6 +30,7 @@ core-y			+= $(ARCH_DIR)/kernel/		\
 			   $(ARCH_DIR)/os-$(OS)/
 
 MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/shared/skas
+MODE_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)/include/generated
 
 HEADER_ARCH 	:= $(SUBARCH)
 
-- 
2.18.0
