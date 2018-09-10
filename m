Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33710 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJJoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:38 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 2/8] move user_termio_to_kernel_termios/kernel_termios_to_user_termio
Date: Mon, 10 Sep 2018 05:52:21 +0100
Message-ID: <20180910045227.9895-2-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045221.IvvzNTAWsCXlHxwp2VNaWDk1kGA5uPiz_ZDPIBDbD-E@z>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   | 104 ++++++++++++++++++++-----------------
 arch/ia64/include/asm/termios.h    |  31 -----------
 arch/mips/include/asm/termios.h    |  57 --------------------
 arch/parisc/include/asm/termios.h  |  31 -----------
 arch/sparc/include/asm/termios.h   |  52 +++++++------------
 include/asm-generic/termios-base.h |  57 --------------------
 include/asm-generic/termios.h      |  53 -------------------
 include/linux/termios_internal.h   |  41 +++++++++++++++
 8 files changed, 114 insertions(+), 312 deletions(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index 1cd44956ae7b..63e1ffc8f719 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -2,6 +2,7 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
+#include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
 /*	eof=^D		eol=\0		eol2=\0		erase=del
@@ -16,60 +17,65 @@
  * Translate a "termio" structure into a "termios". Ugh.
  */
 
-#define user_termio_to_kernel_termios(a_termios, u_termio)			\
-({										\
-	struct ktermios *k_termios = (a_termios);				\
-	struct termio k_termio;							\
-	int canon, ret;								\
-										\
-	ret = copy_from_user(&k_termio, u_termio, sizeof(k_termio));		\
-	if (!ret) {								\
-		/* Overwrite only the low bits.  */				\
-		*(unsigned short *)&k_termios->c_iflag = k_termio.c_iflag;	\
-		*(unsigned short *)&k_termios->c_oflag = k_termio.c_oflag;	\
-		*(unsigned short *)&k_termios->c_cflag = k_termio.c_cflag;	\
-		*(unsigned short *)&k_termios->c_lflag = k_termio.c_lflag;	\
-		canon = k_termio.c_lflag & ICANON;				\
-										\
-		k_termios->c_cc[VINTR]  = k_termio.c_cc[_VINTR];		\
-		k_termios->c_cc[VQUIT]  = k_termio.c_cc[_VQUIT];		\
-		k_termios->c_cc[VERASE] = k_termio.c_cc[_VERASE];		\
-		k_termios->c_cc[VKILL]  = k_termio.c_cc[_VKILL];		\
-		k_termios->c_cc[VEOL2]  = k_termio.c_cc[_VEOL2];		\
-		k_termios->c_cc[VSWTC]  = k_termio.c_cc[_VSWTC];		\
-		k_termios->c_cc[canon ? VEOF : VMIN]  = k_termio.c_cc[_VEOF];	\
-		k_termios->c_cc[canon ? VEOL : VTIME] = k_termio.c_cc[_VEOL];	\
-	}									\
-	ret;									\
-})
+static inline int user_termio_to_kernel_termios(struct ktermios *termios,
+						struct termio __user *termio)
+{
+	struct termio v;
+	bool canon;
+
+	if (copy_from_user(&v, termio, sizeof(struct termio)))
+		return -EFAULT;
+
+	termios->c_iflag = (0xffff0000 & termios->c_iflag) | v.c_iflag;
+	termios->c_oflag = (0xffff0000 & termios->c_oflag) | v.c_oflag;
+	termios->c_cflag = (0xffff0000 & termios->c_cflag) | v.c_cflag;
+	termios->c_lflag = (0xffff0000 & termios->c_lflag) | v.c_lflag;
+	termios->c_line = (0xffff0000 & termios->c_lflag) | v.c_line;
+
+	canon = v.c_lflag & ICANON;
+	termios->c_cc[VINTR]  = v.c_cc[_VINTR];
+	termios->c_cc[VQUIT]  = v.c_cc[_VQUIT];
+	termios->c_cc[VERASE] = v.c_cc[_VERASE];
+	termios->c_cc[VKILL]  = v.c_cc[_VKILL];
+	termios->c_cc[VEOL2]  = v.c_cc[_VEOL2];
+	termios->c_cc[VSWTC]  = v.c_cc[_VSWTC];
+	termios->c_cc[canon ? VEOF : VMIN]  = v.c_cc[_VEOF];
+	termios->c_cc[canon ? VEOL : VTIME] = v.c_cc[_VEOL];
+
+	return 0;
+}
+#define user_termio_to_kernel_termios user_termio_to_kernel_termios
 
 /*
  * Translate a "termios" structure into a "termio". Ugh.
  *
  * Note the "fun" _VMIN overloading.
  */
-#define kernel_termios_to_user_termio(u_termio, a_termios)		\
-({									\
-	struct ktermios *k_termios = (a_termios);			\
-	struct termio k_termio;						\
-	int canon;							\
-									\
-	k_termio.c_iflag = k_termios->c_iflag;				\
-	k_termio.c_oflag = k_termios->c_oflag;				\
-	k_termio.c_cflag = k_termios->c_cflag;				\
-	canon = (k_termio.c_lflag = k_termios->c_lflag) & ICANON;	\
-									\
-	k_termio.c_line = k_termios->c_line;				\
-	k_termio.c_cc[_VINTR]  = k_termios->c_cc[VINTR];		\
-	k_termio.c_cc[_VQUIT]  = k_termios->c_cc[VQUIT];		\
-	k_termio.c_cc[_VERASE] = k_termios->c_cc[VERASE];		\
-	k_termio.c_cc[_VKILL]  = k_termios->c_cc[VKILL];		\
-	k_termio.c_cc[_VEOF]   = k_termios->c_cc[canon ? VEOF : VMIN];	\
-	k_termio.c_cc[_VEOL]   = k_termios->c_cc[canon ? VEOL : VTIME];	\
-	k_termio.c_cc[_VEOL2]  = k_termios->c_cc[VEOL2];		\
-	k_termio.c_cc[_VSWTC]  = k_termios->c_cc[VSWTC];		\
-									\
-	copy_to_user(u_termio, &k_termio, sizeof(k_termio));		\
-})
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	bool canon;
+
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
+
+	canon = v.c_lflag & ICANON;
+	v.c_cc[_VINTR]  = termios->c_cc[VINTR];
+	v.c_cc[_VQUIT]  = termios->c_cc[VQUIT];
+	v.c_cc[_VERASE] = termios->c_cc[VERASE];
+	v.c_cc[_VKILL]  = termios->c_cc[VKILL];
+	v.c_cc[_VEOF]   = termios->c_cc[canon ? VEOF : VMIN];
+	v.c_cc[_VEOL]   = termios->c_cc[canon ? VEOL : VTIME];
+	v.c_cc[_VEOL2]  = termios->c_cc[VEOL2];
+	v.c_cc[_VSWTC]  = termios->c_cc[VSWTC];
+
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
+#define kernel_termios_to_user_termio kernel_termios_to_user_termio
 
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 1bd5ff9745e9..66ca23c03f3c 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -19,35 +19,4 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) {	\
-	unsigned short __tmp;				\
-	get_user(__tmp,&(termio)->x);			\
-	*(unsigned short *) &(termios)->x = __tmp;	\
-}
-
-#define user_termio_to_kernel_termios(termios, termio)		\
-({								\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag);		\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag);		\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag);		\
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag);		\
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC);	\
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios)		\
-({								\
-	put_user((termios)->c_iflag, &(termio)->c_iflag);	\
-	put_user((termios)->c_oflag, &(termio)->c_oflag);	\
-	put_user((termios)->c_cflag, &(termio)->c_cflag);	\
-	put_user((termios)->c_lflag, &(termio)->c_lflag);	\
-	put_user((termios)->c_line,  &(termio)->c_line);	\
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC);	\
-})
-
 #endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index 3bd98a70e1d1..dbb62330b7a4 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -21,61 +21,4 @@
  */
 #define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
 
-#include <linux/string.h>
-
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-static inline int user_termio_to_kernel_termios(struct ktermios *termios,
-	struct termio __user *termio)
-{
-	unsigned short iflag, oflag, cflag, lflag;
-	unsigned int err;
-
-	if (!access_ok(VERIFY_READ, termio, sizeof(struct termio)))
-		return -EFAULT;
-
-	err = __get_user(iflag, &termio->c_iflag);
-	termios->c_iflag = (termios->c_iflag & 0xffff0000) | iflag;
-	err |=__get_user(oflag, &termio->c_oflag);
-	termios->c_oflag = (termios->c_oflag & 0xffff0000) | oflag;
-	err |=__get_user(cflag, &termio->c_cflag);
-	termios->c_cflag = (termios->c_cflag & 0xffff0000) | cflag;
-	err |=__get_user(lflag, &termio->c_lflag);
-	termios->c_lflag = (termios->c_lflag & 0xffff0000) | lflag;
-	err |=__get_user(termios->c_line, &termio->c_line);
-	if (err)
-		return -EFAULT;
-
-	if (__copy_from_user(termios->c_cc, termio->c_cc, NCC))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-static inline int kernel_termios_to_user_termio(struct termio __user *termio,
-	struct ktermios *termios)
-{
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, termio, sizeof(struct termio)))
-		return -EFAULT;
-
-	err = __put_user(termios->c_iflag, &termio->c_iflag);
-	err |= __put_user(termios->c_oflag, &termio->c_oflag);
-	err |= __put_user(termios->c_cflag, &termio->c_cflag);
-	err |= __put_user(termios->c_lflag, &termio->c_lflag);
-	err |= __put_user(termios->c_line, &termio->c_line);
-	if (err)
-		return -EFAULT;
-
-	if (__copy_to_user(termio->c_cc, termios->c_cc, NCC))
-		return -EFAULT;
-
-	return 0;
-}
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index 679d31db8d77..2f5153be531f 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -13,35 +13,4 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
-	unsigned short __tmp; \
-	get_user(__tmp,&(termio)->x); \
-	*(unsigned short *) &(termios)->x = __tmp; \
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
 #endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 27a054a99a58..0652f870bb1a 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -26,44 +26,28 @@
 #define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
 
 /*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	unsigned short tmp; \
-	int err; \
-	err = get_user(tmp, &(termio)->c_iflag); \
-	(termios)->c_iflag = (0xffff0000 & ((termios)->c_iflag)) | tmp; \
-	err |= get_user(tmp, &(termio)->c_oflag); \
-	(termios)->c_oflag = (0xffff0000 & ((termios)->c_oflag)) | tmp; \
-	err |= get_user(tmp, &(termio)->c_cflag); \
-	(termios)->c_cflag = (0xffff0000 & ((termios)->c_cflag)) | tmp; \
-	err |= get_user(tmp, &(termio)->c_lflag); \
-	(termios)->c_lflag = (0xffff0000 & ((termios)->c_lflag)) | tmp; \
-	err |= copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-	err; \
-})
-
-/*
  * Translate a "termios" structure into a "termio". Ugh.
  *
  * Note the "fun" _VMIN overloading.
  */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	int err; \
-	err  = put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	err |= put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	err |= put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	err |= put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	err |= put_user((termios)->c_line,  &(termio)->c_line); \
-	err |= copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-	if (!((termios)->c_lflag & ICANON)) { \
-		err |= put_user((termios)->c_cc[VMIN], &(termio)->c_cc[_VMIN]); \
-		err |= put_user((termios)->c_cc[VTIME], &(termio)->c_cc[_VTIME]); \
-	} \
-	err; \
-})
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
+	memcpy(v.c_cc, termios->c_cc, NCC);
+	if (!(v.c_lflag & ICANON)) {
+		v.c_cc[_VMIN] = termios->c_cc[VMIN];
+		v.c_cc[_VTIME] = termios->c_cc[VTIME];
+	}
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
+#define kernel_termios_to_user_termio kernel_termios_to_user_termio
 
 static inline int user_termios_to_kernel_termios(struct ktermios *k,
 						 struct termios2 __user *u)
diff --git a/include/asm-generic/termios-base.h b/include/asm-generic/termios-base.h
index f5f65eb75340..63d948ab6746 100644
--- a/include/asm-generic/termios-base.h
+++ b/include/asm-generic/termios-base.h
@@ -7,61 +7,4 @@
 
 #include <linux/uaccess.h>
 
-#ifndef __ARCH_TERMIO_GETPUT
-
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-static inline int user_termio_to_kernel_termios(struct ktermios *termios,
-						struct termio __user *termio)
-{
-	unsigned short tmp;
-
-	if (get_user(tmp, &termio->c_iflag) < 0)
-		goto fault;
-	termios->c_iflag = (0xffff0000 & termios->c_iflag) | tmp;
-
-	if (get_user(tmp, &termio->c_oflag) < 0)
-		goto fault;
-	termios->c_oflag = (0xffff0000 & termios->c_oflag) | tmp;
-
-	if (get_user(tmp, &termio->c_cflag) < 0)
-		goto fault;
-	termios->c_cflag = (0xffff0000 & termios->c_cflag) | tmp;
-
-	if (get_user(tmp, &termio->c_lflag) < 0)
-		goto fault;
-	termios->c_lflag = (0xffff0000 & termios->c_lflag) | tmp;
-
-	if (get_user(termios->c_line, &termio->c_line) < 0)
-		goto fault;
-
-	if (copy_from_user(termios->c_cc, termio->c_cc, NCC) != 0)
-		goto fault;
-
-	return 0;
-
- fault:
-	return -EFAULT;
-}
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-static inline int kernel_termios_to_user_termio(struct termio __user *termio,
-						struct ktermios *termios)
-{
-	if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
-	    put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
-	    put_user(termios->c_cflag, &termio->c_cflag) < 0 ||
-	    put_user(termios->c_lflag, &termio->c_lflag) < 0 ||
-	    put_user(termios->c_line,  &termio->c_line) < 0 ||
-	    copy_to_user(termio->c_cc, termios->c_cc, NCC) != 0)
-		return -EFAULT;
-
-	return 0;
-}
-
-#endif	/* __ARCH_TERMIO_GETPUT */
-
 #endif /* _ASM_GENERIC_TERMIOS_BASE_H */
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index aa897f807ae6..3ffed3886ff2 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -14,57 +14,4 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-static inline int user_termio_to_kernel_termios(struct ktermios *termios,
-						const struct termio __user *termio)
-{
-	unsigned short tmp;
-
-	if (get_user(tmp, &termio->c_iflag) < 0)
-		goto fault;
-	termios->c_iflag = (0xffff0000 & termios->c_iflag) | tmp;
-
-	if (get_user(tmp, &termio->c_oflag) < 0)
-		goto fault;
-	termios->c_oflag = (0xffff0000 & termios->c_oflag) | tmp;
-
-	if (get_user(tmp, &termio->c_cflag) < 0)
-		goto fault;
-	termios->c_cflag = (0xffff0000 & termios->c_cflag) | tmp;
-
-	if (get_user(tmp, &termio->c_lflag) < 0)
-		goto fault;
-	termios->c_lflag = (0xffff0000 & termios->c_lflag) | tmp;
-
-	if (get_user(termios->c_line, &termio->c_line) < 0)
-		goto fault;
-
-	if (copy_from_user(termios->c_cc, termio->c_cc, NCC) != 0)
-		goto fault;
-
-	return 0;
-
- fault:
-	return -EFAULT;
-}
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-static inline int kernel_termios_to_user_termio(struct termio __user *termio,
-						struct ktermios *termios)
-{
-	if (put_user(termios->c_iflag, &termio->c_iflag) < 0 ||
-	    put_user(termios->c_oflag, &termio->c_oflag) < 0 ||
-	    put_user(termios->c_cflag, &termio->c_cflag) < 0 ||
-	    put_user(termios->c_lflag, &termio->c_lflag) < 0 ||
-	    put_user(termios->c_line,  &termio->c_line) < 0 ||
-	    copy_to_user(termio->c_cc, termios->c_cc, NCC) != 0)
-		return -EFAULT;
-
-	return 0;
-}
-
 #endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 3beb0595fd54..894f565ffc5f 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -5,6 +5,47 @@
 #include <linux/uaccess.h>
 #include <asm/termios.h>
 
+#ifndef user_termio_to_kernel_termios
+/*
+ * Translate a "termio" structure into a "termios". Ugh.
+ */
+static inline int user_termio_to_kernel_termios(struct ktermios *termios,
+						struct termio __user *termio)
+{
+	struct termio v;
+
+	if (copy_from_user(&v, termio, sizeof(struct termio)))
+		return -EFAULT;
+
+	termios->c_iflag = (0xffff0000 & termios->c_iflag) | v.c_iflag;
+	termios->c_oflag = (0xffff0000 & termios->c_oflag) | v.c_oflag;
+	termios->c_cflag = (0xffff0000 & termios->c_cflag) | v.c_cflag;
+	termios->c_lflag = (0xffff0000 & termios->c_lflag) | v.c_lflag;
+	termios->c_line = (0xffff0000 & termios->c_lflag) | v.c_line;
+	memcpy(termios->c_cc, v.c_cc, NCC);
+	return 0;
+}
+#endif
+
+#ifndef kernel_termios_to_user_termio
+/*
+ * Translate a "termios" structure into a "termio". Ugh.
+ */
+static inline int kernel_termios_to_user_termio(struct termio __user *termio,
+						struct ktermios *termios)
+{
+	struct termio v;
+	memset(&v, 0, sizeof(struct termio));
+	v.c_iflag = termios->c_iflag;
+	v.c_oflag = termios->c_oflag;
+	v.c_cflag = termios->c_cflag;
+	v.c_lflag = termios->c_lflag;
+	v.c_line = termios->c_line;
+	memcpy(v.c_cc, termios->c_cc, NCC);
+	return copy_to_user(termio, &v, sizeof(struct termio));
+}
+#endif
+
 #ifdef TCGETS2
 #ifndef user_termios_to_kernel_termios
 static inline int user_termios_to_kernel_termios(struct ktermios *k,
-- 
2.11.0
