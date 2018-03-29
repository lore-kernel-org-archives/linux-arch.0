From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 065/109] fs/quota: use COMPAT_SYSCALL_DEFINE for sys32_quotactl()
Date: Thu, 29 Mar 2018 13:23:42 +0200
Message-ID: <20180329112426.23043-66-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
List-Id: linux-arch.vger.kernel.org

While sys32_quotactl() is only needed on x86, it can use the recommended
COMPAT_SYSCALL_DEFINEx() machinery for its setup.

Acked-by: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
 fs/quota/compat.c                      | 5 +++--
 include/linux/compat.h                 | 3 +++
 include/linux/syscalls.h               | 2 --
 kernel/sys_ni.c                        | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ef6edaf285cd..c58f75b088c5 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -137,7 +137,7 @@
 128	i386	init_module		sys_init_module
 129	i386	delete_module		sys_delete_module
 130	i386	get_kernel_syms
-131	i386	quotactl		sys_quotactl			sys32_quotactl
+131	i386	quotactl		sys_quotactl			compat_sys_quotactl32
 132	i386	getpgid			sys_getpgid
 133	i386	fchdir			sys_fchdir
 134	i386	bdflush			sys_bdflush
diff --git a/fs/quota/compat.c b/fs/quota/compat.c
index 1577a2fd51f4..c30572857619 100644
--- a/fs/quota/compat.c
+++ b/fs/quota/compat.c
@@ -41,8 +41,9 @@ struct compat_fs_quota_stat {
 	__u16		qs_iwarnlimit;
 };
 
-asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
-						qid_t id, void __user *addr)
+COMPAT_SYSCALL_DEFINE4(quotactl32, unsigned int, cmd,
+		       const char __user *, special, qid_t, id,
+		       void __user *, addr)
 {
 	unsigned int cmds;
 	struct if_dqblk __user *dqblk;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 16c3027074a2..f1649a5e6716 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -461,6 +461,9 @@ asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
 		const struct compat_iovec __user *vec,
 		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
 
+asmlinkage long compat_sys_quotactl32(unsigned int cmd,
+		const char __user *special, qid_t id, void __user *addr);
+
 #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
 asmlinkage long compat_sys_preadv64(unsigned long fd,
 		const struct compat_iovec __user *vec,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a63e21e7a3af..6ab7ed71a8b6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -241,8 +241,6 @@ static inline void addr_limit_user_check(void)
 #endif
 }
 
-asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
-			       qid_t id, void __user *addr);
 asmlinkage long sys_time(time_t __user *tloc);
 asmlinkage long sys_stime(time_t __user *tptr);
 asmlinkage long sys_gettimeofday(struct timeval __user *tv,
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index b5189762d275..951dbda5c2b4 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -18,7 +18,7 @@ asmlinkage long sys_ni_syscall(void)
 }
 
 cond_syscall(sys_quotactl);
-cond_syscall(sys32_quotactl);
+cond_syscall(compat_sys_quotactl32);
 cond_syscall(sys_acct);
 cond_syscall(sys_lookup_dcookie);
 cond_syscall(compat_sys_lookup_dcookie);
-- 
2.16.3
