From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 16/45] inotify: add do_inotify_init() helper; remove
 in-kernel call to syscall
Date: Mon, 26 Mar 2018 14:25:29 +0200
Message-ID: <20180326122529.we33jshyregw37go@quack2.suse.cz>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-17-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322090059.19361-17-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu 22-03-18 10:00:30, Dominik Brodowski wrote:
> Using the inotify-internal do_inotify_init() helper allows us to get rid
> of the in-kernel call to sys_inotify_init1() syscall.
> 
> This patch is part of a series which tries to remove in-kernel calls to
> syscalls. On this basis, the syscall entry path can be streamlined.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/inotify/inotify_user.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 2c908b31d6c9..43c23653ce2e 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -635,7 +635,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
>  
>  
>  /* inotify syscalls */
> -SYSCALL_DEFINE1(inotify_init1, int, flags)
> +static int do_inotify_init(int flags)
>  {
>  	struct fsnotify_group *group;
>  	int ret;
> @@ -660,9 +660,14 @@ SYSCALL_DEFINE1(inotify_init1, int, flags)
>  	return ret;
>  }
>  
> +SYSCALL_DEFINE1(inotify_init1, int, flags)
> +{
> +	return do_inotify_init(flags);
> +}
> +
>  SYSCALL_DEFINE0(inotify_init)
>  {
> -	return sys_inotify_init1(0);
> +	return do_inotify_init(0);
>  }
>  
>  SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
> -- 
> 2.16.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
