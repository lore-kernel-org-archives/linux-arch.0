From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 24/45] kexec: call do_kexec_load() in compat syscall directly
Date: Thu, 22 Mar 2018 10:00:38 +0100
Message-ID: <20180322090059.19361-25-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

do_kexec_load() can be called directly by compat_sys_kexec() as long as
the same parameters checks are completed which are currently handled
(also) by sys_kexec(). Therefore, move those to kexec_load_check(),
call that newly introduced helper function from both sys_kexec() and
compat_sys_kexec(), and duplicate the remaining code from sys_kexec()
in compat_sys_kexec().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/kexec.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index e62ec4dc6620..d959dc2c5587 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -192,11 +192,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
  * that to happen you need to do that yourself.
  */
 
-SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
-		struct kexec_segment __user *, segments, unsigned long, flags)
+static inline int kexec_load_check(unsigned long nr_segments,
+				   unsigned long flags)
 {
-	int result;
-
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
@@ -208,17 +206,29 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
 		return -EINVAL;
 
-	/* Verify we are on the appropriate architecture */
-	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
-		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
-		return -EINVAL;
-
 	/* Put an artificial cap on the number
 	 * of segments passed to kexec_load.
 	 */
 	if (nr_segments > KEXEC_SEGMENT_MAX)
 		return -EINVAL;
 
+	return 0;
+}
+
+SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
+		struct kexec_segment __user *, segments, unsigned long, flags)
+{
+	int result;
+
+	result = kexec_load_check(nr_segments, flags);
+	if (result)
+		return result;
+
+	/* Verify we are on the appropriate architecture */
+	if (((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH) &&
+		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
+		return -EINVAL;
+
 	/* Because we write directly to the reserved memory
 	 * region when loading crash kernels we need a mutex here to
 	 * prevent multiple crash  kernels from attempting to load
@@ -247,15 +257,16 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 	struct kexec_segment out, __user *ksegments;
 	unsigned long i, result;
 
+	result = kexec_load_check(nr_segments, flags);
+	if (result)
+		return result;
+
 	/* Don't allow clients that don't understand the native
 	 * architecture to do anything.
 	 */
 	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
 		return -EINVAL;
 
-	if (nr_segments > KEXEC_SEGMENT_MAX)
-		return -EINVAL;
-
 	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
 	for (i = 0; i < nr_segments; i++) {
 		result = copy_from_user(&in, &segments[i], sizeof(in));
@@ -272,6 +283,19 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
 			return -EFAULT;
 	}
 
-	return sys_kexec_load(entry, nr_segments, ksegments, flags);
+	/* Because we write directly to the reserved memory
+	 * region when loading crash kernels we need a mutex here to
+	 * prevent multiple crash  kernels from attempting to load
+	 * simultaneously, and to prevent a crash kernel from loading
+	 * over the top of a in use crash kernel.
+	 *
+	 * KISS: always take the mutex.
+	 */
+	if (!mutex_trylock(&kexec_mutex))
+		return -EBUSY;
+
+	result = do_kexec_load(entry, nr_segments, ksegments, flags);
+
+	mutex_unlock(&kexec_mutex);
 }
 #endif
-- 
2.16.2
