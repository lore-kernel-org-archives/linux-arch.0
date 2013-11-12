From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 02/17] cris: Use Kbuild logic to include <asm-generic/sections.h>
Date: Tue, 12 Nov 2013 20:42:12 +0100
Message-ID: <1384285347-13506-3-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
---
 arch/cris/include/asm/Kbuild     |    1 +
 arch/cris/include/asm/sections.h |    7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)
 delete mode 100644 arch/cris/include/asm/sections.h

diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index b06caf649a95..44e7d0dbcf32 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += exec.h
 generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += module.h
+generic-y += sections.h
 generic-y += trace_clock.h
 generic-y += vga.h
 generic-y += xor.h
diff --git a/arch/cris/include/asm/sections.h b/arch/cris/include/asm/sections.h
deleted file mode 100644
index 2c998ce8967b..000000000000
--- a/arch/cris/include/asm/sections.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _CRIS_SECTIONS_H
-#define _CRIS_SECTIONS_H
-
-/* nothing to see, move along */
-#include <asm-generic/sections.h>
-
-#endif
-- 
1.7.9.5
