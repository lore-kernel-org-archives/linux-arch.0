From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Subject: [PATCH 004/109] kexec: call do_kexec_load() in compat syscall directly
Date: Thu, 29 Mar 2018 13:22:41 +0200
Message-ID: <20180329112426.23043-5-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180329112426.23043-1-linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, viro-3bDd1+5oDREiFSDQTTA3OLVCufUGDwFn@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Eric Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

do_kexec_load() can be called directly by compat_sys_kexec() as long as
the same parameters checks are completed which are currently handled
(also) by sys_kexec(). Therefore, move those to kexec_load_check(),
call that newly introduced helper function from both sys_kexec() and
compat_sys_kexec(), and duplicate the remaining code from sys_kexec()
in compat_sys_kexec().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492-SGhQLRGLuNwb6pqDj42GsMgv3T4z79SOrE5yTffgRl4@public.gmane.org

Cc: Eric Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
---
 kernel/kexec.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index e62ec4dc6620..aed8fb2564b3 100644
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
@@ -272,6 +283,21 @@ COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
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
+
+	return result;
 }
 #endif
-- 
2.16.3
