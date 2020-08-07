From: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>
Subject: RE: [PATCH 3/3] quota: simplify the quotactl compat handling
Date: Fri, 7 Aug 2020 09:07:06 +0000
Message-ID: <97285a880c434a4ea9072ff1b9c238e7@AcuMS.aculab.com>
References: <20200731122202.213333-1-hch@lst.de>
 <20200731122202.213333-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200731122202.213333-4-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Christoph Hellwig' <hch-jcswGhMUV9g@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jan Kara <jack-IBi9RG/b67k@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Christoph Hellwig
> Sent: 31 July 2020 13:22
>
> Fold the misaligned u64 workarounds into the main quotactl flow instead
> of implementing a separate compat syscall handler.
> 
...
> diff --git a/fs/quota/compat.h b/fs/quota/compat.h
> new file mode 100644
> index 00000000000000..ef7d1e12d650b3
> --- /dev/null
> +++ b/fs/quota/compat.h
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/compat.h>
> +
> +struct compat_if_dqblk {
> +	compat_u64			dqb_bhardlimit;
> +	compat_u64			dqb_bsoftlimit;
> +	compat_u64			dqb_curspace;
> +	compat_u64			dqb_ihardlimit;
> +	compat_u64			dqb_isoftlimit;
> +	compat_u64			dqb_curinodes;
> +	compat_u64			dqb_btime;
> +	compat_u64			dqb_itime;
> +	compat_uint_t			dqb_valid;
> +};
> +
> +struct compat_fs_qfilestat {
> +	compat_u64			dqb_bhardlimit;
> +	compat_u64			qfs_nblks;
> +	compat_uint_t			qfs_nextents;
> +};
> +
> +struct compat_fs_quota_stat {
> +	__s8				qs_version;
> +	__u16				qs_flags;
> +	__s8				qs_pad;
> +	struct compat_fs_qfilestat	qs_uquota;
> +	struct compat_fs_qfilestat	qs_gquota;
> +	compat_uint_t			qs_incoredqs;
> +	compat_int_t			qs_btimelimit;
> +	compat_int_t			qs_itimelimit;
> +	compat_int_t			qs_rtbtimelimit;
> +	__u16				qs_bwarnlimit;
> +	__u16				qs_iwarnlimit;
> +};
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 5444d3c4d93f37..e1e9d05a14c3e4 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>  #include <linux/writeback.h>
>  #include <linux/nospec.h>
> +#include "compat.h"
> 
>  static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
>  				     qid_t id)
> @@ -211,8 +212,18 @@ static int quota_getquota(struct super_block *sb, int type, qid_t id,
>  	if (ret)
>  		return ret;
>  	copy_to_if_dqblk(&idq, &fdq);
> -	if (copy_to_user(addr, &idq, sizeof(idq)))
> -		return -EFAULT;
> +
> +	if (compat_need_64bit_alignment_fixup()) {
> +		struct compat_if_dqblk __user *compat_dqblk = addr;
> +
> +		if (copy_to_user(compat_dqblk, &idq, sizeof(*compat_dqblk)))
> +			return -EFAULT;
> +		if (put_user(idq.dqb_valid, &compat_dqblk->dqb_valid))
> +			return -EFAULT;

Isn't this always copying the same value again?
I don't think Linux has any 64 bit systems with a 32bit compat
layer that have 64bit 'int'.
Since the only difference in the structures is the 'end padding'
isn't it enough to just copy the size of the 'compat' structure
in a compat system call?
It might even be that gcc will optimise the condition away
when the structure sizes match.

The same is true for a lot of the rest of this file.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
