From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 22/45] kernel: provide ksys_*() wrappers for syscalls called by kernel/uid16.c
Date: Thu, 22 Mar 2018 10:00:36 +0100
Message-ID: <20180322090059.19361-23-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using these helpers allows us to avoid the in-kernel calls to these
syscalls: sys_setregid(), sys_setgid(), sys_setreuid(), sys_setuid(),
sys_setresuid(), sys_setresgid(), sys_setfsuid(), and sys_setfsgid().

The ksys_ prefix denotes that these function are meant as a drop-in
replacement for the syscall. In particular, they use the same calling
convention.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/sys.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 kernel/uid16.c | 19 ++++++++++---------
 kernel/uid16.h | 14 ++++++++++++++
 3 files changed, 74 insertions(+), 17 deletions(-)
 create mode 100644 kernel/uid16.h

diff --git a/kernel/sys.c b/kernel/sys.c
index 8eda25dcbbd4..ad692183dfe9 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -69,6 +69,8 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
 
+#include "uid16.h"
+
 #ifndef SET_UNALIGN_CTL
 # define SET_UNALIGN_CTL(a, b)	(-EINVAL)
 #endif
@@ -340,7 +342,7 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
  *      operations (as far as semantic preservation is concerned).
  */
 #ifdef CONFIG_MULTIUSER
-SYSCALL_DEFINE2(setregid, gid_t, rgid, gid_t, egid)
+long __sys_setregid(gid_t rgid, gid_t egid)
 {
 	struct user_namespace *ns = current_user_ns();
 	const struct cred *old;
@@ -392,12 +394,17 @@ SYSCALL_DEFINE2(setregid, gid_t, rgid, gid_t, egid)
 	return retval;
 }
 
+SYSCALL_DEFINE2(setregid, gid_t, rgid, gid_t, egid)
+{
+	return __sys_setregid(rgid, egid);
+}
+
 /*
  * setgid() is implemented like SysV w/ SAVED_IDS
  *
  * SMP: Same implicit races as above.
  */
-SYSCALL_DEFINE1(setgid, gid_t, gid)
+long __sys_setgid(gid_t gid)
 {
 	struct user_namespace *ns = current_user_ns();
 	const struct cred *old;
@@ -429,6 +436,11 @@ SYSCALL_DEFINE1(setgid, gid_t, gid)
 	return retval;
 }
 
+SYSCALL_DEFINE1(setgid, gid_t, gid)
+{
+	return __sys_setgid(gid);
+}
+
 /*
  * change the user struct in a credentials set to match the new UID
  */
@@ -473,7 +485,7 @@ static int set_user(struct cred *new)
  * 100% compatible with BSD.  A program which uses just setuid() will be
  * 100% compatible with POSIX with saved IDs.
  */
-SYSCALL_DEFINE2(setreuid, uid_t, ruid, uid_t, euid)
+long __sys_setreuid(uid_t ruid, uid_t euid)
 {
 	struct user_namespace *ns = current_user_ns();
 	const struct cred *old;
@@ -533,6 +545,11 @@ SYSCALL_DEFINE2(setreuid, uid_t, ruid, uid_t, euid)
 	return retval;
 }
 
+SYSCALL_DEFINE2(setreuid, uid_t, ruid, uid_t, euid)
+{
+	return __sys_setreuid(ruid, euid);
+}
+
 /*
  * setuid() is implemented like SysV with SAVED_IDS
  *
@@ -544,7 +561,7 @@ SYSCALL_DEFINE2(setreuid, uid_t, ruid, uid_t, euid)
  * will allow a root program to temporarily drop privileges and be able to
  * regain them by swapping the real and effective uid.
  */
-SYSCALL_DEFINE1(setuid, uid_t, uid)
+long __sys_setuid(uid_t uid)
 {
 	struct user_namespace *ns = current_user_ns();
 	const struct cred *old;
@@ -586,12 +603,17 @@ SYSCALL_DEFINE1(setuid, uid_t, uid)
 	return retval;
 }
 
+SYSCALL_DEFINE1(setuid, uid_t, uid)
+{
+	return __sys_setuid(uid);
+}
+
 
 /*
  * This function implements a generic ability to update ruid, euid,
  * and suid.  This allows you to implement the 4.4 compatible seteuid().
  */
-SYSCALL_DEFINE3(setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
+long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 {
 	struct user_namespace *ns = current_user_ns();
 	const struct cred *old;
@@ -656,6 +678,11 @@ SYSCALL_DEFINE3(setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
 	return retval;
 }
 
+SYSCALL_DEFINE3(setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
+{
+	return __sys_setresuid(ruid, euid, suid);
+}
+
 SYSCALL_DEFINE3(getresuid, uid_t __user *, ruidp, uid_t __user *, euidp, uid_t __user *, suidp)
 {
 	const struct cred *cred = current_cred();
@@ -678,7 +705,7 @@ SYSCALL_DEFINE3(getresuid, uid_t __user *, ruidp, uid_t __user *, euidp, uid_t _
 /*
  * Same as above, but for rgid, egid, sgid.
  */
-SYSCALL_DEFINE3(setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
+long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid)
 {
 	struct user_namespace *ns = current_user_ns();
 	const struct cred *old;
@@ -730,6 +757,11 @@ SYSCALL_DEFINE3(setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
 	return retval;
 }
 
+SYSCALL_DEFINE3(setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
+{
+	return __sys_setresgid(rgid, egid, sgid);
+}
+
 SYSCALL_DEFINE3(getresgid, gid_t __user *, rgidp, gid_t __user *, egidp, gid_t __user *, sgidp)
 {
 	const struct cred *cred = current_cred();
@@ -757,7 +789,7 @@ SYSCALL_DEFINE3(getresgid, gid_t __user *, rgidp, gid_t __user *, egidp, gid_t _
  * whatever uid it wants to). It normally shadows "euid", except when
  * explicitly set by setfsuid() or for access..
  */
-SYSCALL_DEFINE1(setfsuid, uid_t, uid)
+long __sys_setfsuid(uid_t uid)
 {
 	const struct cred *old;
 	struct cred *new;
@@ -793,10 +825,15 @@ SYSCALL_DEFINE1(setfsuid, uid_t, uid)
 	return old_fsuid;
 }
 
+SYSCALL_DEFINE1(setfsuid, uid_t, uid)
+{
+	return __sys_setfsuid(uid);
+}
+
 /*
  * Samma på svenska..
  */
-SYSCALL_DEFINE1(setfsgid, gid_t, gid)
+long __sys_setfsgid(gid_t gid)
 {
 	const struct cred *old;
 	struct cred *new;
@@ -830,6 +867,11 @@ SYSCALL_DEFINE1(setfsgid, gid_t, gid)
 	commit_creds(new);
 	return old_fsgid;
 }
+
+SYSCALL_DEFINE1(setfsgid, gid_t, gid)
+{
+	return __sys_setfsgid(gid);
+}
 #endif /* CONFIG_MULTIUSER */
 
 /**
diff --git a/kernel/uid16.c b/kernel/uid16.c
index ea3cf87ff000..af6925d8599b 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -18,6 +18,8 @@
 
 #include <linux/uaccess.h>
 
+#include "uid16.h"
+
 SYSCALL_DEFINE3(chown16, const char __user *, filename, old_uid_t, user, old_gid_t, group)
 {
 	return ksys_chown(filename, low2highuid(user), low2highgid(group));
@@ -35,27 +37,27 @@ SYSCALL_DEFINE3(fchown16, unsigned int, fd, old_uid_t, user, old_gid_t, group)
 
 SYSCALL_DEFINE2(setregid16, old_gid_t, rgid, old_gid_t, egid)
 {
-	return sys_setregid(low2highgid(rgid), low2highgid(egid));
+	return __sys_setregid(low2highgid(rgid), low2highgid(egid));
 }
 
 SYSCALL_DEFINE1(setgid16, old_gid_t, gid)
 {
-	return sys_setgid(low2highgid(gid));
+	return __sys_setgid(low2highgid(gid));
 }
 
 SYSCALL_DEFINE2(setreuid16, old_uid_t, ruid, old_uid_t, euid)
 {
-	return sys_setreuid(low2highuid(ruid), low2highuid(euid));
+	return __sys_setreuid(low2highuid(ruid), low2highuid(euid));
 }
 
 SYSCALL_DEFINE1(setuid16, old_uid_t, uid)
 {
-	return sys_setuid(low2highuid(uid));
+	return __sys_setuid(low2highuid(uid));
 }
 
 SYSCALL_DEFINE3(setresuid16, old_uid_t, ruid, old_uid_t, euid, old_uid_t, suid)
 {
-	return sys_setresuid(low2highuid(ruid), low2highuid(euid),
+	return __sys_setresuid(low2highuid(ruid), low2highuid(euid),
 				 low2highuid(suid));
 }
 
@@ -78,11 +80,10 @@ SYSCALL_DEFINE3(getresuid16, old_uid_t __user *, ruidp, old_uid_t __user *, euid
 
 SYSCALL_DEFINE3(setresgid16, old_gid_t, rgid, old_gid_t, egid, old_gid_t, sgid)
 {
-	return sys_setresgid(low2highgid(rgid), low2highgid(egid),
+	return __sys_setresgid(low2highgid(rgid), low2highgid(egid),
 				 low2highgid(sgid));
 }
 
-
 SYSCALL_DEFINE3(getresgid16, old_gid_t __user *, rgidp, old_gid_t __user *, egidp, old_gid_t __user *, sgidp)
 {
 	const struct cred *cred = current_cred();
@@ -102,12 +103,12 @@ SYSCALL_DEFINE3(getresgid16, old_gid_t __user *, rgidp, old_gid_t __user *, egid
 
 SYSCALL_DEFINE1(setfsuid16, old_uid_t, uid)
 {
-	return sys_setfsuid(low2highuid(uid));
+	return __sys_setfsuid(low2highuid(uid));
 }
 
 SYSCALL_DEFINE1(setfsgid16, old_gid_t, gid)
 {
-	return sys_setfsgid(low2highgid(gid));
+	return __sys_setfsgid(low2highgid(gid));
 }
 
 static int groups16_to_user(old_gid_t __user *grouplist,
diff --git a/kernel/uid16.h b/kernel/uid16.h
new file mode 100644
index 000000000000..cdca040f7602
--- /dev/null
+++ b/kernel/uid16.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_UID16_H
+#define LINUX_UID16_H
+
+long __sys_setuid(uid_t uid);
+long __sys_setgid(gid_t gid);
+long __sys_setreuid(uid_t ruid, uid_t euid);
+long __sys_setregid(gid_t rgid, gid_t egid);
+long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid);
+long __sys_setresgid(gid_t rgid, gid_t egid, gid_t sgid);
+long __sys_setfsuid(uid_t uid);
+long __sys_setfsgid(gid_t gid);
+
+#endif /* LINUX_UID16_H */
-- 
2.16.2
