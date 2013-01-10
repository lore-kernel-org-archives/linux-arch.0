From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v3 02/44] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Date: Thu, 10 Jan 2013 15:30:30 +0000
Message-ID: <1357831872-29451-3-git-send-email-james.hogan@imgtec.com>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>
List-Id: linux-arch.vger.kernel.org

Some architectures have symbol prefixes and set CONFIG_SYMBOL_PREFIX,
but this wasn't taken into account by the generic cond_syscall. It's
easy enough to fix in a generic fashion, so add the symbol prefix to
symbol names in cond_syscall when CONFIG_SYMBOL_PREFIX is set.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mike Frysinger <vapier@gentoo.org>
---
 include/asm-generic/unistd.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
index 257c55e..4077b5d 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -17,5 +17,12 @@
  * but it doesn't work on all toolchains, so we just do it by hand
  */
 #ifndef cond_syscall
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
+#ifdef CONFIG_SYMBOL_PREFIX
+#define __SYMBOL_PREFIX CONFIG_SYMBOL_PREFIX
+#else
+#define __SYMBOL_PREFIX
+#endif
+#define cond_syscall(x) asm(".weak\t" __SYMBOL_PREFIX #x "\n\t" \
+			    ".set\t" __SYMBOL_PREFIX #x "," \
+			    __SYMBOL_PREFIX "sys_ni_syscall")
 #endif
-- 
1.7.7.6
