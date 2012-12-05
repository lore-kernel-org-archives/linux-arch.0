From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 02/44] asm-generic/unistd.h: handle symbol prefixes in cond_syscall
Date: Wed, 5 Dec 2012 16:08:20 +0000
Message-ID: <1354723742-6195-3-git-send-email-james.hogan@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, James Hogan <james.hogan@imgtec.com>
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
index a36991a..abc925d 100644
--- a/include/asm-generic/unistd.h
+++ b/include/asm-generic/unistd.h
@@ -20,5 +20,12 @@
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
