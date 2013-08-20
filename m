From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] Documentation/printk-formats.txt: No casts needed for u64/s64
Date: Tue, 20 Aug 2013 13:01:15 +0200
Message-ID: <1376996476-12027-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Now all 64-bit architectures have been converted to int-ll64.h in kernel
space, casting to (unsigned) long long is no longer needed when formatting
u64/s64.

For backwards compatibility, alpha, ia64, mips64, and powerpc64 still use
int-l64.h in userspace.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-doc@vger.kernel.org
---
This is the documentation part of more than two year old
"asm/types.h: All architectures use int-ll64.h in kernelspace"
(https://lkml.org/lkml/2011/8/13/104)

 Documentation/printk-formats.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index 3e8cb73..41aaed7 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -185,11 +185,11 @@ struct va_format:
 
 u64 SHOULD be printed with %llu/%llx, (unsigned long long):
 
-	printk("%llu", (unsigned long long)u64_var);
+	printk("%llu", u64_var);
 
 s64 SHOULD be printed with %lld/%llx, (long long):
 
-	printk("%lld", (long long)s64_var);
+	printk("%lld", s64_var);
 
 If <type> is dependent on a config option for its size (e.g., sector_t,
 blkcnt_t) or is architecture-dependent for its size (e.g., tcflag_t), use a
-- 
1.7.9.5
