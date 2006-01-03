Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:17045 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964842AbWACXHG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jan 2006 18:07:06 -0500
Date: Tue, 3 Jan 2006 18:59:10 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [RFC] Consolidate asm/futex.h
Message-ID: <20060103235910.GA10792@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
List-ID: <linux-arch.vger.kernel.org>

Most of the architectures have the same asm/futex.h.  The patch below
consolidates them into asm-generic, with the arches including it from
their own asm/futex.h.

Unless there are objections, I'm going to send this to Andrew in the
next few days.

				Jeff


Index: linux-2.6.15/include/asm-alpha/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-alpha/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-alpha/futex.h	2005-12-31 13:45:50.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-arm/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-arm/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-arm/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-arm26/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-arm26/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-arm26/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-cris/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-cris/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-cris/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-frv/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-frv/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-frv/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-generic/futex.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/include/asm-generic/futex.h	2005-12-31 13:45:16.000000000 -0500
@@ -0,0 +1,53 @@
+#ifndef _ASM_GENERIC_FUTEX_H
+#define _ASM_GENERIC_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
+{
+	int op = (encoded_op >> 28) & 7;
+	int cmp = (encoded_op >> 24) & 15;
+	int oparg = (encoded_op << 8) >> 20;
+	int cmparg = (encoded_op << 20) >> 20;
+	int oldval = 0, ret;
+	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+		oparg = 1 << oparg;
+
+	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+	inc_preempt_count();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+	case FUTEX_OP_ADD:
+	case FUTEX_OP_OR:
+	case FUTEX_OP_ANDN:
+	case FUTEX_OP_XOR:
+	default:
+		ret = -ENOSYS;
+	}
+
+	dec_preempt_count();
+
+	if (!ret) {
+		switch (cmp) {
+		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
+		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
+		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
+		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
+		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
+		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
+		default: ret = -ENOSYS;
+		}
+	}
+	return ret;
+}
+
+#endif
+#endif
Index: linux-2.6.15/include/asm-h8300/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-h8300/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-h8300/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-ia64/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-ia64/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-ia64/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-m32r/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-m32r/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-m32r/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-m68k/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-m68k/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-m68k/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-m68knommu/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-m68knommu/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-m68knommu/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-parisc/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-parisc/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-parisc/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-s390/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-s390/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-s390/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sh/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sh/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sh/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sh64/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sh64/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sh64/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sparc/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sparc/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sparc/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-sparc64/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-sparc64/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-sparc64/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
Index: linux-2.6.15/include/asm-um/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-um/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-um/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,12 +1,6 @@
-#ifndef __UM_FUTEX_H
-#define __UM_FUTEX_H
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/system.h>
-#include <asm/processor.h>
-#include <asm/uaccess.h>
-
-#include "asm/arch/futex.h"
+#include <asm-generic/futex.h>
 
 #endif
Index: linux-2.6.15/include/asm-v850/futex.h
===================================================================
--- linux-2.6.15.orig/include/asm-v850/futex.h	2005-10-28 12:58:15.000000000 -0400
+++ linux-2.6.15/include/asm-v850/futex.h	2005-12-31 13:47:35.000000000 -0500
@@ -1,53 +1,6 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#ifdef __KERNEL__
+#include <asm-generic/futex.h>
 
-#include <linux/futex.h>
-#include <asm/errno.h>
-#include <asm/uaccess.h>
-
-static inline int
-futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret;
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
-
-	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
-
-	inc_preempt_count();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	dec_preempt_count();
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
-
-#endif
 #endif
