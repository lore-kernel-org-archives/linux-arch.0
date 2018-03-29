From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 064/109] fs/quota: add kernel_quotactl() helper; remove in-kernel call to syscall
Date: Thu, 29 Mar 2018 13:23:41 +0200
Message-ID: <20180329112426.23043-65-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Using the fs-internal kernel_quotactl() helper allows us to get rid of
the fs-internal call to the sys_quotactl() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/quota/compat.c        |  8 ++++----
 fs/quota/quota.c         | 10 ++++++++--
 include/linux/quotaops.h |  3 +++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/quota/compat.c b/fs/quota/compat.c
index 779caed4f078..1577a2fd51f4 100644
--- a/fs/quota/compat.c
+++ b/fs/quota/compat.c
@@ -59,7 +59,7 @@ asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
 	case Q_GETQUOTA:
 		dqblk = compat_alloc_user_space(sizeof(struct if_dqblk));
 		compat_dqblk = addr;
-		ret = sys_quotactl(cmd, special, id, dqblk);
+		ret = kernel_quotactl(cmd, special, id, dqblk);
 		if (ret)
 			break;
 		if (copy_in_user(compat_dqblk, dqblk, sizeof(*compat_dqblk)) ||
@@ -75,12 +75,12 @@ asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
 			get_user(data, &compat_dqblk->dqb_valid) ||
 			put_user(data, &dqblk->dqb_valid))
 			break;
-		ret = sys_quotactl(cmd, special, id, dqblk);
+		ret = kernel_quotactl(cmd, special, id, dqblk);
 		break;
 	case Q_XGETQSTAT:
 		fsqstat = compat_alloc_user_space(sizeof(struct fs_quota_stat));
 		compat_fsqstat = addr;
-		ret = sys_quotactl(cmd, special, id, fsqstat);
+		ret = kernel_quotactl(cmd, special, id, fsqstat);
 		if (ret)
 			break;
 		ret = -EFAULT;
@@ -113,7 +113,7 @@ asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
 		ret = 0;
 		break;
 	default:
-		ret = sys_quotactl(cmd, special, id, addr);
+		ret = kernel_quotactl(cmd, special, id, addr);
 	}
 	return ret;
 }
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 43612e2a73af..860bfbe7a07a 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -833,8 +833,8 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
  * calls. Maybe we need to add the process quotas etc. in the future,
  * but we probably should use rlimits for that.
  */
-SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
-		qid_t, id, void __user *, addr)
+int kernel_quotactl(unsigned int cmd, const char __user *special,
+		    qid_t id, void __user *addr)
 {
 	uint cmds, type;
 	struct super_block *sb = NULL;
@@ -885,3 +885,9 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
 		path_put(pathp);
 	return ret;
 }
+
+SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
+		qid_t, id, void __user *, addr)
+{
+	return kernel_quotactl(cmd, special, id, addr);
+}
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 2fb6fb11132e..dc905a4ff8d7 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -27,6 +27,9 @@ static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
 		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
 }
 
+int kernel_quotactl(unsigned int cmd, const char __user *special,
+		    qid_t id, void __user *addr);
+
 #if defined(CONFIG_QUOTA)
 
 #define quota_error(sb, fmt, args...) \
-- 
2.16.3
