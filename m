Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:49573 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2J2F50 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 01:57:26 -0400
From: <gerg@snapgear.com>
Subject: [PATCH v2 07/11] m68k: switch to using the asm-generic spinlock.h
Date: Mon, 29 Oct 2012 15:49:30 +1000
Message-ID: <1351489774-14263-8-git-send-email-gerg@snapgear.com>
In-Reply-To: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
References: <1351489774-14263-1-git-send-email-gerg@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
Message-ID: <20121029054930.rZunNeUJHV1R8QyQhwSjY6JJI0McBEtDvp-QAbXPKos@z>

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local spinlock.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild     |    1 +
 arch/m68k/include/asm/spinlock.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/spinlock.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 86d38c0..64e549c 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -28,6 +28,7 @@ generic-y += sembuf.h
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

