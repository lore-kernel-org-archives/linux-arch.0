From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Thu, 24 Apr 2008 16:05:09 -0700
Message-ID: <1209078352-7593-3-git-send-email-hpa@zytor.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
 <1209078352-7593-2-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209078352-7593-2-git-send-email-hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>

This creates two generic files with common integer definitions; one
where 64 bits is "long" (most 64-bit architectures) and one where 64
bits is "long long" (all 32-bit architectures and x86-64.)

Signed-off-by: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
---
 include/asm-generic/Kbuild     |    2 +
 include/asm-generic/int-l64.h  |   51 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/int-ll64.h |   56 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-generic/int-l64.h
 create mode 100644 include/asm-generic/int-ll64.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index c18110e..4c9932a 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -7,5 +7,7 @@ header-y += poll.h
 header-y += signal.h
 header-y += statfs.h
 
+unifdef-y += int-l64.h
+unifdef-y += int-ll64.h
 unifdef-y += resource.h
 unifdef-y += siginfo.h
diff --git a/include/asm-generic/int-l64.h b/include/asm-generic/int-l64.h
new file mode 100644
index 0000000..629b5a4
--- /dev/null
+++ b/include/asm-generic/int-l64.h
@@ -0,0 +1,51 @@
+/*
+ * asm-generic/int-l64.h
+ *
+ * Integer declarations for architectures which use "long"
+ * for 64-bit types.
+ */
+
+#ifndef _ASM_GENERIC_INT_L64_H
+#define _ASM_GENERIC_INT_L64_H
+
+#ifndef __ASSEMBLY__
+/*
+ * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
+ * header files exported to user space
+ */
+
+typedef __signed__ char __s8;
+typedef unsigned char __u8;
+
+typedef __signed__ short __s16;
+typedef unsigned short __u16;
+
+typedef __signed__ int __s32;
+typedef unsigned int __u32;
+
+typedef __signed__ long __s64;
+typedef unsigned long __u64;
+
+#endif /* __ASSEMBLY__ */
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+typedef signed char s8;
+typedef unsigned char u8;
+
+typedef signed short s16;
+typedef unsigned short u16;
+
+typedef signed int s32;
+typedef unsigned int u32;
+
+typedef signed long s64;
+typedef unsigned long u64;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_GENERIC_INT_L64_H */
diff --git a/include/asm-generic/int-ll64.h b/include/asm-generic/int-ll64.h
new file mode 100644
index 0000000..1e5ffec
--- /dev/null
+++ b/include/asm-generic/int-ll64.h
@@ -0,0 +1,56 @@
+/*
+ * asm-generic/int-ll64.h
+ *
+ * Integer declarations for architectures which use "long long"
+ * for 64-bit types.
+ */
+
+#ifndef _ASM_GENERIC_INT_LL64_H
+#define _ASM_GENERIC_INT_LL64_H
+
+#ifndef __ASSEMBLY__
+/*
+ * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
+ * header files exported to user space
+ */
+
+typedef __signed__ char __s8;
+typedef unsigned char __u8;
+
+typedef __signed__ short __s16;
+typedef unsigned short __u16;
+
+typedef __signed__ int __s32;
+typedef unsigned int __u32;
+
+#ifdef __GNUC__
+__extension__ typedef __signed__ long long __s64;
+__extension__ typedef unsigned long long __u64;
+#elif defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
+typedef __signed__ long long __s64;
+typedef unsigned long long __u64;
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+typedef signed char s8;
+typedef unsigned char u8;
+
+typedef signed short s16;
+typedef unsigned short u16;
+
+typedef signed int s32;
+typedef unsigned int u32;
+
+typedef signed long long s64;
+typedef unsigned long long u64;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_GENERIC_INT_LL64_H */
-- 
1.5.4.1
