From: <gerg@snapgear.com>
Subject: [PATCH v3 04/11] m68k: switch to using the asm-generic auxvec.h
Date: Tue, 30 Oct 2012 16:24:30 +1000
Message-ID: <1351578277-31882-5-git-send-email-gerg@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:52239 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab2J3G0f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Oct 2012 02:26:35 -0400
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local auxvec.h, switch the using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/uapi/asm/Kbuild   |    3 ++-
 arch/m68k/include/uapi/asm/auxvec.h |    4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/auxvec.h

diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 972bce1..8883a45 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,8 +1,9 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += auxvec.h
+
 header-y += a.out.h
-header-y += auxvec.h
 header-y += byteorder.h
 header-y += cachectl.h
 header-y += fcntl.h
diff --git a/arch/m68k/include/uapi/asm/auxvec.h b/arch/m68k/include/uapi/asm/auxvec.h
deleted file mode 100644
index 844d6d5..0000000
--- a/arch/m68k/include/uapi/asm/auxvec.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASMm68k_AUXVEC_H
-#define __ASMm68k_AUXVEC_H
-
-#endif
-- 
1.7.0.4
