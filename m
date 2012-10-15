Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dnvwsmailout1.mcafee.com ([161.69.31.173]:28942 "EHLO
	DNVWSMAILOUT1.mcafee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab2JOGqv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2012 02:46:51 -0400
From: <gerg@snapgear.com>
Subject: [PATCH 07/11] m68k: switch to using the asm-generic spinlock.h
Date: Mon, 15 Oct 2012 16:49:15 +1000
Message-ID: <1350283759-31158-8-git-send-email-gerg@snapgear.com>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121015064915.FizWHfPUSHq3McTxjKHvIXZGn-LfvaS-ocforckNiyY@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local spinlock.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild     |    1 +
 arch/m68k/include/asm/spinlock.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/spinlock.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 19f59dc..c770aec 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -30,6 +30,7 @@ generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
+generic-y += spinlock.h
 generic-y += statfs.h
 generic-y += topology.h
 generic-y += types.h
diff --git a/arch/m68k/include/asm/spinlock.h b/arch/m68k/include/asm/spinlock.h
deleted file mode 100644
index 20f46e2..0000000
--- a/arch/m68k/include/asm/spinlock.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __M68K_SPINLOCK_H
-#define __M68K_SPINLOCK_H
-
-#error "m68k doesn't do SMP yet"
-
-#endif
-- 
1.7.0.4

