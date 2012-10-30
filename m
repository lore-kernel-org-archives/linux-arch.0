From: <gerg@snapgear.com>
Subject: [PATCH v3 03/11] m68k: switch to using the asm-generic shmparam.h
Date: Tue, 30 Oct 2012 16:24:29 +1000
Message-ID: <1351578277-31882-4-git-send-email-gerg@snapgear.com>
References: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1351578277-31882-1-git-send-email-gerg@snapgear.com>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
List-Id: linux-arch.vger.kernel.org

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local shmparam.h, switch to using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild     |    1 +
 arch/m68k/include/asm/shmparam.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/m68k/include/asm/shmparam.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index a494c3e..6c88287 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -22,6 +22,7 @@ generic-y += percpu.h
 generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
+generic-y += shmparam.h
 generic-y += siginfo.h
 generic-y += spinlock.h
 generic-y += statfs.h
diff --git a/arch/m68k/include/asm/shmparam.h b/arch/m68k/include/asm/shmparam.h
deleted file mode 100644
index 558892a..0000000
--- a/arch/m68k/include/asm/shmparam.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _M68K_SHMPARAM_H
-#define _M68K_SHMPARAM_H
-
-#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
-
-#endif /* _M68K_SHMPARAM_H */
-- 
1.7.0.4
