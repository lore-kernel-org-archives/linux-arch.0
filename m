From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 18/45] fs/quota: add kernel_quotactl() helper; remove
 in-kernel call to syscall
Date: Mon, 26 Mar 2018 14:26:49 +0200
Message-ID: <20180326122648.3ljvwroa4e3zuq33@quack2.suse.cz>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-19-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322090059.19361-19-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, Jan Kara <jack@suse.com>
List-Id: linux-arch.vger.kernel.org

On Thu 22-03-18 10:00:32, Dominik Brodowski wrote:
> Using the fs-internal kernel_quotactl() helper allows us to get rid of
> the fs-internal call to the sys_quotactl() syscall.
> 
> This patch is part of a series which tries to remove in-kernel calls to
> syscalls. On this basis, the syscall entry path can be streamlined.
> 
> Cc: Jan Kara <jack@suse.com>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/quota/compat.c        |  8 ++++----
>  fs/quota/quota.c         | 10 ++++++++--
>  include/linux/quotaops.h |  3 +++
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/quota/compat.c b/fs/quota/compat.c
> index 779caed4f078..1577a2fd51f4 100644
> --- a/fs/quota/compat.c
> +++ b/fs/quota/compat.c
> @@ -59,7 +59,7 @@ asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
>  	case Q_GETQUOTA:
>  		dqblk = compat_alloc_user_space(sizeof(struct if_dqblk));
>  		compat_dqblk = addr;
> -		ret = sys_quotactl(cmd, special, id, dqblk);
> +		ret = kernel_quotactl(cmd, special, id, dqblk);
>  		if (ret)
>  			break;
>  		if (copy_in_user(compat_dqblk, dqblk, sizeof(*compat_dqblk)) ||
> @@ -75,12 +75,12 @@ asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
>  			get_user(data, &compat_dqblk->dqb_valid) ||
>  			put_user(data, &dqblk->dqb_valid))
>  			break;
> -		ret = sys_quotactl(cmd, special, id, dqblk);
> +		ret = kernel_quotactl(cmd, special, id, dqblk);
>  		break;
>  	case Q_XGETQSTAT:
>  		fsqstat = compat_alloc_user_space(sizeof(struct fs_quota_stat));
>  		compat_fsqstat = addr;
> -		ret = sys_quotactl(cmd, special, id, fsqstat);
> +		ret = kernel_quotactl(cmd, special, id, fsqstat);
>  		if (ret)
>  			break;
>  		ret = -EFAULT;
> @@ -113,7 +113,7 @@ asmlinkage long sys32_quotactl(unsigned int cmd, const char __user *special,
>  		ret = 0;
>  		break;
>  	default:
> -		ret = sys_quotactl(cmd, special, id, addr);
> +		ret = kernel_quotactl(cmd, special, id, addr);
>  	}
>  	return ret;
>  }
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 43612e2a73af..860bfbe7a07a 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -833,8 +833,8 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>   * calls. Maybe we need to add the process quotas etc. in the future,
>   * but we probably should use rlimits for that.
>   */
> -SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
> -		qid_t, id, void __user *, addr)
> +int kernel_quotactl(unsigned int cmd, const char __user *special,
> +		    qid_t id, void __user *addr)
>  {
>  	uint cmds, type;
>  	struct super_block *sb = NULL;
> @@ -885,3 +885,9 @@ SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
>  		path_put(pathp);
>  	return ret;
>  }
> +
> +SYSCALL_DEFINE4(quotactl, unsigned int, cmd, const char __user *, special,
> +		qid_t, id, void __user *, addr)
> +{
> +	return kernel_quotactl(cmd, special, id, addr);
> +}
> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
> index 2fb6fb11132e..ff63eac16a79 100644
> --- a/include/linux/quotaops.h
> +++ b/include/linux/quotaops.h
> @@ -105,6 +105,9 @@ int dquot_set_dqblk(struct super_block *sb, struct kqid id,
>  int __dquot_transfer(struct inode *inode, struct dquot **transfer_to);
>  int dquot_transfer(struct inode *inode, struct iattr *iattr);
>  
> +int kernel_quotactl(unsigned int cmd, const char __user *special,
> +		    qid_t id, void __user *addr);
> +
>  static inline struct mem_dqinfo *sb_dqinfo(struct super_block *sb, int type)
>  {
>  	return sb_dqopt(sb)->info + type;
> -- 
> 2.16.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
