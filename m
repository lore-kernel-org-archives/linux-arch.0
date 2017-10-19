From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4][PoC][RFC] Add rlimit-events framework
Date: Thu, 19 Oct 2017 09:41:18 +0200
Message-ID: <20171019074118.GD20787@kroah.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
 <CGME20171018203333epcas1p3d8dd8f3a755cb6ee8e9dde63cb91851b@epcas1p3.samsung.com>
 <20171018203230.29871-3-k.opasiak@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171018203230.29871-3-k.opasiak@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: viro@zeniv.linux.org.uk, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com
List-Id: linux-arch.vger.kernel.org

Meta-comments on the code, I'm not commenting on the content, just
normal code review things that I always see in kernel code...

On Wed, Oct 18, 2017 at 10:32:28PM +0200, Krzysztof Opasiak wrote:
> diff --git a/include/linux/rlimit_noti_kern.h b/include/linux/rlimit_noti_kern.h
> new file mode 100644
> index 000000000000..e49fddaa21c0
> --- /dev/null
> +++ b/include/linux/rlimit_noti_kern.h
> @@ -0,0 +1,54 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

I have to ask, do you really mean "any later version" for this, and the
other new files you created?

And, it is nice to use SPDX for new files to identify their license.
It's not that prevelant, but is getting there...

> --- a/include/uapi/linux/netlink.h
> +++ b/include/uapi/linux/netlink.h
> @@ -28,6 +28,7 @@
>  #define NETLINK_RDMA		20
>  #define NETLINK_CRYPTO		21	/* Crypto layer */
>  #define NETLINK_SMC		22	/* SMC monitoring */
> +#define NETLINK_RLIMIT_EVENTS   23      /* rlimit notification */

No tabs?

> --- /dev/null
> +++ b/include/uapi/linux/rlimit_noti.h
> @@ -0,0 +1,71 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

GPLv2+ in a user api header file?  You are really brave :)

> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _UAPI_LINUX_RLIMIT_NOTI_H_
> +#define _UAPI_LINUX_RLIMIT_NOTI_H_
> +
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#include <linux/resource.h>
> +#else
> +#include <stdint.h>
> +#endif
> +
> +#define RLIMIT_GET_NOTI_FD 1000
> +
> +/* ioctl's */
> +#define RLIMIT_ADD_NOTI_LVL 1
> +#define RLIMIT_RM_NOTI_LVL 2
> +
> +#define RLIMIT_SET_NOTI_ALL 3
> +#define RLIMIT_CLEAR_NOTI_ALL 4

No tabs?

> +
> +/*
> + * For future (notify every 5, 10 units change):
> + * #define RLIMIT_SET_NOTI_STEP 5
> + */
> +
> +#define RLIMIT_GET_NOTI_LVLS 6
> +#define RLIMIT_GET_NOTI_LVL_COUNT 7
> +
> +/* Flags for ioctl's */
> +#define RLIMIT_FLAG_NO_INHERIT (1u << 0)
> +
> +/* Event types */
> +enum {
> +	RLIMIT_EVENT_TYPE_RES_CHANGED,
> +	RLIMIT_EVENT_TYPE_MAX
> +};
> +
> +/* TODO take care of padding (packed) */
> +struct rlimit_noti_subject {
> +	pid_t pid;
> +	uint32_t resource;
> +};

For structures that cross the user/kernel boundry, you have to use the
correct variable types.  And that is never "unit32_t" and such, use
"__u32" and the other "__" types.

And are you _sure_ that pid_t is able to be exported to userspace
correctly?

> +
> +struct rlimit_noti_level {
> +	struct rlimit_noti_subject subj;
> +	uint64_t value;

__u64

> +	uint32_t flags;

__u32

And so on for all others.

You don't seem to describe an ioctl here in the "normal" method, but
only use vague numbers up above, that's odd, why?

> diff --git a/init/Kconfig b/init/Kconfig
> index 1d3475fc9496..4bc44fa86640 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -332,6 +332,12 @@ config AUDIT_TREE
>  	depends on AUDITSYSCALL
>  	select FSNOTIFY
>  
> +config RLIMIT_NOTIFICATION
> +       bool "Support fd notifications on given resource usage"
> +       depends on NET
> +       help
> +	Enable this to monitor process resource changes usage via fd.

Mix of tab and spaces :(

thanks,

greg k-h
