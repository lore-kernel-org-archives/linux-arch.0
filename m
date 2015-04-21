Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:55376 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbDUO7K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2015 10:59:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Y2038] [PATCH 04/11] posix timers:Introduce the 64bit methods with timespec64 type for k_clock structure
Date: Tue, 21 Apr 2015 16:57:18 +0200
Message-ID: <3231171.5TrYVVBLh4@wuerfel>
In-Reply-To: <alpine.DEB.2.11.1504211528040.13914@nanos>
References: <1429509459-17068-1-git-send-email-baolin.wang@linaro.org> <3755355.Xf0HbltZXg@wuerfel> <alpine.DEB.2.11.1504211528040.13914@nanos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038@lists.linaro.org, Baolin Wang <baolin.wang@linaro.org>, pang.xunlei@linaro.org, peterz@infradead.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, paulus@samba.org, cl@linux.com, heenasirwani@gmail.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, mpe@ellerman.id.au, rafael.j.wysocki@intel.com, ahh@google.com, fweisbec@gmail.com, pjt@google.com, riel@redhat.com, richardcochran@gmail.com, schwidefsky@de.ibm.com, john.stultz@linaro.org, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <20150421145718.UmGPYBKOkWyKdATN_0Ka6zpPRJXvtOgp71sIREpT-Is@z>

On Tuesday 21 April 2015 16:14:26 Thomas Gleixner wrote:
> > Note the use of a separate __kernel_itimerspec64 for the user interface
> > here, which I think will be needed to hide the differences between the
> > normal itimerspec on 64-bit machines, and the new itimerspec on 32-bit
> > platforms that will be defined differently (using 'long long').
> 
> Confused.
> 
> timespec64 / itimerspec64 should be the same independent of 64bit and
> 32bit. So why do we need another variant ?

There are multiple reasons:

* On 64-bit systems, timespec64 would always be defined in the same way
  as struct timespec { __kernel_time_t tv_sec; long tv_nsec; }, with
  __kernel_time_t being 'long'. On 32-bit, we probably need to make both
  members 'long long' for the user space side, in order to share the
  syscall implementation with the kernel side, but we may also want to
  keep the internal timespec64 using a 'long' for tv_nsec, as we do
  today. This means that both the binary layout (padding or no padding)
  and the basic types (long or long long) are different between 32-bit
  and 64-bit, and between kernel and user space
* We should not put 'struct timespec64' into the user space namespace,
  as applications might already use that identifier. This is similar
  to the __u32/u32 or __kernel_time_t/time_t tuple of types for interface
  and in-kernel uses. This is particularly important when embedding a
  timespec in another data structure.
* My plan is to use a temporary hack where I actually define
  __kernel_timespec64 to look like the 32-bit version of timespec,
  as an intermediate step when converting all 32-bit architectures over
  to use the compat_*() syscalls in place of the existing ones, so
  I can change over the normal syscalls to use __kernel_timespec64
  without having to change all architectures at once, or having to
  modify each syscall multiple times.

> > I would also prefer not too many people to work on the syscalls, and
> > would rather have Baolin not touch any of the syscall prototypes for
> > the moment.
> 
> I did not ask him to change any of the syscall prototypes. I just
> wanted him to split out the guts of the syscall into a seperate static
> function to avoid all that code churn.

Ok, I wasn't sure about that part, thanks for clarifying.

	Arnd
