From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 13/24] mips: Remove #include <uapi/asm/types.h> from <asm/types.h>
Date: Mon, 25 Nov 2013 09:55:23 +0100
Message-ID: <1385369734-24893-14-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Everything in arch/mips/include/uapi/asm/types.h is protected by
"#ifndef __KERNEL__", so it's unused for kernelspace.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/types.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/types.h b/arch/mips/include/asm/types.h
index a845aafedee4..4d5ce4c9c924 100644
--- a/arch/mips/include/asm/types.h
+++ b/arch/mips/include/asm/types.h
@@ -11,8 +11,7 @@
 #ifndef _ASM_TYPES_H
 #define _ASM_TYPES_H
 
-# include <asm-generic/int-ll64.h>
-#include <uapi/asm/types.h>
+#include <asm-generic/int-ll64.h>
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
-- 
1.7.9.5
