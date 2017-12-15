From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v2 07/10] include: Add new y2038 safe
 __kernel_timespec
Date: Fri, 15 Dec 2017 00:11:38 +0000
Message-ID: <1513296698.18523.291.camel@codethink.co.uk>
References: <20171127193037.8711-1-deepa.kernel@gmail.com>
         <20171127193037.8711-8-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:35458 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbdLOALo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Dec 2017 19:11:44 -0500
In-Reply-To: <20171127193037.8711-8-deepa.kernel@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de, john.stultz@linaro.org
Cc: y2038@lists.linaro.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On Mon, 2017-11-27 at 11:30 -0800, Deepa Dinamani wrote:
> The new struct __kernel_timespec is similar to current
> internal kernel struct timespec64 on 64 bit architecture.
> The compat structure however is similar to below on little
> endian systems (padding and tv_nsec are switched for big
> endian systems):
> 
> typedef s32            compat_long_t;
> typedef s64            compat_kernel_time64_t;
> 
> struct compat_kernel_timespec {
>        compat_kernel_time64_t  tv_sec;
>        compat_long_t           tv_nsec;
>        compat_long_t           padding;
> };
> 
> This allows for both the native and compat representations to
> be the same and syscalls using this type as part of their ABI
> can have a single entry point to both.
> 
> Note that the compat define is not included anywhere in the
> kernel explicitly to avoid confusion.

If I understand correctly, the intent here is that C libraries will be
allowed to define struct timespec like that when appropriate feature
macros are enabled.  Could you spell that out in the commit message,
and also the need to clear padding on the kernel side?

[...]
> --- a/include/uapi/linux/time.h
> +++ b/include/uapi/linux/time.h
> @@ -42,6 +42,13 @@ struct itimerval {
> > >  	struct timeval it_value;	/* current value */
>  };
>  
> +#ifndef __kernel_timespec
> +struct __kernel_timespec {
> +	__kernel_time64_t       tv_sec;                 /* seconds */
> +	long long               tv_nsec;                /* nanoseconds */
> +};
> +#endif

I wonder if it makes sense to override the alignment of this structure?
 (64-bit types are aligned differently on 32-bit vs 64-bit x86, but not
other compat cases.)  It might reduce the need for conversions in
compat code elsewhere later.

Ben.

>  /*
>   * The IDs of the various system clocks (for POSIX.1b interval timers):
>   */
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
