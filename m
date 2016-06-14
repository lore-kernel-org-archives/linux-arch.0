From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/5] vmlinux.lds.h: replace config_enabled() with IS_ENABLED()
Date: Tue, 14 Jun 2016 14:58:58 +0900
Message-ID: <1465883938-25194-5-git-send-email-yamada.masahiro@socionext.com>
References: <1465883938-25194-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465883938-25194-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Michal Simek <michal.simek@xilinx.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.cz>, Nicolas Pitre <nicolas.pitre@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The use of config_enabled() against config options is ambiguous.

Now, IS_ENABLED() is implemented purely with macro expansion, so
let's replace config_enabled() with IS_ENABLED().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6a67ab9..faa4d2b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -164,7 +164,7 @@
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
 #define __OF_TABLE(cfg, name)	___OF_TABLE(cfg, name)
-#define OF_TABLE(cfg, name)	__OF_TABLE(config_enabled(cfg), name)
+#define OF_TABLE(cfg, name)	__OF_TABLE(IS_ENABLED(cfg), name)
 #define _OF_TABLE_0(name)
 #define _OF_TABLE_1(name)						\
 	. = ALIGN(8);							\
-- 
1.9.1
