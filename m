From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] unaligned access, fix some includes
Date: Wed, 09 Apr 2008 12:46:20 -0700
Message-ID: <1207770380.16220.19.camel@brick>
References: <1207765322.16220.8.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1207765322.16220.8.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Missed a few includes when moving some files around, this makes it
actually compile.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Applies on top of the unaligned access revamp, missed when moving files
around.

 include/linux/unaligned/generic_be.h        |    2 +-
 include/linux/unaligned/generic_le.h        |    2 +-
 include/linux/unaligned/no_builtin_memcpy.h |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/unaligned/generic_be.h b/include/linux/unaligned/generic_be.h
index ce42487..dd7e323 100644
--- a/include/linux/unaligned/generic_be.h
+++ b/include/linux/unaligned/generic_be.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_UNALIGNED_GENERIC_BE_H_
 #define _LINUX_UNALIGNED_GENERIC_BE_H_
 
-#include <linux/unaligned/generic.h>
+#include <linux/unaligned/cpu_endian.h>
 #include <linux/unaligned/little_endian.h>
 
 #define get_unaligned	__get_unaligned_cpu
diff --git a/include/linux/unaligned/generic_le.h b/include/linux/unaligned/generic_le.h
index b57c818..7b7de52 100644
--- a/include/linux/unaligned/generic_le.h
+++ b/include/linux/unaligned/generic_le.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_UNALIGNED_GENERIC_LE_H_
 #define _LINUX_UNALIGNED_GENERIC_LE_H_
 
-#include <linux/unaligned/generic.h>
+#include <linux/unaligned/cpu_endian.h>
 #include <linux/unaligned/big_endian.h>
 
 #define get_unaligned	__get_unaligned_cpu
diff --git a/include/linux/unaligned/no_builtin_memcpy.h b/include/linux/unaligned/no_builtin_memcpy.h
index 17a6e21..c117e78 100644
--- a/include/linux/unaligned/no_builtin_memcpy.h
+++ b/include/linux/unaligned/no_builtin_memcpy.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
 #define _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
 
+#include <linux/kernel.h>
 #include <asm/byteorder.h>
 #include <asm/string.h>
 
-- 
1.5.5.144.g3e42
