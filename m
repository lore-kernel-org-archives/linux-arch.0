From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 055/109] fs: add do_lookup_dcookie() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:23:32 +0200
Message-ID: <20180329112426.23043-56-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_lookup_dcookie() helper allows us to get rid of
fs-internal calls to the sys_lookup_dcookie() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/dcookies.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/dcookies.c b/fs/dcookies.c
index 0d0461cf2431..57bc96435feb 100644
--- a/fs/dcookies.c
+++ b/fs/dcookies.c
@@ -146,7 +146,7 @@ int get_dcookie(const struct path *path, unsigned long *cookie)
 /* And here is where the userspace process can look up the cookie value
  * to retrieve the path.
  */
-SYSCALL_DEFINE3(lookup_dcookie, u64, cookie64, char __user *, buf, size_t, len)
+static int do_lookup_dcookie(u64 cookie64, char __user *buf, size_t len)
 {
 	unsigned long cookie = (unsigned long)cookie64;
 	int err = -EINVAL;
@@ -203,13 +203,18 @@ SYSCALL_DEFINE3(lookup_dcookie, u64, cookie64, char __user *, buf, size_t, len)
 	return err;
 }
 
+SYSCALL_DEFINE3(lookup_dcookie, u64, cookie64, char __user *, buf, size_t, len)
+{
+	return do_lookup_dcookie(cookie64, buf, len);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(lookup_dcookie, u32, w0, u32, w1, char __user *, buf, compat_size_t, len)
 {
 #ifdef __BIG_ENDIAN
-	return sys_lookup_dcookie(((u64)w0 << 32) | w1, buf, len);
+	return do_lookup_dcookie(((u64)w0 << 32) | w1, buf, len);
 #else
-	return sys_lookup_dcookie(((u64)w1 << 32) | w0, buf, len);
+	return do_lookup_dcookie(((u64)w1 << 32) | w0, buf, len);
 #endif
 }
 #endif
-- 
2.16.3
