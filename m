From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to
 user_full_access_begin/end()
Date: Fri,  3 Apr 2020 07:20:54 +0000 (UTC)
Message-ID: <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:51428 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388959AbgDCHU5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 03:20:57 -0400
In-Reply-To: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, intel-gfx@lists.freedesktop.org

Now we have user_read_access_begin() and user_write_access_begin()
in addition to user_access_begin().

Make it explicit that user_access_begin() provides both read and
write by renaming it user_full_access_begin(). And the same for
user_access_end() which becomes user_full_access_end().

Done with following command, then hand splitted two too long lines.

sed -i s/user_access_begin/user_full_access_begin/g `git grep -l user_access_begin`

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: New, based on remark from Al Viro.
---
 arch/powerpc/include/asm/uaccess.h | 5 +++--
 arch/x86/include/asm/futex.h       | 4 ++--
 arch/x86/include/asm/uaccess.h     | 7 ++++---
 include/linux/uaccess.h            | 8 ++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 4427d419eb1d..7fe799e081f2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -456,14 +456,15 @@ extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 			   size_t len);
 
-static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check inline bool
+user_full_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr, len)))
 		return false;
 	allow_read_write_user((void __user *)ptr, ptr, len);
 	return true;
 }
-#define user_access_begin	user_access_begin
+#define user_full_access_begin	user_full_access_begin
 #define user_access_end		prevent_current_access_user
 #define user_access_save	prevent_user_access_return
 #define user_access_restore	restore_user_access
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index f9c00110a69a..9eefea374bd4 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -56,7 +56,7 @@ do {								\
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
-	if (!user_access_begin(uaddr, sizeof(u32)))
+	if (!user_full_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
 	switch (op) {
@@ -92,7 +92,7 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 {
 	int ret = 0;
 
-	if (!user_access_begin(uaddr, sizeof(u32)))
+	if (!user_full_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 	asm volatile("\n"
 		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index d8f283b9a569..8776e815f215 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -473,16 +473,17 @@ extern struct movsl_mask {
  * The "unsafe" user accesses aren't really "unsafe", but the naming
  * is a big fat warning: you have to not only do the access_ok()
  * checking before using them, but you have to surround them with the
- * user_access_begin/end() pair.
+ * user_full_access_begin/end() pair.
  */
-static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check __always_inline bool
+user_full_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr,len)))
 		return 0;
 	__uaccess_begin_nospec();
 	return 1;
 }
-#define user_access_begin(a,b)	user_access_begin(a,b)
+#define user_full_access_begin(a,b)	user_full_access_begin(a,b)
 #define user_access_end()	__uaccess_end()
 
 #define user_access_save()	smap_save()
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 9861c89f93be..5be9bc930342 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -368,8 +368,8 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 #define probe_kernel_address(addr, retval)		\
 	probe_kernel_read(&retval, addr, sizeof(retval))
 
-#ifndef user_access_begin
-#define user_access_begin(ptr,len) access_ok(ptr, len)
+#ifndef user_full_access_begin
+#define user_full_access_begin(ptr,len) access_ok(ptr, len)
 #define user_access_end() do { } while (0)
 #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
 #define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user(x,p),e)
@@ -379,11 +379,11 @@ static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif
 #ifndef user_write_access_begin
-#define user_write_access_begin user_access_begin
+#define user_write_access_begin user_full_access_begin
 #define user_write_access_end user_access_end
 #endif
 #ifndef user_read_access_begin
-#define user_read_access_begin user_access_begin
+#define user_read_access_begin user_full_access_begin
 #define user_read_access_end user_access_end
 #endif
 
-- 
2.25.0
