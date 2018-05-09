From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] sh: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:53:22 +0900
Message-ID: <1525852402-29269-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for SuperH-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/asm/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/vmlinux.lds.h b/arch/sh/include/asm/vmlinux.lds.h
index f312813..9929556 100644
--- a/arch/sh/include/asm/vmlinux.lds.h
+++ b/arch/sh/include/asm/vmlinux.lds.h
@@ -7,9 +7,9 @@
 #ifdef CONFIG_DWARF_UNWINDER
 #define DWARF_EH_FRAME							\
 	.eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {			\
-		  VMLINUX_SYMBOL(__start_eh_frame) = .;			\
+		  __start_eh_frame = .;					\
 		  *(.eh_frame)						\
-		  VMLINUX_SYMBOL(__stop_eh_frame) = .;			\
+		  __stop_eh_frame = .;					\
 	}
 #else
 #define DWARF_EH_FRAME
-- 
2.7.4
