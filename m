From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] int-ll64.h: define u{8,16,32,64} and s{8,16,32,64} based on uapi header
Date: Tue, 15 May 2018 11:22:03 +0900
Message-ID: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

<uapi/asm-generic/int-ll64.h> has the same typedefs except that it
prefixes them with double-underscore for user space.  Use them for
the kernel space typedefs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/int-ll64.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/int-ll64.h b/include/asm-generic/int-ll64.h
index ffb68d6..a248545 100644
--- a/include/asm-generic/int-ll64.h
+++ b/include/asm-generic/int-ll64.h
@@ -13,17 +13,14 @@
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
+typedef __s8  s8;
+typedef __u8  u8;
+typedef __s16 s16;
+typedef __u16 u16;
+typedef __s32 s32;
+typedef __u32 u32;
+typedef __s64 s64;
+typedef __u64 u64;
 
 #define S8_C(x)  x
 #define U8_C(x)  x ## U
-- 
2.7.4
