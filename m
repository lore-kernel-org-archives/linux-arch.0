Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33706 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIJJoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:38 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 1/8] start unifying termios convertors
Date: Mon, 10 Sep 2018 05:52:20 +0100
Message-ID: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910044937.GJ19965@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045220.8duTdLc4_e-loLAr9BIvjoIp3TTvk5zZKbrXHH6JBm0@z>

From: Al Viro <viro@zeniv.linux.org.uk>

* new header (linut/termios_internal.h), pulled by the sole user of those
suckers
* defaults for user_termios_to_kernel_termios{,_1} and
kernel_termios_to_user_termios{,_1} moved over there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios.h   |   6 --
 arch/ia64/include/asm/termios.h    |   5 --
 arch/mips/include/asm/termios.h    |  24 ------
 arch/parisc/include/asm/termios.h  |   5 --
 arch/s390/include/asm/termios.h    |   3 -
 arch/sparc/include/asm/termios.h   | 165 ++++++++++++++++++++-----------------
 drivers/tty/tty_ioctl.c            |   1 +
 include/asm-generic/termios-base.h |  11 ---
 include/asm-generic/termios.h      |  38 ---------
 include/linux/termios_internal.h   |  58 +++++++++++++
 10 files changed, 148 insertions(+), 168 deletions(-)
 create mode 100644 include/linux/termios_internal.h

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index 6a8c53dec57e..1cd44956ae7b 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -72,10 +72,4 @@
 	copy_to_user(u_termio, &k_termio, sizeof(k_termio));		\
 })
 
-#define user_termios_to_kernel_termios(k, u) \
-	copy_from_user(k, u, sizeof(struct termios))
-
-#define kernel_termios_to_user_termios(u, k) \
-	copy_to_user(u, k, sizeof(struct termios))
-
 #endif	/* _ALPHA_TERMIOS_H */
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 589c026444cc..1bd5ff9745e9 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -50,9 +50,4 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC);	\
 })
 
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
-
 #endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index ce2d72e34274..3bd98a70e1d1 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -78,28 +78,4 @@ static inline int kernel_termios_to_user_termio(struct termio __user *termio,
 	return 0;
 }
 
-static inline int user_termios_to_kernel_termios(struct ktermios __user *k,
-	struct termios2 *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios2)) ? -EFAULT : 0;
-}
-
-static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
-	struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios2)) ? -EFAULT : 0;
-}
-
-static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
-	struct termios __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios)) ? -EFAULT : 0;
-}
-
-static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
-	struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios)) ? -EFAULT : 0;
-}
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index cded9dc90c1b..679d31db8d77 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -44,9 +44,4 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
-
 #endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 46fa3020b41e..62759ac7a92b 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -18,9 +18,6 @@
 */
 #define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
 
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
-
 #include <asm-generic/termios-base.h>
 
 #endif	/* _S390_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 4a558efdfa93..27a054a99a58 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -3,6 +3,7 @@
 #define _SPARC_TERMIOS_H
 
 #include <uapi/asm/termios.h>
+#include <linux/uaccess.h>
 
 
 /*
@@ -64,84 +65,96 @@
 	err; \
 })
 
-#define user_termios_to_kernel_termios(k, u) \
-({ \
-	int err; \
-	err  = get_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= get_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= get_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= get_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= get_user((k)->c_line,  &(u)->c_line); \
-	err |= copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
-	if ((k)->c_lflag & ICANON) { \
-		err |= get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} else { \
-		err |= get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} \
-	err |= get_user((k)->c_ispeed,  &(u)->c_ispeed); \
-	err |= get_user((k)->c_ospeed,  &(u)->c_ospeed); \
-	err; \
-})
+static inline int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios2 __user *u)
+{
+	int err;
+	err  = get_user(k->c_iflag, &u->c_iflag);
+	err |= get_user(k->c_oflag, &u->c_oflag);
+	err |= get_user(k->c_cflag, &u->c_cflag);
+	err |= get_user(k->c_lflag, &u->c_lflag);
+	err |= get_user(k->c_line,  &u->c_line);
+	err |= copy_from_user(k->c_cc, u->c_cc, NCCS);
+	if (k->c_lflag & ICANON) {
+		err |= get_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= get_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	} else {
+		err |= get_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= get_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	}
+	err |= get_user(k->c_ispeed,  &u->c_ispeed);
+	err |= get_user(k->c_ospeed,  &u->c_ospeed);
+	return err;
+}
 
-#define kernel_termios_to_user_termios(u, k) \
-({ \
-	int err; \
-	err  = put_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= put_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= put_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= put_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= put_user((k)->c_line, &(u)->c_line); \
-	err |= copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
-	if (!((k)->c_lflag & ICANON)) { \
-		err |= put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} else { \
-		err |= put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} \
-	err |= put_user((k)->c_ispeed, &(u)->c_ispeed); \
-	err |= put_user((k)->c_ospeed, &(u)->c_ospeed); \
-	err; \
-})
+#define user_termios_to_kernel_termios user_termios_to_kernel_termios
 
-#define user_termios_to_kernel_termios_1(k, u) \
-({ \
-	int err; \
-	err  = get_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= get_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= get_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= get_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= get_user((k)->c_line,  &(u)->c_line); \
-	err |= copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
-	if ((k)->c_lflag & ICANON) { \
-		err |= get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} else { \
-		err |= get_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= get_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} \
-	err; \
-})
+static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
+						 struct ktermios *k)
+{
+	int err;
+	err  = put_user(k->c_iflag, &u->c_iflag);
+	err |= put_user(k->c_oflag, &u->c_oflag);
+	err |= put_user(k->c_cflag, &u->c_cflag);
+	err |= put_user(k->c_lflag, &u->c_lflag);
+	err |= put_user(k->c_line, &u->c_line);
+	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
+	if (!(k->c_lflag & ICANON)) {
+		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	} else {
+		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	}
+	err |= put_user(k->c_ispeed, &u->c_ispeed);
+	err |= put_user(k->c_ospeed, &u->c_ospeed);
+	return err;
+}
 
-#define kernel_termios_to_user_termios_1(u, k) \
-({ \
-	int err; \
-	err  = put_user((k)->c_iflag, &(u)->c_iflag); \
-	err |= put_user((k)->c_oflag, &(u)->c_oflag); \
-	err |= put_user((k)->c_cflag, &(u)->c_cflag); \
-	err |= put_user((k)->c_lflag, &(u)->c_lflag); \
-	err |= put_user((k)->c_line, &(u)->c_line); \
-	err |= copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
-	if (!((k)->c_lflag & ICANON)) { \
-		err |= put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
-		err |= put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
-	} else { \
-		err |= put_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
-		err |= put_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
-	} \
-	err; \
-})
+#define kernel_termios_to_user_termios kernel_termios_to_user_termios
+
+static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
+						 struct termios __user *u)
+{
+	int err;
+	err  = get_user(k->c_iflag, &u->c_iflag);
+	err |= get_user(k->c_oflag, &u->c_oflag);
+	err |= get_user(k->c_cflag, &u->c_cflag);
+	err |= get_user(k->c_lflag, &u->c_lflag);
+	err |= get_user(k->c_line,  &u->c_line);
+	err |= copy_from_user(k->c_cc, u->c_cc, NCCS);
+	if (k->c_lflag & ICANON) {
+		err |= get_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= get_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	} else {
+		err |= get_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= get_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	}
+	return err;
+}
+
+#define user_termios_to_kernel_termios_1 user_termios_to_kernel_termios_1
+
+static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
+						 struct ktermios *k)
+{
+	int err;
+	err  = put_user(k->c_iflag, &u->c_iflag);
+	err |= put_user(k->c_oflag, &u->c_oflag);
+	err |= put_user(k->c_cflag, &u->c_cflag);
+	err |= put_user(k->c_lflag, &u->c_lflag);
+	err |= put_user(k->c_line, &u->c_line);
+	err |= copy_to_user(u->c_cc, k->c_cc, NCCS);
+	if (!(k->c_lflag & ICANON)) {
+		err |= put_user(k->c_cc[VMIN],  &u->c_cc[_VMIN]);
+		err |= put_user(k->c_cc[VTIME], &u->c_cc[_VTIME]);
+	} else {
+		err |= put_user(k->c_cc[VEOF], &u->c_cc[VEOF]);
+		err |= put_user(k->c_cc[VEOL], &u->c_cc[VEOL]);
+	}
+	return err;
+}
+
+#define kernel_termios_to_user_termios_1 kernel_termios_to_user_termios_1
 
 #endif /* _SPARC_TERMIOS_H */
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index d99fec44036c..65410d87786a 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 #include <linux/compat.h>
+#include <linux/termios_internal.h>
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
diff --git a/include/asm-generic/termios-base.h b/include/asm-generic/termios-base.h
index 59c5a3bd4a6e..f5f65eb75340 100644
--- a/include/asm-generic/termios-base.h
+++ b/include/asm-generic/termios-base.h
@@ -62,17 +62,6 @@ static inline int kernel_termios_to_user_termio(struct termio __user *termio,
 	return 0;
 }
 
-#ifndef user_termios_to_kernel_termios
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#endif
-
-#ifndef kernel_termios_to_user_termios
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
-#endif
-
-#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
-
 #endif	/* __ARCH_TERMIO_GETPUT */
 
 #endif /* _ASM_GENERIC_TERMIOS_BASE_H */
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index b1398d0d4a1d..aa897f807ae6 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -67,42 +67,4 @@ static inline int kernel_termios_to_user_termio(struct termio __user *termio,
 	return 0;
 }
 
-#ifdef TCGETS2
-static inline int user_termios_to_kernel_termios(struct ktermios *k,
-						 struct termios2 __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios2));
-}
-
-static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
-						 struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios2));
-}
-
-static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
-						   struct termios __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios));
-}
-
-static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
-						   struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios));
-}
-#else /* TCGETS2 */
-static inline int user_termios_to_kernel_termios(struct ktermios *k,
-						 struct termios __user *u)
-{
-	return copy_from_user(k, u, sizeof(struct termios));
-}
-
-static inline int kernel_termios_to_user_termios(struct termios __user *u,
-						 struct ktermios *k)
-{
-	return copy_to_user(u, k, sizeof(struct termios));
-}
-#endif /* TCGETS2 */
-
 #endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
new file mode 100644
index 000000000000..3beb0595fd54
--- /dev/null
+++ b/include/linux/termios_internal.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TERMIOS_CONV_H
+#define _LINUX_TERMIOS_CONV_H
+
+#include <linux/uaccess.h>
+#include <asm/termios.h>
+
+#ifdef TCGETS2
+#ifndef user_termios_to_kernel_termios
+static inline int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios2 __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios2));
+}
+#endif
+#ifndef kernel_termios_to_user_termios
+static inline int kernel_termios_to_user_termios(struct termios2 __user *u,
+						 struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios2));
+}
+#endif
+#ifndef user_termios_to_kernel_termios_1
+static inline int user_termios_to_kernel_termios_1(struct ktermios *k,
+						   struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios));
+}
+#endif
+
+#ifndef kernel_termios_to_user_termios_1
+static inline int kernel_termios_to_user_termios_1(struct termios __user *u,
+						   struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios));
+}
+#endif
+
+#else
+
+#ifndef user_termios_to_kernel_termios
+static inline int user_termios_to_kernel_termios(struct ktermios *k,
+						 struct termios __user *u)
+{
+	return copy_from_user(k, u, sizeof(struct termios));
+}
+#endif
+#ifndef kernel_termios_to_user_termios
+static inline int kernel_termios_to_user_termios(struct termios __user *u,
+						 struct ktermios *k)
+{
+	return copy_to_user(u, k, sizeof(struct termios));
+}
+#endif
+
+#endif /* TCGETS2 */
+
+#endif /* _LINUX_TERMIOS_CONV_H */
-- 
2.11.0
