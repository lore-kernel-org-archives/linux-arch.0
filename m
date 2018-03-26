From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 19/45] fs/quota: use COMPAT_SYSCALL_DEFINE for
 sys32_quotactl()
Date: Mon, 26 Mar 2018 14:33:24 +0200
Message-ID: <20180326123324.rmjtr5fkdodojvb3@quack2.suse.cz>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-20-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322090059.19361-20-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu 22-03-18 10:00:33, Dominik Brodowski wrote:
> While sys32_quotactl() is only needed on x86, it can use the recommended
> COMPAT_SYSCALL_DEFINEx() machinery for its setup.
> 
> Cc: Jan Kara <jack@suse.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Looks good AFAICT. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
>  fs/quota/compat.c                      | 5 +++--
>  include/linux/compat.h                 | 3 +++
>  include/linux/syscalls.h               | 4 +---
>  kernel/sys_ni.c                        | 2 +-
>  5 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 2a5e99cff859..09338dd2bd94 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -137,7 +137,7 @@
>  128	i386	init_module		sys_init_module
>  129	i386	delete_module		sys_delete_module
>  130	i386	get_kernel_syms
> -131	i386	quotactl		sys_quotactl			sys32_quotactl
> +131	i386	quotactl		sys_quotactl			compat_sys_quotactl32
>  132	i386	getpgid			sys_getpgid
>  133	i386	fchdir			sys_fchdir
>  134	i386	bdflush			sys_bdflush
> diff --git a/fs/quota/compat.c b/fs/quota/compat.c
> index 1577a2fd51f4..c30572857619 100644
> --- a/fs/quota/compat.c
> +++ b/fs/quota/compat.c
> @@ -41,8 +41,9 @@ struct compat_fs_quota_stat {
>  	__u16		qs_iwarnlimit;
>  };
>  
> -asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
> -						qid_t id, void __user *addr)
> +COMPAT_SYSCALL_DEFINE4(quotactl32, unsigned int, cmd,
> +		       const char __user *, special, qid_t, id,
> +		       void __user *, addr)
>  {
>  	unsigned int cmds;
>  	struct if_dqblk __user *dqblk;
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 16c3027074a2..f1649a5e6716 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -461,6 +461,9 @@ asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
>  		const struct compat_iovec __user *vec,
>  		compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
>  
> +asmlinkage long compat_sys_quotactl32(unsigned int cmd,
> +		const char __user *special, qid_t id, void __user *addr);
> +
>  #ifdef __ARCH_WANT_COMPAT_SYS_PREADV64
>  asmlinkage long compat_sys_preadv64(unsigned long fd,
>  		const struct compat_iovec __user *vec,
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f30083190ae4..a3f42f5f3b08 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -241,8 +241,6 @@ static inline void addr_limit_user_check(void)
>  #endif
>  }
>  
> -asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
> -			       qid_t id, void __user *addr);
>  asmlinkage long sys_time(time_t __user *tloc);
>  asmlinkage long sys_stime(time_t __user *tptr);
>  asmlinkage long sys_gettimeofday(struct timeval __user *tv,
> @@ -625,7 +623,7 @@ asmlinkage long sys_chdir(const char __user *filename);
>  asmlinkage long sys_fchdir(unsigned int fd);
>  asmlinkage long sys_rmdir(const char __user *pathname);
>  asmlinkage long sys_lookup_dcookie(u64 cookie64, char __user *buf, size_t len);
> -asmlinkage long sys_quotactl(unsigned int cmd, const char __user *special,
> +asmlinkage long sys_quotactl32(unsigned int cmd, const char __user *special,
>  				qid_t id, void __user *addr);
>  asmlinkage long sys_getdents(unsigned int fd,
>  				struct linux_dirent __user *dirent,
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index b5189762d275..951dbda5c2b4 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -18,7 +18,7 @@ asmlinkage long sys_ni_syscall(void)
>  }
>  
>  cond_syscall(sys_quotactl);
> -cond_syscall(sys32_quotactl);
> +cond_syscall(compat_sys_quotactl32);
>  cond_syscall(sys_acct);
>  cond_syscall(sys_lookup_dcookie);
>  cond_syscall(compat_sys_lookup_dcookie);
> -- 
> 2.16.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
