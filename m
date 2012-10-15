From: <gerg@snapgear.com>
Subject: [PATCH 01/11] m68k: switch to using the asm-generic auxvec.h
Date: Mon, 15 Oct 2012 16:49:09 +1000
Message-ID: <1350283759-31158-2-git-send-email-gerg@snapgear.com>
References: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1350283759-31158-1-git-send-email-gerg@snapgear.com>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Greg Ungerer <gerg@uclinux.org>
List-Id: linux-arch.vger.kernel.org

From: Greg Ungerer <gerg@uclinux.org>

We don't need a local auxvec.h, switch the using the asm-generic version.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/m68k/include/asm/Kbuild   |    1 +
 arch/m68k/include/asm/auxvec.h |    4 ----
 2 files changed, 1 insertions(+), 4 deletions(-)
 delete mode 100644 arch/m68k/include/asm/auxvec.h

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index ecb5408..7de78bb 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,6 +1,7 @@
 include include/asm-generic/Kbuild.asm
 header-y += cachectl.h
 
+generic-y += auxvec.h
 generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += cputime.h
diff --git a/arch/m68k/include/asm/auxvec.h b/arch/m68k/include/asm/auxvec.h
deleted file mode 100644
index 844d6d5..0000000
--- a/arch/m68k/include/asm/auxvec.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __ASMm68k_AUXVEC_H
-#define __ASMm68k_AUXVEC_H
-
-#endif
-- 
1.7.0.4
