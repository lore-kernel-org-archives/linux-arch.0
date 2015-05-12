Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51584 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbbELJlD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 May 2015 05:41:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/22] Convert the posix_clock_operations and k_clock structure to ready for 2038
Date: Tue, 12 May 2015 11:39:36 +0200
Message-ID: <2293496.0Ycckx2zYU@wuerfel>
In-Reply-To: <1431342518-29362-1-git-send-email-baolin.wang@linaro.org>
References: <1431342518-29362-1-git-send-email-baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Baolin Wang <baolin.wang@linaro.org>, tglx@linutronix.de, pang.xunlei@linaro.org, peterz@infradead.org, heiko.carstens@de.ibm.com, paulus@samba.org, cl@linux.com, heenasirwani@gmail.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, y2038@lists.linaro.org, rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com, riel@redhat.com, richardcochran@gmail.com, schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com
Message-ID: <20150512093936.xiyAj21VyVIyB7xFcP9nfwEHc7ACOPHSHmfOX2fMpek@z>

On Monday 11 May 2015 19:08:38 Baolin Wang wrote:
> This patch series changes the 32-bit time type (timespec/itimerspec) to the 64-bit one
> (timespec64/itimerspec64), since 32-bit time types will break in the year 2038.
> 
> This patch series introduces new methods with timespec64/itimerspec64 type,
> and removes the old ones with timespec/itimerspec type for posix_clock_operations
> and k_clock structure.
> 
> Also introduces some new functions with timespec64/itimerspec64 type, like current_kernel_time64(),
> hrtimer_get_res64(), cputime_to_timespec64() and timespec64_to_cputime().
> 
> Changes since v2:
>      	-Split the syscall conversion patch into small some patches.
> 
> 
> Baolin Wang (22):
>   linux/time64.h:Introduce the 'struct itimerspec64' for 64bit
>   timekeeping:Introduce the current_kernel_time64() function with
>     timespec64 type
>   time/hrtimer:Introduce hrtimer_get_res64() with timespec64 type for
>     getting the timer resolution
>   posix-timers:Split out the guts of the syscall and change the
>     implementation for timer_gettime
>   posix-timers:Convert to the 64bit methods for the timer_gettime
>     syscall function

I have two more very general comments about the series:

a) something has gone wrong with your submission in v2 and v3 but was
   working earlier: normally all emails should be sent by git-send-email
   as replies to the [patch 00/22] mail. This is the default, and it
   is enabled by the '--thread --no-chain-reply' options. Please try
   to get this to work again.

b) it would be better to have a little shorter subject lines, to avoid
   line-wrapping in the list above. Here are some examples what you could
   use to replace the lines above:

   timekeeping: introduce struct itimerspec64
   timekeeping: introduce current_kernel_time64()
   hrtimer: introduce hrtimer_get_res64() 
   posix-timers: split up sys_timer_gettime()
   posix-timers: convert timer_gettime() to timespec64

   In general, try to come up with the shortest description that
   uniquely describes what your patch does, and move any details into
   the longer patch description.

	Arnd
