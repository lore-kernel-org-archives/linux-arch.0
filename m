Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:61585 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264058AbUFQW3B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Jun 2004 18:29:01 -0400
Message-ID: <40D21B17.4060603@intel.com>
Date: Thu, 17 Jun 2004 15:28:39 -0700
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: sys getdents64 needs compat wrapper ?
References: <26879984$108508699040ad1d0eba5381.88033699@config20.schlund.de> <20040604172816.259f38e8.davem@redhat.com> <40C4DA5E.8090700@intel.com> <200406111709.35146.arnd@arndb.de> <40CDEB59.3040203@intel.com>
In-Reply-To: <40CDEB59.3040203@intel.com>
Content-Type: multipart/mixed;
 boundary="------------050304040606090107050605"
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@redhat.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050304040606090107050605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/2004 11:15 AM, Arun Sharma wrote:

>> I just realized your code is broken on big-endian architectures, so
>> we should either get back to __copy_to_user or find the optimal solution
>> now.
>>
>> How about a {__,}{get,put}_user_unaligned() that gets defined per
>> architecture in one of these two ways:
> 
> 
> We'll go for the optimal solution now. We'll provide an 
> <asm-generic/uaccess.h> that does __copy_to_user and a 
> <asm-ia64/uaccess.h> that's optimized for ia64. Archs which don't care 
> about alignment can override appropriately.
> 
> Should have the patch tested by tomorrow.

It took us a bit longer :) But here's the promised patch. Using __put_user_unaligned() on ia64 may still cause unaligned faults, but we chose to optimize for the common case, where it's 4 byte aligned.

	-Arun

--------------050304040606090107050605
Content-Type: text/plain;
 name="__get_put_user_unaligned.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="__get_put_user_unaligned.patch"

(1) Fix compat_filldir64() which is broken on big-endian machines.
(2) Introduce new APIs __{get,put}_user_unaligned.
(3) Optimize __{get,put}_user_unaligned for ia64.

Signed-off-by: Gordon Jin <gordon.jin@intel.com>
Signed-off-by: Arun Sharma <arun.sharma@intel.com>

---

 fs/compat.c                   |   14 ++++----------
 include/asm-generic/uaccess.h |   25 +++++++++++++++++++++++++
 include/asm-ia64/uaccess.h    |   36 ++++++++++++++++++++++++++++++++++++
 include/asm-mips/uaccess.h    |    1 +
 include/asm-ppc64/uaccess.h   |    1 +
 include/asm-s390/uaccess.h    |    1 +
 include/asm-sparc64/uaccess.h |    1 +
 include/asm-x86_64/uaccess.h  |    1 +
 8 files changed, 70 insertions(+), 10 deletions(-)

diff -purN -X dontdiff linux-2.6.7-rc3-getdents/fs/compat.c linux-2.6.7-rc3-getdents-user_unaligned/fs/compat.c
--- linux-2.6.7-rc3-getdents/fs/compat.c	2004-06-16 22:13:46.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/fs/compat.c	2004-06-17 14:51:42.019623885 +0800
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
 
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-generic/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-generic/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-generic/uaccess.h	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-generic/uaccess.h	2004-06-17 15:06:28.391683339 +0800
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
+	copy_from_user(&__x, (ptr), sizeof(*(ptr))) ? -EFAULT : 0;	\
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
+	copy_to_user((ptr), &__x, sizeof(*(ptr))) ? -EFAULT : 0;	\
+})
+
+#endif /* _ASM_GENERIC_UACCESS_H */
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-ia64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ia64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-ia64/uaccess.h	2004-06-16 22:13:46.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ia64/uaccess.h	2004-06-17 15:13:34.646560930 +0800
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
+			|| (__put_user((x) >> 8, ((u8 __user *)(ptr) + 1))); break;		\
+		case 4: __ret = (__put_user((x), (u16 __user *)(ptr)))				\
+			|| (__put_user((x) >> 16, ((u16 __user *)(ptr) + 1))); break;		\
+		case 8: __ret = (__put_user((x), (u32 __user *)(ptr)))				\
+			|| (__put_user((x) >> 32, ((u32 __user *)(ptr) + 1))); break;		\
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
+			|| (__get_user((x) >> 8, ((u8 __user *)(ptr) + 1))); break;		\
+		case 4: __ret = (__get_user((x), (u16 __user *)(ptr)))				\
+			|| (__get_user((x) >> 16, ((u16 __user *)(ptr) + 1))); break;		\
+		case 8: __ret = (__get_user((x), (u32 __user *)(ptr)))				\
+			|| (__get_user((x) >> 32, ((u32 __user *)(ptr) + 1))); break;		\
+		default: __ret = __get_user_unaligned_unknown();				\
+	}											\
+	__ret;											\
+})
+
 #ifdef ASM_SUPPORTED
   struct __large_struct { unsigned long buf[100]; };
 # define __m(x) (*(struct __large_struct *)(x))
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-mips/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-mips/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-mips/uaccess.h	2004-06-15 13:41:35.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-mips/uaccess.h	2004-06-17 14:51:42.020600447 +0800
@@ -13,6 +13,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/thread_info.h>
+#include <asm-generic/uaccess.h>
 
 /*
  * The fs value determines whether argument validity checking should be
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-ppc64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ppc64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-ppc64/uaccess.h	2004-06-15 13:41:35.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-ppc64/uaccess.h	2004-06-17 14:51:42.020600447 +0800
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <asm/processor.h>
+#include <asm-generic/uaccess.h>
 
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-s390/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-s390/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-s390/uaccess.h	2004-06-15 13:41:39.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-s390/uaccess.h	2004-06-17 14:51:42.021577010 +0800
@@ -16,6 +16,7 @@
  */
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <asm-generic/uaccess.h>
 
 #define VERIFY_READ     0
 #define VERIFY_WRITE    1
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-sparc64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-sparc64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-sparc64/uaccess.h	2004-06-15 13:41:39.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-sparc64/uaccess.h	2004-06-17 14:51:42.021577010 +0800
@@ -14,6 +14,7 @@
 #include <asm/asi.h>
 #include <asm/system.h>
 #include <asm/spitfire.h>
+#include <asm-generic/uaccess.h>
 #endif
 
 #ifndef __ASSEMBLY__
diff -purN -X dontdiff linux-2.6.7-rc3-getdents/include/asm-x86_64/uaccess.h linux-2.6.7-rc3-getdents-user_unaligned/include/asm-x86_64/uaccess.h
--- linux-2.6.7-rc3-getdents/include/asm-x86_64/uaccess.h	2004-06-15 13:41:34.000000000 +0800
+++ linux-2.6.7-rc3-getdents-user_unaligned/include/asm-x86_64/uaccess.h	2004-06-17 14:51:42.022553572 +0800
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
+#include <asm-generic/uaccess.h>
 
 #define VERIFY_READ 0
 #define VERIFY_WRITE 1

--------------050304040606090107050605--
