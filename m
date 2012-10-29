Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:49557 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab2J2F5R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 01:57:17 -0400
From: <gerg@snapgear.com>
Subject: [PATCH v2 01/11] m68k: switch to using the asm-generic auxvec.h
Date: Mon, 29 Oct 2012 15:49:24 +1000
Message-ID: <1351489774-14263-2-git-send-email-gerg@snapgear.com>
In-Reply-To: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121029054924.DKPX8IsTKu8HcTFOjUQcgUlR48PIJ_kQ8N2gL5CmqNE@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local auxvec.h, switch the using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild        |    1 +
 arch/m68k/include/uapi/asm/Kbuild   |    1 -
 arch/m68k/include/uapi/asm/auxvec.h |    4 ----
 3 files changed, 1 insertions(+), 5 deletions(-)
 delete mode 100644 arch/m68k/include/uapi/asm/auxvec.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 88fa3ac..009446e 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,4 +1,5 @@
 
+generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += cputime.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 972bce1..588c3cc 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -2,7 +2,6 @@
 include include/uapi/asm-generic/Kbuild.asm
 
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

