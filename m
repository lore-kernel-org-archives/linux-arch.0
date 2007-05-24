Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:41121 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXEXUOn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 May 2007 16:14:43 -0400
Date: Thu, 24 May 2007 22:15:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH/RFC 5/5] sparc64: use INITRAMFS in vmlinux.lds.h
Message-ID: <20070524201542.GG1109@uranus.ravnborg.org>
References: <20070524200440.GA1109@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070524200440.GA1109@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc64/kernel/vmlinux.lds.S |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index 8559d07..2d6fb93 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -117,14 +117,7 @@ SECTIONS
 	}
 	__sun4v_2insn_patch_end = .;
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(PAGE_SIZE);
-	__initramfs_start = .;
-	.init.ramfs : {
-		*(.init.ramfs)
-	}
-	__initramfs_end = .;
-#endif
+	INITRAMFS(PAGE_SIZE)
 
 	. = ALIGN(PAGE_SIZE);
 	__per_cpu_start = .;
-- 
1.5.1.rc3.20.gaa453

