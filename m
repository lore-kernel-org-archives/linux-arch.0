Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:48340 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265698AbUFRRF6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jun 2004 13:05:58 -0400
Message-ID: <40D320E2.9020806@intel.com>
Date: Fri, 18 Jun 2004 10:05:38 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: sys getdents64 needs compat wrapper ?
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de> <40CDEB59.3040203@intel.com> <40D21B17.4060603@intel.com> <200406180136.34384.arnd@arndb.de> <40D23DC3.5080005@intel.com>
In-Reply-To: <40D23DC3.5080005@intel.com>
Content-Type: multipart/mixed;
 boundary="------------020306080604070903090700"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020306080604070903090700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2004 5:56 PM, Arun Sharma wrote:

>>
>> This should be __copy_from_user instead of copy_from_user, right?
>>
> 
> Yes, will fix.

Updated patch attached.

	-Arun


--------------020306080604070903090700
Content-Type: text/plain;
 name="__get_put_user_unaligned.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__get_put_user_unaligned.2.patch"

(1) Fix compat_filldir64() which is broken on big-endian machines.
(2) Introduce new APIs __{get,put}_user_unaligned.
(3) Optimize __{get,put}_user_unaligned for ia64, x86-64, s390, ppc64.

Thanks to Arnd Bergmann <arnd@arndb.de> for his help.

Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Signed-off-by: Arun Sharma <arun.sharma@intel.com>

diff -purN linux-2.6.7-rc3-getdents/fs/compat.c linux-2.6.7-rc3-getdents-user_unaligned/fs/compat.c
--- linux-2.6.7-rc3-getdents/fs/compat.c	2004-06-18 18:41:36.072597378 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/fs/compat.c	2004-06-17 14:51:42.000000000 +0800
@@ -979,19 +979,14 @@ static int compat_filldir64(void * __buf
 	dirent = buf->previous;

 	if (dirent) {
-		if (__put_user(offset, (u32 __user *)&dirent->d_off))
-			goto efault;
-		if (__put_user(offset >> 32,
-				((u32 __user *)&dirent->d_off) + 1))
+		if (__put_user_unaligned(offset, &dirent->d_off))
 			goto efault;
 	}
 	dirent = buf->current_dir;
-	if ((__put_user(ino, (u32 __user *)&dirent->d_ino))
-	 || (__put_user(ino >> 32, ((u32 __user *)&dirent->d_ino) + 1)))
+	if (__put_user_unaligned(ino, &dirent->d_ino))
 		goto efault;
 	off = 0;
-	if ((__put_user(off, (u32 __user *)&dirent->d_off))
-	 || (__put_user(off >> 32, ((u32 __user *)&dirent->d_off) + 1)))
+	if (__put_user_unaligned(off, &dirent->d_off))
 		goto efault;
 	if (__put_user(reclen, &dirent->d_reclen))
 		goto efault;
@@ -1040,8 +1035,7 @@ asmlinkage long compat_sys_getdents64(un
 	lastdirent = buf.previous;
 	if (lastdirent) {
 		typeof(lastdirent->d_off) d_off = file->f_pos;
-		__put_user(d_off, (u32 __user *)&lastdirent->d_off);
-		__put_user(d_off >> 32, ((u32 __user *)&lastdirent->d_off) + 1);
+		__put_user_unaligned(d_off, &lastdirent->d_off);
 		error = count - buf.count;
 	}

diff -purN linux-2.6.7-rc3-getdents/include/asm-generic/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-generic/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-generic/uaccess.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-generic/uaccess.h	2004-06-18 18:20:19.274761456 +0800
@@ -0,0 +1,25 @@
+#ifndef _ASM_GENERIC_UACCESS_H_
+#define _ASM_GENERIC_UACCESS_H_
+
+/*
+ * This macro should be used instead of __get_user() when accessing
+ * values at locations that are unknown to be aligned.
+ */
+#define __get_user_unaligned(x, ptr)					\
+({									\
+	__typeof__ (*(ptr)) __x = (x);					\
+	__copy_from_user(&__x, (ptr), sizeof(*(ptr))) ? -EFAULT : 0;	\
+})
+
+
+/*
+ * This macro should be used instead of __put_user() when accessing
+ * values at locations that are unknown to be aligned.
+ */
+#define __put_user_unaligned(x, ptr)					\
+({									\
+	__typeof__ (*(ptr)) __x = (x);					\
+	__copy_to_user((ptr), &__x, sizeof(*(ptr))) ? -EFAULT : 0;	\
+})
+
+#endif /* _ASM_GENERIC_UACCESS_H */
diff -purN linux-2.6.7-rc3-getdents/include/asm-ia64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ia64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-ia64/uaccess.h	2004-06-18 18:41:09.208339895 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ia64/uaccess.h	2004-06-18 18:24:27.561867790 +0800
@@ -91,6 +91,42 @@ verify_area (int type, const void *addr,
 #define __put_user(x, ptr)	__put_user_nocheck((__typeof__(*(ptr))) (x), (ptr), sizeof(*(ptr)))
 #define __get_user(x, ptr)	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))

+extern long __put_user_unaligned_unknown (void);
+
+#define __put_user_unaligned(x, ptr)								\
+({												\
+	long __ret;										\
+	switch (sizeof(*(ptr))) {								\
+		case 1: __ret = __put_user((x), (ptr)); break;					\
+		case 2: __ret = (__put_user((x), (u8 __user *)(ptr)))				\
+			| (__put_user((x) >> 8, ((u8 __user *)(ptr) + 1))); break;		\
+		case 4: __ret = (__put_user((x), (u16 __user *)(ptr)))				\
+			| (__put_user((x) >> 16, ((u16 __user *)(ptr) + 1))); break;		\
+		case 8: __ret = (__put_user((x), (u32 __user *)(ptr)))				\
+			| (__put_user((x) >> 32, ((u32 __user *)(ptr) + 1))); break;		\
+		default: __ret = __put_user_unaligned_unknown();				\
+	}											\
+	__ret;											\
+})
+
+extern long __get_user_unaligned_unknown (void);
+
+#define __get_user_unaligned(x, ptr)								\
+({												\
+	long __ret;										\
+	switch (sizeof(*(ptr))) {								\
+		case 1: __ret = __get_user((x), (ptr)); break;					\
+		case 2: __ret = (__get_user((x), (u8 __user *)(ptr)))				\
+			| (__get_user((x) >> 8, ((u8 __user *)(ptr) + 1))); break;		\
+		case 4: __ret = (__get_user((x), (u16 __user *)(ptr)))				\
+			| (__get_user((x) >> 16, ((u16 __user *)(ptr) + 1))); break;		\
+		case 8: __ret = (__get_user((x), (u32 __user *)(ptr)))				\
+			| (__get_user((x) >> 32, ((u32 __user *)(ptr) + 1))); break;		\
+		default: __ret = __get_user_unaligned_unknown();				\
+	}											\
+	__ret;											\
+})
+
 #ifdef ASM_SUPPORTED
   struct __large_struct { unsigned long buf[100]; };
 # define __m(x) (*(struct __large_struct *)(x))
diff -purN linux-2.6.7-rc3-getdents/include/asm-mips/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-mips/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-mips/uaccess.h	2004-06-18 18:41:06.639980551 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-mips/uaccess.h	2004-06-17 14:51:42.000000000 +0800
@@ -13,6 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/thread_info.h>
+#include <asm-generic/uaccess.h>

 /*
  * The fs value determines whether argument validity checking should be
diff -purN linux-2.6.7-rc3-getdents/include/asm-ppc64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ppc64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-ppc64/uaccess.h	2004-06-18 18:41:04.989589946 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ppc64/uaccess.h	2004-06-18 18:27:57.600927717 +0800
@@ -111,6 +111,9 @@ extern unsigned long search_exception_ta
 #define __put_user(x,ptr) \
   __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))

+#define __get_user_unaligned __get_user
+#define __put_user_unaligned __put_user
+
 extern long __put_user_bad(void);

 #define __put_user_nocheck(x,ptr,size)				\
diff -purN linux-2.6.7-rc3-getdents/include/asm-s390/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-s390/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-s390/uaccess.h	2004-06-18 18:41:20.317714758 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-s390/uaccess.h	2004-06-18 18:31:37.594089084 +0800
@@ -230,6 +230,9 @@ extern int __put_user_bad(void);

 extern int __get_user_bad(void);

+#define __put_user_unaligned __put_user
+#define __get_user_unaligned __get_user
+
 extern long __copy_to_user_asm(const void *from, long n, void *to);

 /**
diff -purN linux-2.6.7-rc3-getdents/include/asm-sparc64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-sparc64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-sparc64/uaccess.h	2004-06-18 18:41:21.579433493 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-sparc64/uaccess.h	2004-06-17 14:51:42.000000000 +0800
@@ -14,6 +14,7 @@
 #include <asm/asi.h>
 #include <asm/system.h>
 #include <asm/spitfire.h>
+#include <asm-generic/uaccess.h>
 #endif

 #ifndef __ASSEMBLY__
diff -purN linux-2.6.7-rc3-getdents/include/asm-x86_64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-x86_64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-x86_64/uaccess.h	2004-06-18 18:41:04.255214955 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-x86_64/uaccess.h	2004-06-18 18:32:15.028658938 +0800
@@ -147,6 +147,9 @@ extern void __put_user_bad(void);
 #define __put_user(x,ptr) \
   __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))

+#define __get_user_unaligned __get_user
+#define __put_user_unaligned __put_user
+
 #define __put_user_nocheck(x,ptr,size)			\
 ({							\
 	int __pu_err;					\

--------------020306080604070903090700--
